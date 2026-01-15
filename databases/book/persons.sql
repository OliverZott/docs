CREATE TABLE persons (
    id BIGINT NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    birthdate DATE,
    email VARCHAR(100),
    phone VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(100),
    zipcode VARCHAR(20),
    country VARCHAR(100),
    PRIMARY KEY (id)
);