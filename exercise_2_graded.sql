DROP TABLE IF EXISTS sensors CASCADE;
DROP TABLE IF EXISTS treatments CASCADE;
DROP TABLE IF EXISTS medication_stock CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS nurses CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;

CREATE TABLE doctors (
  doctor_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specialization TEXT NOT NULL
);

CREATE TABLE nurses (
  nurse_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  shift TEXT NOT NULL
);

CREATE TABLE patients (
  patient_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age INT NOT NULL,
  room_no INT NOT NULL,
  doctor_id INT REFERENCES doctors(doctor_id)
);

CREATE TABLE treatments (
  treatment_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id),
  nurse_id INT REFERENCES nurses(nurse_id),
  treatment_type TEXT NOT NULL,
  treatment_time TIMESTAMP NOT NULL
);

CREATE TABLE sensors (
  sensor_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id),
  sensor_type TEXT NOT NULL,
  reading NUMERIC NOT NULL,
  reading_time TIMESTAMP NOT NULL
);

CREATE TABLE medication_stock (
  medication_id SERIAL PRIMARY KEY,
  medication_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL
);

-- sample data
INSERT INTO doctors (name, specialization) VALUES
  ('Dr. Smith', 'Geriatrics'),
  ('Dr. Johnson', 'Cardiology'),
  ('Dr. Lee', 'Neurology'),
  ('Dr. Patel', 'Endocrinology'),
  ('Dr. Adams', 'General Medicine');

INSERT INTO nurses (name, shift) VALUES
  ('Nurse Ann', 'Morning'),
  ('Nurse Ben', 'Evening'),
  ('Nurse Eva', 'Night'),
  ('Nurse Kim', 'Morning'),
  ('Nurse Omar', 'Evening'),
  ('Nurse Zara', 'Night');

INSERT INTO patients (name, age, room_no, doctor_id) VALUES
  ('Alice', 82, 101, 1),
  ('Bob', 79, 102, 2),
  ('Carol', 85, 103, 1),
  ('David', 88, 104, 3),
  ('Ella', 77, 105, 2),
  ('Frank', 91, 106, 4);

INSERT INTO treatments (patient_id, nurse_id, treatment_type, treatment_time) VALUES
  (1, 1, 'Physiotherapy', '2025-09-10 09:00:00'),
  (2, 2, 'Medication',     '2025-09-10 18:00:00'),
  (1, 3, 'Medication',     '2025-09-11 21:00:00'),
  (3, 1, 'Checkup',        '2025-09-12 10:00:00'),
  (4, 2, 'Physiotherapy',  '2025-09-12 17:00:00'),
  (5, 5, 'Medication',     '2025-09-12 18:00:00'),
  (6, 4, 'Physiotherapy',  '2025-09-13 09:00:00');

INSERT INTO sensors (patient_id, sensor_type, reading, reading_time) VALUES
  (1, 'HeartRate', 72, '2025-09-13 08:00:00'),
  (2, 'Steps', 1200, '2025-09-13 08:05:00'),
  (1, 'HeartRate', 75, '2025-09-13 12:00:00');

INSERT INTO medication_stock (medication_name, quantity) VALUES
  ('Paracetamol', 50),
  ('Aspirin', 5),
  ('Insulin', 2),
  ('Atorvastatin', 30),
  ('Lisinopril', 15),
  ('Omeprazole', 8);