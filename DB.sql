psql postgres postgres
DROP DATABASE IF EXISTS ZOO;

CREATE DATABASE ZOO
	WITH ENCODING='UTF8';

exit
psql zoo postgres

-- SUPPLIER TABLE
CREATE TABLE SUPPLIER
(
	-- PRIMARY KEY
	ID_SUPPLIER INTEGER PRIMARY KEY,

	-- INFO
	NAME TEXT NOT NULL,
	ADDRESS TEXT DEFAULT NULL,
	TEL BIGINT DEFAULT NULL,
	IMAGE BYTEA DEFAULT NULL,
	STATUS BOOLEAN DEFAULT TRUE
);

-- SUPPLIER EXAMPLES
INSERT INTO SUPPLIER VALUES(0, 'DEFAULT', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO SUPPLIER VALUES(1, 'Distrito Max', 'Calle Norte sur 4 Juguetimax, Alce Blanco, 53370 Naucalpan de Juárez, Méx.', 5585268273, DEFAULT);
INSERT INTO SUPPLIER VALUES(2, 'Nu Promo', 'Av Guadalupe 4279, Cd de los Niños, 45040 Zapopan, Jal.', 423423423, DEFAULT);
INSERT INTO SUPPLIER VALUES(3, 'Jugueteria la loba', 'C. Liceo 240, Zona Centro, 44100 Guadalajara, Jal.', 442342, DEFAULT);

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

-- PRODUCT EXAMPLES
INSERT INTO PRODUCT VALUES(0, 0, 'DEFAULT', 'DEFAULT', 0.0, 'DEFAULT', 0, 0, 0, DEFAULT, DEFAULT);

-- a
INSERT INTO PRODUCT VALUES(1, 3, 'Peluche de león', 'Es un peluche de león', 150.0, 'peluche', 25, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(2, 3, 'Peluche de flamingo', 'Es un peluche de flamingo', 90.0, 'peluche', 25, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(3, 3, 'Peluche de tigre', 'Es un peluche de tigre', 130.0, 'peluche', 25, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(4, 3, 'Peluche de leon marino', 'Es un peluche de un leon marino', 70.0, 'peluche', 25, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(5, 3, 'Peluche de mono', 'Es un peluche de un mono', 90.0, 'peluche', 25, 100, 10, DEFAULT, DEFAULT);

INSERT INTO PRODUCT VALUES(6, 2, 'Rompecabezas animales', 'Juguete educativo rompecabezas animales', 200.0, 'juguete', 25, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(7, 2, 'Libro actividades', 'Libro de actividades de animales', 180.0, 'juguete', 25, 100, 10, DEFAULT, DEFAULT);

INSERT INTO PRODUCT VALUES(8, 2, 'Animales y su alimentación', 'Enciclopedia de animales y sus alimentos', 250.0, 'libro', 45, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(9, 1, 'La vida secreta de los animales', 'Descrube las maravillas del mundo animal', 170.0, 'libro', 45, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(10, 1, 'Animales asombrosos', 'juego de construcción en el que los niños pueden crear sus propios animales a partir de piezas desmontables', 120.5, 'libro', 45, 100, 10, DEFAULT, DEFAULT);

INSERT INTO PRODUCT VALUES(11, 1, 'Camisa tigre', 'Camisa estandar con estampado de tigre', 250.0, 'ropa', 45, 100, 10, DEFAULT, DEFAULT);
INSERT INTO PRODUCT VALUES(12, 1, 'Camisa de animales', 'Camisa estandar con estampado de animales', 200.0, 'ropa', 45, 100, 10, DEFAULT, DEFAULT);

-- STORE
CREATE TABLE STORE
(
	-- PRIMARY KEY
	ID_STORE INTEGER PRIMARY KEY,

	-- INFO
	LOCATION TEXT NOT NULL,
	TYPE TEXT NOT NULL,
	HOURS TEXT NOT NULL,
	STATUS BOOLEAN NOT NULL DEFAULT TRUE
);

-- STORE EXAMPLES
INSERT INTO STORE VALUES(0, 'DEFAULT', 'DEFAULT', 'DEFAULT', DEFAULT);
INSERT INTO STORE VALUES((SELECT MAX(ID_STORE) FROM STORE) + 1, 'Acuario', 'dulceria', '9:00 - 18:00', DEFAULT);
INSERT INTO STORE VALUES((SELECT MAX(ID_STORE) FROM STORE) + 1, 'Zona reptiles', 'restaurante', '9:00 - 15:00', DEFAULT);
INSERT INTO STORE VALUES((SELECT MAX(ID_STORE) FROM STORE) + 1, 'Zona pandas', 'dulceria', '9:00 - 19:00', DEFAULT);
INSERT INTO STORE VALUES((SELECT MAX(ID_STORE) FROM STORE) + 1, 'Zona zafari', 'bebidas', '9:00 - 18:00', DEFAULT);
INSERT INTO STORE VALUES((SELECT MAX(ID_STORE) FROM STORE) + 1, 'Zona reptiles', 'bebidas', '9:00 - 16:00', DEFAULT);

-- STORE_PRODUCT
CREATE TABLE STORE_PRODUCT
(
	-- PRIMARY KEY
	ID_STORE_PRODUCT INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_STORE INTEGER REFERENCES STORE (ID_STORE),
	FK_PRODUCT INTEGER REFERENCES PRODUCT (ID_PRODUCT),

	-- INFO
	LOCAL_STOCK INTEGER NOT NULL DEFAULT 0 CHECK(LOCAL_STOCK >= 0)
);

INSERT INTO STORE_PRODUCT VALUES(0, 0, 0, 0);

-- EMPLOYEE
CREATE TABLE EMPLOYEE
(
	-- PRIMARY KEY
	ID_EMPLOYEE INTEGER PRIMARY KEY,

	-- INFO
	PASS TEXT NOT NULL,
	CURP TEXT UNIQUE NOT NULL,
	FIRST_NAME TEXT NOT NULL,
	LAST_NAME TEXT NOT NULL,
	ADDRESS TEXT NOT NULL,
	NSS TEXT NOT NULL,
	ROLE TEXT NOT NULL,
	CV BYTEA DEFAULT NULL,
	STATUS BOOLEAN NOT NULL DEFAULT TRUE
);

-- EMPLOYEE EXAMPLES
INSERT INTO EMPLOYEE VALUES(0, 'DEFAULT', 'DEFAULT', 'DEFAULT', 'DEFAULT', 'DEFAULT', 'DEFAULT', 'DEFAULT', DEFAULT, DEFAULT);
INSERT INTO EMPLOYEE VALUES(1, '123', 'SUTA743264', 'Maria', 'García Rodríguez', 'Calle Juan Palomar y Arias # 567, Colonia Jardines Vallarta.', '138092187198', 'ventas', DEFAULT, DEFAULT);
INSERT INTO EMPLOYEE VALUES(2, '456', 'HAJK39U217', 'Ana', 'López Pérez', 'Avenida Patria # 2345, Colonia Jardines Universidad.', '4983798427', 'gerente de almacen', DEFAULT, DEFAULT);
INSERT INTO EMPLOYEE VALUES(3, '789', 'JFYS478932', 'Juan', 'González Hernández', 'Calle Nueva España # 789, Colonia Providencia.', '310278398127', 'gerente de ventas', DEFAULT, DEFAULT);
INSERT INTO EMPLOYEE VALUES(4, '123', 'NCJF758934', 'Sofia', 'Martínez Sánchez', 'Avenida Vallarta # 4321, Colonia Arcos Vallarta.', '40237498237', 'almacen', DEFAULT, DEFAULT);
INSERT INTO EMPLOYEE VALUES(5, '456', 'JGUE9838432', 'Carlos', 'Fernández Torres', 'Calle López Cotilla # 987, Colonia Americana.', '013821047982', 'ventas', DEFAULT, DEFAULT);

-- SALE
CREATE TABLE SALE
(
	-- PRIMARY KEY
	ID_SALE INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_EMPLOYEE INTEGER REFERENCES EMPLOYEE (ID_EMPLOYEE),

	-- INFO
	DATE DATE NOT NULL DEFAULT NOW()
);

-- SALE EXAMPLES
INSERT INTO SALE VALUES(0, 0, DEFAULT);
INSERT INTO SALE VALUES(1, 1, DEFAULT);

-- SALE DETAIL
CREATE TABLE SALE_DETAIL
(
	-- PRIMARY KEY
	ID_SALE_DETAIL INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_SALE INTEGER REFERENCES SALE (ID_SALE),
	FK_PRODUCT INTEGER REFERENCES PRODUCT (ID_PRODUCT),

	-- INFO
	AMOUNT INTEGER NOT NULL CHECK (AMOUNT > 0),
	COST REAL NOT NULL CHECK (COST >= 0.0)
);

-- SALE DETAIL EXAMPLES
INSERT INTO SALE_DETAIL VALUES(0, 0, 0, 1, 0);

INSERT INTO SALE_DETAIL VALUES(1, 1, 1, 2, 100);
INSERT INTO SALE_DETAIL VALUES(2, 1, 2, 4, 150);

-- PURCHASE
CREATE TABLE PURCHASE
(
	-- PRIMARY KEY
	ID_PURCHASE INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_SUPPLIER INTEGER REFERENCES SUPPLIER (ID_SUPPLIER),

	-- INFO
	DATE DATE NOT NULL DEFAULT NOW(),
	STATUS CHAR NOT NULL DEFAULT 'p'
);

INSERT INTO PURCHASE VALUES(0, 0, DEFAULT, 'c');

-- PURCHASE DETAIL
CREATE TABLE PURCHASE_DETAIL
(
	-- PRIMARY KEY
	ID_PURCHASE_DETAIL INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_PURCHASE INTEGER REFERENCES PURCHASE (ID_PURCHASE),
	FK_PRODUCT INTEGER REFERENCES PRODUCT (ID_PRODUCT),

	-- INFO
	AMOUNT INTEGER NOT NULL CHECK (AMOUNT > 0),
	COST REAL NOT NULL CHECK (COST >= 0.0)
);

INSERT INTO PURCHASE_DETAIL VALUES(0, 0, 0, 1, 0.0);

-- RETURN
CREATE TABLE RETURN
(
	-- PRIMARY KEY
	ID_RETURN INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_SALE INTEGER REFERENCES SALE (ID_SALE),

	-- INFO
	DATE DATE NOT NULL DEFAULT NOW()
);

INSERT INTO RETURN VALUES(0, 0, DEFAULT);

-- RETURN DETAIL
CREATE TABLE RETURN_DETAIL
(
	-- PRIMARY KEY
	ID_RETURN_DETAIL INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_RETURN INTEGER REFERENCES RETURN (ID_RETURN),
	FK_PRODUCT INTEGER REFERENCES PRODUCT (ID_PRODUCT),

	-- INFO
	AMOUNT INTEGER NOT NULL CHECK (AMOUNT > 0),
	REASON TEXT NOT NULL
);

INSERT INTO RETURN_DETAIL VALUES(0, 0, 0, 1, '');

-- PRODUCT ORDER
CREATE TABLE PRODUCT_ORDER
(
	-- PRIMARY KEY
	ID_PRODUCT_ORDER INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_EMPLOYEE INTEGER REFERENCES EMPLOYEE (ID_EMPLOYEE),
	FK_STORE INTEGER REFERENCES STORE (ID_STORE),

	-- INFO
	DATE DATE NOT NULL DEFAULT NOW(),
	STATUS CHAR NOT NULL DEFAULT 'p'
);

INSERT INTO PRODUCT_ORDER VALUES(0, 0, 0, DEFAULT, 'c');

-- PRODUCT ORDER DETAIL
CREATE TABLE PRODUCT_ORDER_DETAIL
(
	-- PRIMARY KEY
	ID_PRODUCT_ORDER_DETAIL INTEGER PRIMARY KEY,

	-- FOREIGN KEY
	FK_PRODUCT_ORDER INTEGER REFERENCES PRODUCT_ORDER (ID_PRODUCT_ORDER),
	FK_PRODUCT INTEGER REFERENCES PRODUCT (ID_PRODUCT),

	-- INFO
	AMOUNT INTEGER NOT NULL CHECK (AMOUNT > 0)
);

INSERT INTO PRODUCT_ORDER_DETAIL VALUES(0, 0, 0, 1);
