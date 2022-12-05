/**/

SELECT  (
        SELECT COUNT(*)
        FROM   lesson
        ) AS lesson,
        (
        SELECT COUNT(*)
        FROM   individual_lesson
        ) AS individual_lesson,
        (
        SELECT COUNT(*)
        FROM   group_lesson
        ) AS group_lesson,        
        (
        SELECT COUNT(*)
        FROM   ensemble
        ) AS ensemble;

/**/
  
SELECT (
  SELECT COUNT(*) FROM student) - (SELECT COUNT(DISTINCT sibling_id) FROM student_sibling INNER JOIN student ON 
  student.id=student_sibling.student_id
  ) AS no_siblings,
  (
  SELECT count(*) FROM (SELECT student_id FROM (SELECT student.id,student.student_id FROM student_sibling INNER JOIN student ON 
  student.id=student_sibling.student_id) as tempTable group by student_id having count (student_id)<2)as tempTable2
  ) AS one_sibling,
  (
  SELECT count(*) FROM (SELECT student_id FROM (SELECT student.id,student.student_id FROM student_sibling INNER JOIN student ON 
  student.id=student_sibling.student_id) as tempTable group by student_id having count (student_id)>1)as tempTable2) AS two_siblings;

/**/
SELECT * FROM(select instructor.id AS instructor_id,instructor.instructor_id AS instructor_id_with_more_than_one_lesson FROM lesson 
INNER JOIN instructor ON lesson.instructor_id=instructor.id) as tempTable1 group by instructor_id,instructor_id_with_more_than_one_lesson 
having count (instructor_id_with_more_than_one_lesson)>1 ORDER BY instructor_id;

SELECT id AS instructor_id, count(instructor_id)+count(instructor_id_with_more_than_one_lesson) AS number_of_given_lessons FROM 
(SELECT DISTINCT * FROM (select instructor.id,instructor.instructor_id FROM lesson INNER JOIN instructor ON 
lesson.instructor_id=instructor.id) AS table1 FULL OUTER JOIN (SELECT * FROM(select instructor.id AS id_with_more_than_one_lesson,
instructor.instructor_id AS instructor_id_with_more_than_one_lesson FROM lesson INNER JOIN instructor ON 
lesson.instructor_id=instructor.id) as tempTable1 group by id_with_more_than_one_lesson,instructor_id_with_more_than_one_lesson having 
count (instructor_id_with_more_than_one_lesson)>1) AS table2 ON id=id_with_more_than_one_lesson)AS tableTest group by id order by 
number_of_given_lessons DESC, instructor_id;
/**/

select lesson_id AS ensemble_id,genre,enrollment_amount,max_enrollment_amount,time_slot_id,time from (select tempTable1.lesson_id,
tempTable1.genre,tempTable1.enrollment_amount,tempTable1.max_enrollment_amount,tempTable1.time_slot_id,time from time_slot inner join 
(SELECT ensemble.lesson_id,ensemble.genre,group_lesson.enrollment_amount,ensemble.max_enrollment_amount,ensemble.time_slot_id 
FROM ensemble INNER JOIN group_lesson ON ensemble.lesson_id=group_lesson.lesson_id) as tempTable1 ON 
time_slot.time_slot_id=tempTable1.time_slot_id) AS tempTable2 WHERE time BETWEEN '2022-12-05 00:00:01' AND '2022-12-12 23:59:59' 
ORDER BY time ASC, genre;

select lesson_id AS ensemble_id_with_more_than_two_seats from (select lesson_id,enrollment_amount,max_enrollment_amount from 
(select tempTable1.lesson_id,tempTable1.genre,tempTable1.enrollment_amount,tempTable1.max_enrollment_amount,tempTable1.time_slot_id,time 
from time_slot inner join (SELECT ensemble.lesson_id,ensemble.genre,group_lesson.enrollment_amount,ensemble.max_enrollment_amount,
ensemble.time_slot_id  FROM ensemble INNER JOIN group_lesson ON ensemble.lesson_id=group_lesson.lesson_id) as tempTable1 ON 
time_slot.time_slot_id=tempTable1.time_slot_id) AS tempTable2 WHERE time BETWEEN '2022-12-05 00:00:01' AND '2022-12-12 23:59:59' 
group by lesson_id,enrollment_amount,max_enrollment_amount having max_enrollment_amount-enrollment_amount>2)as tempTable4;

select lesson_id AS ensemble_id_with_one_or_two_seats from (select lesson_id,enrollment_amount,max_enrollment_amount from 
(select tempTable1.lesson_id,tempTable1.genre,tempTable1.enrollment_amount,tempTable1.max_enrollment_amount,tempTable1.time_slot_id,time 
from time_slot inner join (SELECT ensemble.lesson_id,ensemble.genre,group_lesson.enrollment_amount,ensemble.max_enrollment_amount,
ensemble.time_slot_id  FROM ensemble INNER JOIN group_lesson ON ensemble.lesson_id=group_lesson.lesson_id) as tempTable1 ON 
time_slot.time_slot_id=tempTable1.time_slot_id) AS tempTable2 WHERE time BETWEEN '2022-12-05 00:00:01' AND '2022-12-12 23:59:59' 
group by lesson_id,enrollment_amount,max_enrollment_amount having max_enrollment_amount-enrollment_amount<2 AND 
max_enrollment_amount-enrollment_amount>0)as tempTable4;

select lesson_id AS ensemble_id_which_are_full_booked from (select lesson_id,enrollment_amount,max_enrollment_amount from 
(select tempTable1.lesson_id,tempTable1.genre,tempTable1.enrollment_amount,tempTable1.max_enrollment_amount,tempTable1.time_slot_id,time 
from time_slot inner join (SELECT ensemble.lesson_id,ensemble.genre,group_lesson.enrollment_amount,ensemble.max_enrollment_amount,
ensemble.time_slot_id  FROM ensemble INNER JOIN group_lesson ON ensemble.lesson_id=group_lesson.lesson_id) as tempTable1 ON 
time_slot.time_slot_id=tempTable1.time_slot_id) AS tempTable2 WHERE time BETWEEN '2022-12-05 00:00:01' AND '2022-12-12 23:59:59' 
group by lesson_id,enrollment_amount,max_enrollment_amount having max_enrollment_amount-enrollment_amount<1)as tempTable4;