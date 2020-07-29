USE university;

DROP FUNCTION IF EXISTS switchSection;

DELIMITER $$
CREATE FUNCTION switchSection(
	courseID char(8),
	section1 int,
    section2 int,
    termCode decimal(4),
    quantity int
) RETURNS int
BEGIN
	DECLARE verify int;
	IF quantity <= 0 OR section1 = section2 THEN
		RETURN -1;
	END IF;

	SELECT COUNT(*)
    INTO verify
    FROM Offering
		WHERE Offering.courseID = courseID
			AND Offering.section IN (section1, section2)
			AND Offering.termCode = termCode;
	IF verify != 2 THEN
		RETURN -1;
	END IF;

	SELECT COUNT(*)
    INTO verify
    FROM Offering
		WHERE Offering.courseID = courseID
			AND Offering.section = section1
            AND Offering.termCode = termCode
            AND Offering.enrollment < quantity;
	IF verify != 0 THEN
		RETURN -2;
	END IF;

    SELECT COUNT(*)
    INTO verify
    FROM Offering
    INNER JOIN Classroom USING (roomID)
		WHERE Offering.courseID = courseID
			AND Offering.section = section2
            AND Offering.termCode = termCode
            AND Classroom.capacity < Offering.enrollment + quantity;
	IF verify != 0 THEN
		RETURN -3;
	END IF;

    UPDATE Offering
		SET Offering.enrollment = Offering.enrollment - quantity
        WHERE Offering.courseID = courseID
			AND Offering.section = section1
            AND Offering.termCode = termCode;
	UPDATE Offering
		SET Offering.enrollment = Offering.enrollment + quantity
        WHERE Offering.courseID = courseID
			AND Offering.section = section2
            AND Offering.termCode = termCode;
	RETURN 0;
END$$
DELIMITER ;

SELECT * FROM Offering;
SELECT switchSection('ECE56', 1, 1, 1191, 5); -- Same section -> -1
SELECT switchSection('ECE56', 1, 1, 1191, 0); -- Quantity = 0 -> -1
SELECT switchSection('ECE56', 1, 1, 1191, 5); -- Quantity < 0 -> -1
SELECT switchSection('ECE300', 1, 2, 1191, 5); -- Invalid courseID -> -1
SELECT switchSection('ECE356', 1, 2, 1191, 65); -- Enrollment would go < 0 -> -2
SELECT switchSection('ECE356', 1, 2, 1191, 16); -- Enrollment higher than class size < 0 -> -3
SELECT switchSection('MATH117', 1, 2, 1191, 10); -- Nothing to switch with < 0 -> -1
SELECT * FROM Offering; -- Check with first select to make sure no changes
SELECT switchSection('ECE356', 1, 2, 1191, 15); -- Success -> 0
SELECT * FROM Offering; -- Check that changed
SELECT switchSection('ECE356', 2, 1, 1191, 15); -- Success -> 0
SELECT * FROM Offering; -- Check back to original
