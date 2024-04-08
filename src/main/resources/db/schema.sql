DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS user_info;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS user_info_role;
DROP TABLE IF EXISTS role_authority;




CREATE TABLE IF NOT EXISTS roles (
    role_id BINARY(16) PRIMARY KEY,
    role_name ENUM('ADMIN', 'MANAGER', 'USER', 'GUEST') DEFAULT 'USER'
);

CREATE TABLE IF NOT EXISTS authorities (
    auth_id BINARY(16) PRIMARY KEY,
    authority ENUM('SYSTEM_MANAGEMENT', 'MANAGER_CREATION', 'SECURITY_CONFIGURATION', 'FLEET_MANAGEMENT', 'USER_MANAGEMENT', 'SETTING_RATES_AND_PROMOTIONS', 'SECURITY_MONITORING', 'ANALYTICS_AND_REPORTING', 'CUSTOMER_SUPPORT', 'CAR_RESERVATION', 'CAR_RENTAL', 'PROFILE_MANAGEMENT', 'ACCESS_TO_PROMOTIONS', 'LEAVING_REVIEWS_AND_RATINGS', 'VIEWING_INFORMATION', 'VIEWING_RATES_AND_CONDITIONS', 'CONTACTING_SUPPORT')
);

CREATE TABLE IF NOT EXISTS user_info (
    user_info_id BINARY(16) PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    date_of_birth DATE,
    phone_number VARCHAR(20) UNIQUE,
    email VARCHAR(60) UNIQUE,
    user_password VARCHAR(128) NOT NULL,
    driver_license ENUM('A', 'B', 'C', 'D', 'E')
);


CREATE TABLE IF NOT EXISTS cars (
    car_id BINARY(16) PRIMARY KEY,
    year_of_release VARCHAR(10) NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    current_location POINT NOT NULL,
    car_status ENUM('AVAILABLE', 'RESERVED', 'IN_USE', 'FAULTY', 'UNDER_REPAIR', 'RETURNED', 'BLOCKED', 'UNDER_MAINTENANCE'),
    car_brand ENUM('AUDI', 'CITROEN', 'FORD', 'HONDA', 'HYUNDAI', 'KIA', 'LEXUS', 'MAZDA', 'MERCEDES_BENZ', 'SKODA', 'TESLA', 'TOYOTA', 'VOLKSWAGEN', 'VOLVO')
);

CREATE TABLE IF NOT EXISTS users (
    user_id BINARY(16) PRIMARY KEY,
    user_info_id BINARY(16) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_info_id)
        REFERENCES user_info (user_info_id)
);


CREATE TABLE IF NOT EXISTS trips (
    trip_id BINARY(16) PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    car_id BINARY(16) NOT NULL,
    start_time DATETIME DEFAULT NULL,
    end_time DATETIME DEFAULT NULL,
    distance DOUBLE DEFAULT 0.0,
    cost DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id),
    FOREIGN KEY (car_id)
        REFERENCES cars (car_id)
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id BINARY(16) PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    payment_date DATETIME DEFAULT NULL,
    payment_method ENUM('VISA', 'MASTERCARD', 'AMERICAN_EXPRESS', 'SEPA_DIRECT_DEBIT', 'PAYPAL', 'APPLE_PAY', 'GOOGLE_PAY'),
    payment_status BOOLEAN,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);


CREATE TABLE IF NOT EXISTS reservations (
    reservation_id BINARY(16) PRIMARY KEY,
    car_id BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    start_time DATETIME DEFAULT NULL,
    end_time DATETIME DEFAULT NULL,
    FOREIGN KEY (car_id)
        REFERENCES cars (car_id),
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);


CREATE TABLE IF NOT EXISTS user_info_role (
    user_info_id BINARY(16) NOT NULL,
    role_id BINARY(16) NOT NULL,
    PRIMARY KEY (user_info_id , role_id),
    FOREIGN KEY (user_info_id)
        REFERENCES user_info (user_info_id),
    FOREIGN KEY (role_id)
        REFERENCES roles (role_id)
);

CREATE TABLE IF NOT EXISTS role_authority (
    role_id BINARY(16) NOT NULL,
    auth_id BINARY(16) NOT NULL,
    PRIMARY KEY (role_id , auth_id),
    FOREIGN KEY (role_id)
        REFERENCES roles (role_id),
    FOREIGN KEY (auth_id)
        REFERENCES authorities (auth_id)
);






