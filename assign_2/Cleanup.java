import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import static java.nio.file.StandardOpenOption.TRUNCATE_EXISTING;
import static java.nio.file.StandardOpenOption.WRITE;

/*
 * This java program will take a games.csv, clean up duplicate entries,
 * and produce a save.txt with insert statements for the databases.
 */
public class Cleanup {

    public static void main(String[] args) {
        var list = load();
        var inserts = determineInserts(list);
        save(inserts);
    }

    /*
     * This method loads from the csv and cleans up duplicates.
     */
    private static List<String> load() {
        var file = "games.csv";
        var set = new HashSet<String>();
        var list = new ArrayList<String>();
        try (var in = Files.newInputStream(Paths.get(file));
             var reader = new BufferedReader(new InputStreamReader(in))) {
            String line;
            reader.readLine();
            while ((line = reader.readLine()) != null) {
                var values = line.split(",");
                if (values.length != 16) {
                    throw new IllegalStateException("Incomplete entry");
                }
                if (!set.contains(values[0])) {
                    list.add(line);
                    set.add(values[0]);
                }
            }
        } catch (IOException e) {
            throw new IllegalStateException("Could not open file");
        }
        return list;
    }

    /*
     * This method creates the insert statements.
     */
    private static List<String> determineInserts(List<String> list) {
        var main = new ArrayList<String>();
        var rating = new ArrayList<String>();
        var ply = new ArrayList<String>();
        main.add("BEGIN;");
        rating.add("BEGIN;");
        ply.add("BEGIN;");
        for (var str : list) {
            var values = str.split(",");
            for (int i = 0; i < values.length; i++) {
                if (i == 1 || i == 7 || i == 12) {
                    continue;
                }
                values[i] = '"' + values[i] + '"';
            }
            var mainCommand = "INSERT INTO Main(gameID, rated, createdAt, lastMoveAt, turns, victoryStatus, winner, "
                    + "timePerPlayerMin, incrementSec, whiteID, blackID, openingEco, openingName, openingPly) "
                    + mainTable(values) + ';';
            main.add(mainCommand);
            var ratingCommandWhite = "INSERT INTO Rating(gameID, playerID, rating) VALUES("
                    + values[0] + ',' + values[8] + ',' + values[9] + ");";
            rating.add(ratingCommandWhite);
            if (!values[8].equals(values[10])) {
                var ratingCommandBlack = "INSERT INTO Rating(gameID, playerID, rating) VALUES("
                        + values[0] + ',' + values[10] + ',' + values[11] + ");";
                rating.add(ratingCommandBlack);
            }
            var moves = values[12].split(" ");
            for (int n = 1; n <= moves.length; n++) {
                var plyCommand = "INSERT INTO Ply(gameID, turn, move) VALUES("
                        + values[0] + ",\"" + n + "\",\"" + moves[n - 1] + "\");";
                ply.add(plyCommand);
            }
        }
        main.add("COMMIT;");
        rating.add("COMMIT;");
        ply.add("COMMIT;");
        main.add("");
        main.addAll(rating);
        main.add("");
        main.addAll(ply);
        return main;
    }

    private static String mainTable(String[] values) {
        var code = values[7].split("\\+");
        code[0] = "'" + code[0] + "'";
        code[1] = "'" + code[1] + "'";
        if (code.length != 2) {
            throw new IllegalStateException("Bad time code");
        }
        return "VALUES(" + values[0] + ',' + values[1] + ',' + values[2] + ',' + values[3] + ',' + values[4] + ','
                + values[5] + ',' + values[6] + ',' + code[0] + ',' + code[1] + ',' + values[8] + ','
                + values[10] + ',' + values[13] + ',' + values[14] + ',' + values[15] + ')';
    }

    /*
     * This method writes to the output file.
     */
    static void save(List<String> list) {
        var file = "save.txt";
        var saveFile = new StringBuilder();
        for (var state : list) {
            saveFile.append(state);
            saveFile.append('\n');
        }
        var data = saveFile.toString().getBytes();
        try {
            var save = new File(file);
            if (!save.exists()) {
                Files.createFile(Paths.get(file));
            }
        } catch (IOException e) {
            throw new IllegalStateException("Could not access or create file");
        }
        try (var output = Files.newOutputStream(Paths.get(file), WRITE, TRUNCATE_EXISTING);
             var out = new BufferedOutputStream(output)) {
            out.write(data, 0, data.length);
        } catch (IOException e) {
            throw new IllegalStateException("Could not open or write to file");
        }
    }
}
