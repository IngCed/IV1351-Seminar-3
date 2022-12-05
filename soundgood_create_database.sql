CREATE TABLE address (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 street CHAR(200),
 zip VARCHAR(100),
 city CHAR(100)
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE administrative_staff (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 admin_id VARCHAR(100) NOT NULL
);

ALTER TABLE administrative_staff ADD CONSTRAINT PK_administrative_staff PRIMARY KEY (id);


CREATE TABLE email (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(100) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (id);


CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id VARCHAR(100) NOT NULL,
 number_of_lessons INT
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 price VARCHAR(100),
 type VARCHAR(100)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE lease (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lease_start TIMESTAMP(6),
 lease_end TIMESTAMP(6)
);

ALTER TABLE lease ADD CONSTRAINT PK_lease PRIMARY KEY (id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_type VARCHAR(100) NOT NULL,
 difficulty_level VARCHAR(15) NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE phone (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number VARCHAR(100) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (id);


CREATE TABLE place (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 room_number VARCHAR(100) NOT NULL
);

ALTER TABLE place ADD CONSTRAINT PK_place PRIMARY KEY (id);


CREATE TABLE sibling (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id VARCHAR(100)
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id VARCHAR(100) NOT NULL,
 present_skill VARCHAR(500)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_sibling (
 sibling_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (sibling_id,student_id);


CREATE TABLE time_slot (
 time_slot_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time TIMESTAMP(6) NOT NULL,
 administrative_staff_id INT NOT NULL
);

ALTER TABLE time_slot ADD CONSTRAINT PK_time_slot PRIMARY KEY (time_slot_id);


CREATE TABLE time_slot_place (
 place_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time_slot_id INT NOT NULL
);

ALTER TABLE time_slot_place ADD CONSTRAINT PK_time_slot_place PRIMARY KEY (place_id,time_slot_id);


CREATE TABLE booking (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 amount_of_bookings INT NOT NULL,
 administrative_staff_id INT NOT NULL,
 student_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (id);


CREATE TABLE contact_person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 contact_person_id VARCHAR(100),
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 lesson_price VARCHAR(100) NOT NULL,
 enrollment_amount INT NOT NULL,
 min_enrollment_amount INT NOT NULL,
 time_slot_id INT 
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 lesson_price VARCHAR(100) NOT NULL,
 time_slot_id INT 
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 number_of_leases INT NOT NULL,
 administrative_staff_id INT NOT NULL,
 student_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


CREATE TABLE rental_lease (
 lease_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 rental_id INT NOT NULL
);

ALTER TABLE rental_lease ADD CONSTRAINT PK_rental_lease PRIMARY KEY (lease_id,rental_id);


CREATE TABLE contact_details (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 person_number VARCHAR(12) NOT NULL,
 contact_person_id INT,
 student_id INT,
 instructor_id INT,
 address_id INT GENERATED ALWAYS AS IDENTITY
);

ALTER TABLE contact_details ADD CONSTRAINT PK_contact_details PRIMARY KEY (id);


CREATE TABLE contact_details_email (
 email_id INT NOT NULL,
 contact_details_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE contact_details_email ADD CONSTRAINT PK_contact_details_email PRIMARY KEY (email_id,contact_details_id);


CREATE TABLE contact_details_phone (
 phone_id INT NOT NULL,
 contact_details_id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE contact_details_phone ADD CONSTRAINT PK_contact_details_phone PRIMARY KEY (phone_id,contact_details_id);


CREATE TABLE ensemble (
 lesson_id INT NOT NULL,
 lesson_price VARCHAR(100) NOT NULL,
 genre VARCHAR(100),
 min_enrollment_amount INT NOT NULL,
 max_enrollment_amount INT NOT NULL,
 instructor_id INT NOT NULL,
 time_slot_id INT 
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (sibling_id) REFERENCES sibling (id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE time_slot ADD CONSTRAINT FK_time_slot_0 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id);


ALTER TABLE time_slot_place ADD CONSTRAINT FK_time_slot_place_0 FOREIGN KEY (place_id) REFERENCES place (id);
ALTER TABLE time_slot_place ADD CONSTRAINT FK_time_slot_place_1 FOREIGN KEY (time_slot_id) REFERENCES time_slot (time_slot_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (time_slot_id) REFERENCES time_slot (time_slot_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (time_slot_id) REFERENCES time_slot (time_slot_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (administrative_staff_id) REFERENCES administrative_staff (id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_2 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE rental_lease ADD CONSTRAINT FK_rental_lease_0 FOREIGN KEY (lease_id) REFERENCES lease (id);
ALTER TABLE rental_lease ADD CONSTRAINT FK_rental_lease_1 FOREIGN KEY (rental_id) REFERENCES rental (id);


ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_0 FOREIGN KEY (contact_person_id) REFERENCES contact_person (id);
ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_1 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_2 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE contact_details ADD CONSTRAINT FK_contact_details_3 FOREIGN KEY (address_id) REFERENCES address (id);


ALTER TABLE contact_details_email ADD CONSTRAINT FK_contact_details_email_0 FOREIGN KEY (email_id) REFERENCES email (id);
ALTER TABLE contact_details_email ADD CONSTRAINT FK_contact_details_email_1 FOREIGN KEY (contact_details_id) REFERENCES contact_details (id);


ALTER TABLE contact_details_phone ADD CONSTRAINT FK_contact_details_phone_0 FOREIGN KEY (phone_id) REFERENCES phone (id);
ALTER TABLE contact_details_phone ADD CONSTRAINT FK_contact_details_phone_1 FOREIGN KEY (contact_details_id) REFERENCES contact_details (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_2 FOREIGN KEY (time_slot_id) REFERENCES time_slot (time_slot_id);

ALTER TABLE email
ADD CONSTRAINT email_unq UNIQUE(email);

ALTER TABLE phone
ADD CONSTRAINT phone_unq UNIQUE(phone_number);

ALTER TABLE student
ADD CONSTRAINT student_unq UNIQUE(student_id);

ALTER TABLE instructor
ADD CONSTRAINT instructor_unq UNIQUE(instructor_id);

ALTER TABLE administrative_staff
ADD CONSTRAINT administrative_staff_unq UNIQUE(admin_id);
