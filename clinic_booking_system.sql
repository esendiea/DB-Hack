-- This SQL script creates a database for a clinic booking system.


-- Create the database
CREATE DATABASE IF NOT EXISTS ClinicBookingSystem;
USE ClinicBookingSystem;


-- Table: Departments

CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert sample departments
INSERT INTO Departments (name) VALUES
('General Medicine'),
('Pediatrics'),
('Dermatology'),
('Orthopedics'),
('Dental');


-- Table: Doctors

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Insert sample doctors
INSERT INTO Doctors (name, specialty, department_id) VALUES
('Dr. Alice Kimani', 'General Physician', 1),
('Dr. John Mwangi', 'Child Specialist', 2),
('Dr. Carol Atieno', 'Skin Specialist', 3),
('Dr. Paul Otieno', 'Orthopedic Surgeon', 4),
('Dr. Mercy Wambui', 'Dentist', 5);


-- Table: Patients

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Insert sample patients
INSERT INTO Patients (name, dob, phone, email) VALUES
('Jane Achieng', '1990-05-12', '0712345678', 'jane.achieng@example.com'),
('Brian Omondi', '1985-10-25', '0723456789', 'brian.omondi@example.com'),
('Lucy Wanjiku', '2000-08-15', '0734567890', 'lucy.wanjiku@example.com');


-- Table: Appointments

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Insert sample appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-06-01 10:00:00', 'Scheduled'),
(2, 3, '2025-06-03 14:30:00', 'Scheduled'),
(3, 5, '2025-06-02 09:00:00', 'Completed');


-- Table: Treatments

CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Insert sample treatments
INSERT INTO Treatments (name, description) VALUES
('Teeth Cleaning', 'Routine dental cleaning and polishing'),
('Fracture Treatment', 'Setting and casting of broken bones'),
('Skin Allergy Test', 'Test to identify allergic reactions'),
('Vaccination', 'Immunization for common diseases');


-- Table: Appointment_Treatments

CREATE TABLE Appointment_Treatments (
    appointment_id INT,
    treatment_id INT,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id),
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

-- Insert sample appointment-treatment relations
INSERT INTO Appointment_Treatments (appointment_id, treatment_id) VALUES
(1, 4),
(2, 3),
(3, 1);


-- Table: Payments

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Cash', 'Card', 'M-Pesa'),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert sample payments
INSERT INTO Payments (appointment_id, amount, payment_method) VALUES
(3, 2000.00, 'M-Pesa');

