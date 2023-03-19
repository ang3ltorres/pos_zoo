psql postgres postgres
DROP DATABASE IF EXISTS ZOO;

CREATE DATABASE ZOO
	WITH ENCODING='UTF8';

exit
psql zoo postgres

-- CLIENT TABLE
CREATE TABLE SUPPLIER
(
	-- PRIMARY KEY
	ID_SUPPLIER INTEGER PRIMARY KEY,

	-- INFO
	NAME TEXT NOT NULL,
	ADDRESS TEXT DEFAULT NULL,
	TEL BIGINT DEFAULT NULL,
	STATUS BOOLEAN DEFAULT TRUE
);

-- SUPPLIER EXAMPLES
INSERT INTO SUPPLIER VALUES(0, 'DEFAULT', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO SUPPLIER VALUES((SELECT MAX(ID_SUPPLIER) FROM SUPPLIER) + 1, 'Lala', 'Anillo Perif. Sur Manuel Gómez Morín 6201, Lopez Cotilla, 45610 San Pedro Tlaquepaque, Jal.', 3336684956, DEFAULT);
INSERT INTO SUPPLIER VALUES((SELECT MAX(ID_SUPPLIER) FROM SUPPLIER) + 1, 'SuKarne', 'Av. Belisario Domínguez #1195 esquina, Monte Ajusco, Lomas Independencia, 44340 Guadalajara, Jal.', 3338529213, DEFAULT);
INSERT INTO SUPPLIER VALUES((SELECT MAX(ID_SUPPLIER) FROM SUPPLIER) + 1, 'Distrito Max', 'Calle Norte sur 4 Juguetimax, Alce Blanco, 53370 Naucalpan de Juárez, Méx.', 5585268273, DEFAULT);
INSERT INTO SUPPLIER VALUES((SELECT MAX(ID_SUPPLIER) FROM SUPPLIER) + 1, 'Materias primas Guadalajara', 'Av. Chicalote 2579 D, Comercial Abastos, 44530 Guadalajara, Jal.', 3336713232, DEFAULT);

-- PRODUCT TABLE
CREATE TABLE PRODUCT
(
	-- PRIMARY KEY
	ID_PRODUCT INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_SUPPLIER INTEGER REFERENCES SUPPLIER (ID_SUPPLIER),

	-- INFO
	NAME TEXT UNIQUE NOT NULL,
	DESCRIPTION TEXT NOT NULL,
	PRICE REAL NOT NULL,
	CATEGORY TEXT NOT NULL,
	STOCK INTEGER NOT NULL,
	MAX_STOCK INTEGER NOT NULL,
	LOCAL_LIMIT INTEGER NOT NULL,
	STATUS BOOLEAN NOT NULL DEFAULT TRUE,
	IMAGE BYTEA DEFAULT NULL
);
