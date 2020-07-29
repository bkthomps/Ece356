USE university;

BEGIN; update Offering set Enrollment = Enrollment - 20 where courseID="ECE356" and section=2 and termCode=1191;
update Offering set Enrollment = Enrollment + 20 where courseID="ECE356" and section=2 and termCode=1191; COMMIT;
