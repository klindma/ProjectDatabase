CREATE TABLE email (
 email VARCHAR(254)
);


CREATE TABLE extraCharge (
 extra_charge_id VARCHAR(10) NOT NULL,
 extra_charge_price VARCHAR(10)
);

ALTER TABLE extraCharge ADD CONSTRAINT PK_extraCharge PRIMARY KEY (extra_charge_id);


CREATE TABLE family (
 family_id VARCHAR(10) NOT NULL,
 sibling_discount BIT(1) NOT NULL,
 discount_price VARCHAR(255),
 parent_email VARCHAR(254),
 parent_phone VARCHAR(20)
);

ALTER TABLE family ADD CONSTRAINT PK_family PRIMARY KEY (family_id);


CREATE TABLE person (
 person_id VARCHAR(10) NOT NULL,
 personal_no VARCHAR(12) NOT NULL,
 first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255) NOT NULL,
 date_of_birth DATE NOT NULL,
 street VARCHAR(255),
 zipcode VARCHAR(5),
 city VARCHAR(255)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE phoneNo (
 phone_number VARCHAR(30)
);


CREATE TABLE student (
 student_id VARCHAR(10) NOT NULL,
 family_id VARCHAR(10),
 person_id VARCHAR(10) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE timeslot (
 timeslot_id VARCHAR(10) NOT NULL,
 start_time TIMESTAMP(0),
 end_time TIMESTAMP(0)
);

ALTER TABLE timeslot ADD CONSTRAINT PK_timeslot PRIMARY KEY (timeslot_id);


CREATE TABLE advancedAudition (
 audution_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 application_date TIMESTAMP(0),
 instrument VARCHAR(255),
 result BIT(1)
);

ALTER TABLE advancedAudition ADD CONSTRAINT PK_advancedAudition PRIMARY KEY (audution_id,student_id);


CREATE TABLE contact (
 contact_id VARCHAR(10) NOT NULL,
 person_id VARCHAR(10) NOT NULL,
 phone_number VARCHAR(50),
 email VARCHAR(254)
);

ALTER TABLE contact ADD CONSTRAINT PK_contact PRIMARY KEY (contact_id,person_id);


CREATE TABLE instructor (
 instructor_id VARCHAR(10) NOT NULL,
 person_id VARCHAR(10) NOT NULL,
 teach_ensamble BIT(1),
 teach_group BIT(1),
 teach_private BIT(1)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id,person_id);


CREATE TABLE instrument (
 instrument_id CHAR(10) NOT NULL,
 instrument_type VARCHAR(255),
 skill_level VARCHAR(255),
 student_id VARCHAR(10),
 instructor_id VARCHAR(10),
 person_id VARCHAR(10)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE payment (
 instructor_id VARCHAR(10),
 person_id VARCHAR(10),
 pay_amount DECIMAL(500)
);


CREATE TABLE rentalInstrument (
 rental_id VARCHAR(10) NOT NULL,
 instrument_type VARCHAR(255),
 rental_price INT,
 brand VARCHAR(10),
 instrument_id VARCHAR(10) NOT NULL,
 rental_fee INT
);

ALTER TABLE rentalInstrument ADD CONSTRAINT PK_rentalInstrument PRIMARY KEY (rental_id);


CREATE TABLE schoolApplication (
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 application_date TIMESTAMP(0) NOT NULL,
 skill_level VARCHAR(10) NOT NULL,
 instrument_type VARCHAR(10) NOT NULL,
 lesson_type VARCHAR(10) NOT NULL,
 genre VARCHAR(10)
);

ALTER TABLE schoolApplication ADD CONSTRAINT PK_schoolApplication PRIMARY KEY (application_id,student_id);


CREATE TABLE ensamble (
 ensamble_id VARCHAR(10) NOT NULL,
 instrument_id VARCHAR(10),
 skill_level VARCHAR(10),
 ensabmle_price VARCHAR(10),
 genre VARCHAR(10),
 min_students INT,
 max_students INT,
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 timeslot_id VARCHAR(10) NOT NULL,
 extra_charge_id VARCHAR(10) NOT NULL,
 price INT,
 instructor_id VARCHAR(10),
 person_id VARCHAR(10)
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (ensamble_id);


CREATE TABLE ensambleInstruments (
 ensamble_instruments_id VARCHAR(10) NOT NULL,
 ensamble_id VARCHAR(10) NOT NULL,
 instrument_type VARCHAR(255),
 max_amount INT,
 min_amount INT
);

ALTER TABLE ensambleInstruments ADD CONSTRAINT PK_ensambleInstruments PRIMARY KEY (ensamble_instruments_id,ensamble_id);


CREATE TABLE groupLesson (
 group_lesson_id VARCHAR(10) NOT NULL,
 instument_id VARCHAR(10),
 skill_level VARCHAR(10),
 group_price VARCHAR(10),
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 timeslot_id VARCHAR(10) NOT NULL,
 extra_charge_id VARCHAR(10) NOT NULL,
 price INT,
 instructor_id VARCHAR(10),
 person_id VARCHAR(10)
);

ALTER TABLE groupLesson ADD CONSTRAINT PK_groupLesson PRIMARY KEY (group_lesson_id);


CREATE TABLE privateLesson (
 private_lesson_id VARCHAR(10) NOT NULL,
 instrument_id VARCHAR(10),
 skill_level VARCHAR(10),
 price_private VARCHAR(10),
 application_id VARCHAR(10) NOT NULL,
 student_id VARCHAR(10) NOT NULL,
 timeslot_id VARCHAR(10) NOT NULL,
 extra_charge_id VARCHAR(10) NOT NULL,
 price INT,
 instructor_id VARCHAR(10),
 person_id VARCHAR(10)
);

ALTER TABLE privateLesson ADD CONSTRAINT PK_privateLesson PRIMARY KEY (private_lesson_id);


CREATE TABLE student_ensamble (
 student_id VARCHAR(10) NOT NULL,
 ensamble_id VARCHAR(10) NOT NULL
);

ALTER TABLE student_ensamble ADD CONSTRAINT PK_student_ensamble PRIMARY KEY (student_id,ensamble_id);


CREATE TABLE student_group (
 student_id VARCHAR(10) NOT NULL,
 group_lesson_id VARCHAR(10) NOT NULL
);

ALTER TABLE student_group ADD CONSTRAINT PK_student_group PRIMARY KEY (student_id,group_lesson_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (family_id) REFERENCES family (family_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE advancedAudition ADD CONSTRAINT FK_advancedAudition_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE contact ADD CONSTRAINT FK_contact_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE instrument ADD CONSTRAINT FK_instrument_1 FOREIGN KEY (instructor_id,person_id) REFERENCES instructor (instructor_id,person_id);


ALTER TABLE payment ADD CONSTRAINT FK_payment_0 FOREIGN KEY (instructor_id,person_id) REFERENCES instructor (instructor_id,person_id);


ALTER TABLE rentalInstrument ADD CONSTRAINT FK_rentalInstrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE schoolApplication ADD CONSTRAINT FK_schoolApplication_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (application_id,student_id) REFERENCES schoolApplication (application_id,student_id);
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_1 FOREIGN KEY (timeslot_id) REFERENCES timeslot (timeslot_id);
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_2 FOREIGN KEY (extra_charge_id) REFERENCES extraCharge (extra_charge_id);
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_3 FOREIGN KEY (instructor_id,person_id) REFERENCES instructor (instructor_id,person_id);


ALTER TABLE ensambleInstruments ADD CONSTRAINT FK_ensambleInstruments_0 FOREIGN KEY (ensamble_id) REFERENCES ensamble (ensamble_id);


ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_0 FOREIGN KEY (application_id,student_id) REFERENCES schoolApplication (application_id,student_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_1 FOREIGN KEY (timeslot_id) REFERENCES timeslot (timeslot_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_2 FOREIGN KEY (extra_charge_id) REFERENCES extraCharge (extra_charge_id);
ALTER TABLE groupLesson ADD CONSTRAINT FK_groupLesson_3 FOREIGN KEY (instructor_id,person_id) REFERENCES instructor (instructor_id,person_id);


ALTER TABLE privateLesson ADD CONSTRAINT FK_privateLesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE privateLesson ADD CONSTRAINT FK_privateLesson_1 FOREIGN KEY (application_id,student_id) REFERENCES schoolApplication (application_id,student_id);
ALTER TABLE privateLesson ADD CONSTRAINT FK_privateLesson_2 FOREIGN KEY (timeslot_id) REFERENCES timeslot (timeslot_id);
ALTER TABLE privateLesson ADD CONSTRAINT FK_privateLesson_3 FOREIGN KEY (extra_charge_id) REFERENCES extraCharge (extra_charge_id);
ALTER TABLE privateLesson ADD CONSTRAINT FK_privateLesson_4 FOREIGN KEY (instructor_id,person_id) REFERENCES instructor (instructor_id,person_id);


ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_1 FOREIGN KEY (ensamble_id) REFERENCES ensamble (ensamble_id);


ALTER TABLE student_group ADD CONSTRAINT FK_student_group_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_group ADD CONSTRAINT FK_student_group_1 FOREIGN KEY (group_lesson_id) REFERENCES groupLesson (group_lesson_id);


