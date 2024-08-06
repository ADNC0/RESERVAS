CREATE TABLE docente (
    id_doc            INT IDENTITY(1,1) PRIMARY KEY,
    nombre_doc        VARCHAR(50),
    apellido_doc      VARCHAR(50),
    email_doc         VARCHAR(100),
    celular_doc       VARCHAR(20),
    departamento_doc  VARCHAR(30)
);

CREATE TABLE infraestructura (
    id_inf              INT IDENTITY(1,1) PRIMARY KEY,
    nombre_inf          VARCHAR(50),
    tipo_inf            VARCHAR(50),
    ubicacion_inf       VARCHAR(100),
    capacidad_inf       VARCHAR(100),
    disponibilidad_inf  VARCHAR(20)
);

CREATE TABLE reservas (
    id_res                  INT IDENTITY(1,1) PRIMARY KEY,
    fecha_inf               DATE,
    hinicio_inf             DATETIME,
    hfin_inf                DATETIME,
    motivo_inf              VARCHAR(200),
    estado_inf              VARCHAR(50),
    infraestructura_id_inf  INT NOT NULL,
    docente_id_doc          INT NOT NULL,
    CONSTRAINT reservas_docente_fk FOREIGN KEY (docente_id_doc) REFERENCES docente(id_doc),
    CONSTRAINT reservas_infraestructura_fk FOREIGN KEY (infraestructura_id_inf) REFERENCES infraestructura(id_inf)
);

select * from reservas;
select * from docente;
select * from infraestructura;

INSERT INTO docente (nombre_doc, apellido_doc, email_doc, celular_doc, departamento_doc)
VALUES
('Carlos', 'Perez', 'carlos.perez@correo.com', '0999999991', 'Matemáticas'),
('Maria', 'Lopez', 'maria.lopez@correo.com', '0999999992', 'Física'),
('Juan', 'Gonzalez', 'juan.gonzalez@correo.com', '0999999993', 'Química'),
('Ana', 'Ramirez', 'ana.ramirez@correo.com', '0999999994', 'Biología'),
('Luis', 'Martinez', 'luis.martinez@correo.com', '0999999995', 'Historia');

INSERT INTO infraestructura (nombre_inf, tipo_inf, ubicacion_inf, capacidad_inf, disponibilidad_inf)
VALUES
('Aula 101', 'Aula', 'Edificio A', '30 personas', 'Disponible'),
('Laboratorio de Física', 'Laboratorio', 'Edificio B', '20 personas', 'No disponible'),
('Sala de Conferencias', 'Sala', 'Edificio C', '100 personas', 'Disponible'),
('Biblioteca', 'Biblioteca', 'Edificio D', '50 personas', 'Disponible'),
('Aula 102', 'Aula', 'Edificio A', '30 personas', 'No disponible');

INSERT INTO reservas (fecha_inf, hinicio_inf, hfin_inf, motivo_inf, estado_inf, infraestructura_id_inf, docente_id_doc)
VALUES
('2024-08-01', '2024-08-01 09:00:00', '2024-08-01 11:00:00', 'Clase de Matemáticas', 'Confirmada', 1, 1),
('2024-08-02', '2024-08-02 14:00:00', '2024-08-02 16:00:00', 'Práctica de Física', 'Pendiente', 2, 2),
('2024-08-03', '2024-08-03 10:00:00', '2024-08-03 12:00:00', 'Conferencia sobre Química', 'Confirmada', 3, 3),
('2024-08-04', '2024-08-04 08:00:00', '2024-08-04 10:00:00', 'Estudio de Biología', 'Cancelada', 4, 4),
('2024-08-05', '2024-08-05 15:00:00', '2024-08-05 17:00:00', 'Clase de Historia', 'Confirmada', 5, 5);

CREATE PROCEDURE InsertDocente
    @nombre_doc VARCHAR(50),
    @apellido_doc VARCHAR(50),
    @email_doc VARCHAR(100),
    @celular_doc VARCHAR(20),
    @departamento_doc VARCHAR(30)
AS
BEGIN
    INSERT INTO docente (nombre_doc, apellido_doc, email_doc, celular_doc, departamento_doc)
    VALUES (@nombre_doc, @apellido_doc, @email_doc, @celular_doc, @departamento_doc);
END;

CREATE PROCEDURE InsertInfraestructura
    @nombre_inf VARCHAR(50),
    @tipo_inf VARCHAR(50),
    @ubicacion_inf VARCHAR(100),
    @capacidad_inf VARCHAR(100),
    @disponibilidad_inf VARCHAR(20)
AS
BEGIN
    INSERT INTO infraestructura (nombre_inf, tipo_inf, ubicacion_inf, capacidad_inf, disponibilidad_inf)
    VALUES (@nombre_inf, @tipo_inf, @ubicacion_inf, @capacidad_inf, @disponibilidad_inf);
END;

CREATE PROCEDURE InsertReserva
    @fecha_inf DATE,
    @hinicio_inf DATETIME,
    @hfin_inf DATETIME,
    @motivo_inf VARCHAR(200),
    @estado_inf VARCHAR(50),
    @infraestructura_id_inf INT,
    @docente_id_doc INT
AS
BEGIN
    INSERT INTO reservas (fecha_inf, hinicio_inf, hfin_inf, motivo_inf, estado_inf, infraestructura_id_inf, docente_id_doc)
    VALUES (@fecha_inf, @hinicio_inf, @hfin_inf, @motivo_inf, @estado_inf, @infraestructura_id_inf, @docente_id_doc);
END;

CREATE PROCEDURE DeleteDocente
    @id_doc INT
AS
BEGIN
    DELETE FROM docente WHERE id_doc = @id_doc;
END;

CREATE PROCEDURE DeleteInfraestructura
    @id_inf INT
AS
BEGIN
    DELETE FROM infraestructura WHERE id_inf = @id_inf;
END;

CREATE PROCEDURE DeleteReserva
    @id_res INT
AS
BEGIN
    DELETE FROM reservas WHERE id_res = @id_res;
END;

CREATE PROCEDURE UpdateDocente
    @id_doc INT,
    @nombre_doc VARCHAR(50),
    @apellido_doc VARCHAR(50),
    @email_doc VARCHAR(100),
    @celular_doc VARCHAR(20),
    @departamento_doc VARCHAR(30)
AS
BEGIN
    UPDATE docente
    SET nombre_doc = @nombre_doc,
        apellido_doc = @apellido_doc,
        email_doc = @email_doc,
        celular_doc = @celular_doc,
        departamento_doc = @departamento_doc
    WHERE id_doc = @id_doc;
END;

CREATE PROCEDURE UpdateInfraestructura
    @id_inf INT,
    @nombre_inf VARCHAR(50),
    @tipo_inf VARCHAR(50),
    @ubicacion_inf VARCHAR(100),
    @capacidad_inf VARCHAR(100),
    @disponibilidad_inf VARCHAR(20)
AS
BEGIN
    UPDATE infraestructura
    SET nombre_inf = @nombre_inf,
        tipo_inf = @tipo_inf,
        ubicacion_inf = @ubicacion_inf,
        capacidad_inf = @capacidad_inf,
        disponibilidad_inf = @disponibilidad_inf
    WHERE id_inf = @id_inf;
END;

CREATE PROCEDURE UpdateReserva
    @id_res INT,
    @fecha_inf DATE,
    @hinicio_inf DATETIME,
    @hfin_inf DATETIME,
    @motivo_inf VARCHAR(200),
    @estado_inf VARCHAR(50),
    @infraestructura_id_inf INT,
    @docente_id_doc INT
AS
BEGIN
    UPDATE reservas
    SET fecha_inf = @fecha_inf,
        hinicio_inf = @hinicio_inf,
        hfin_inf = @hfin_inf,
        motivo_inf = @motivo_inf,
        estado_inf = @estado_inf,
        infraestructura_id_inf = @infraestructura_id_inf,
        docente_id_doc = @docente_id_doc
    WHERE id_res = @id_res;
END;

CREATE PROCEDURE GetAllReservas
AS
BEGIN
    SELECT * FROM reservas;
END;

CREATE PROCEDURE GetReservaByID
    @id_res INT
AS
BEGIN
    SELECT * FROM reservas WHERE id_res = @id_res;
END;

