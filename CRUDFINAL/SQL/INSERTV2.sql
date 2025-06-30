--ROL
INSERT INTO ROL (nombre_rol, descripcion) VALUES
('ADMIN', 'Administrador del sistema'),
('BIBLIOTECARIO', 'Usuario encargado de la gestión de la biblioteca'),
('ESTUDIANTE', 'Estudiante con permisos limitados');

--USUARIO
-- Admin
INSERT INTO USUARIO (nombre_usuario, contrasena, correo, id_rol, estado, usuario_creacion)
VALUES ('admin1', 'adminpass', 'admin@colegio.edu.pe', 1, 'ACTIVO', 'sistema');

-- Bibliotecarios
INSERT INTO USUARIO (nombre_usuario, contrasena, correo, id_rol, estado, usuario_creacion)
VALUES 
('biblio1', 'pass123', 'biblio1@colegio.edu.pe', 2, 'ACTIVO', 'admin1'),
('biblio2', 'pass123', 'biblio2@colegio.edu.pe', 2, 'ACTIVO', 'admin1'),
('biblio3', 'pass123', 'biblio3@colegio.edu.pe', 2, 'ACTIVO', 'admin1');

-- Estudiantes
INSERT INTO USUARIO (nombre_usuario, contrasena, correo, id_rol, estado, usuario_creacion)
VALUES 
('estu1', '123456', 'estu1@colegio.edu.pe', 3, 'ACTIVO', 'admin1'),
('estu2', '123456', 'estu2@colegio.edu.pe', 3, 'ACTIVO', 'admin1'),
('estu3', '123456', 'estu3@colegio.edu.pe', 3, 'ACTIVO', 'admin1'),
('estu4', '123456', 'estu4@colegio.edu.pe', 3, 'ACTIVO', 'admin1'),
('estu5', '123456', 'estu5@colegio.edu.pe', 3, 'ACTIVO', 'admin1');

--ESTUDIANTE 
INSERT INTO ESTUDIANTE (id_usuario, codigo_estudiante, nombre, apellido, telefono, carrera, estado, usuario_creacion)
VALUES 
(5, 'STU001', 'Carlos', 'Ramírez', '987654321', 'Ciencias', 'ACTIVO', 'admin1'),
(6, 'STU002', 'Lucía', 'Gonzales', '912345678', 'Matemáticas', 'ACTIVO', 'admin1'),
(7, 'STU003', 'Pedro', 'Quispe', '998877665', 'Literatura', 'ACTIVO', 'admin1'),
(8, 'STU004', 'Ana', 'Salas', '987123456', 'Historia', 'ACTIVO', 'admin1'),
(9, 'STU005', 'Diego', 'Flores', '954321789', 'Física', 'ACTIVO', 'admin1');
SELECT *FROM USUARIO;
--BIBLIOTECARIO 
INSERT INTO BIBLIOTECARIO (id_usuario, codigo_empleado, nombre, apellido, telefono, puesto, estado, usuario_creacion)
VALUES 
(2, 'EMP001', 'Sonia', 'Peralta', '999888777', 'Jefa de Biblioteca', 'ACTIVO', 'admin1'),
(3, 'EMP002', 'Luis', 'Torres', '988776655', 'Asistente', 'ACTIVO', 'admin1'),
(4, 'EMP003', 'Marta', 'Lopez', '977665544', 'Catalogador', 'ACTIVO', 'admin1');

--CATEGORIA_LIBRO
INSERT INTO CATEGORIA_LIBRO (nombre, descripcion, dias_prestamo, renovable)
VALUES 
('Literatura', 'Libros literarios escolares', 7, 'S'),
('Ciencia', 'Libros científicos y de experimentos', 5, 'S'),
('Historia', 'Libros históricos', 5, 'N'),
('Matemática', 'Libros de teoría y problemas', 3, 'S'),
('Infantil', 'Libros para niños de primaria', 10, 'S'),
('Filosofía', 'Textos introductorios a la filosofía', 6, 'S'),
('Arte', 'Libros de arte, pintura y dibujo', 4, 'S'),
('Deporte', 'Libros sobre actividades físicas', 3, 'N'),
('Computación', 'Libros de informática básica y avanzada', 7, 'S'),
('Inglés', 'Libros para el aprendizaje del idioma inglés', 5, 'S');


--LIBRO
INSERT INTO LIBRO (isbn, titulo, editorial, anio_publicacion, edicion, id_categoria, ubicacion, resumen, usuario_creacion)
VALUES 
('978-84-376-0494-7', 'Cien años de soledad', 'Sudamericana', 1982, '3ra', 1, 'Estantería A1', 'Novela de realismo mágico', 'EMP001'),
('978-612-317-085-1', 'Ciencias Naturales 6', 'Santillana', 2020, '1ra', 2, 'Estantería B2', 'Libro de ciencias escolares', 'EMP002'),
('978-84-348-1096-6', 'Historia del Perú', 'SM', 2018, '2da', 3, 'Estantería C1', 'Historia nacional desde época precolombina', 'EMP001'),
('978-84-9838-324-1', 'Álgebra', 'Alfaomega', 2015, '5ta', 4, 'Estantería D4', 'Libro de problemas matemáticos', 'EMP003'),
('978-84-9414-376-5', 'Cuentos Infantiles', 'Norma', 2021, '1ra', 5, 'Estantería E1', 'Historias para niños de primaria', 'EMP003'),
('978-612-304-987-1', 'Introducción a la Filosofía', 'Pearson', 2019, '2da', 6, 'Estantería F1', 'Principales corrientes filosóficas', 'EMP001'),
('978-612-4083-12-2', 'Arte y Expresión', 'Trillas', 2021, '1ra', 7, 'Estantería G2', 'Técnicas básicas de dibujo y pintura', 'EMP002'),
('978-612-3109-99-3', 'Educación Física Integral', 'Santillana', 2018, '2da', 8, 'Estantería H1', 'Rutinas de ejercicios para estudiantes', 'EMP003'),
('978-612-4503-00-0', 'Informática Escolar', 'Alfaomega', 2022, '3ra', 9, 'Estantería I2', 'Manejo básico de computadoras', 'EMP001'),
('978-612-3010-78-0', 'English for Schools', 'Richmond', 2020, '1ra', 10, 'Estantería J3', 'Libro de inglés escolar con actividades', 'EMP002');


--AUTOR
INSERT INTO AUTOR (nombre, apellido, pais_origen, fecha_nacimiento, biografia)
VALUES 
('Gabriel', 'García Márquez', 'Colombia', '1927-03-06', 'Premio Nobel de Literatura, creador del realismo mágico.'),
('Luis', 'Pérez', 'Perú', '1980-05-12', 'Autor de libros escolares.'),
('Ana', 'Ramírez', 'España', '1975-09-21', 'Escritora de textos históricos.'),
('Carlos', 'Torres', 'México', '1965-01-10', 'Matemático y autor de libros técnicos.'),
('Lucía', 'Salazar', 'Chile', '1990-07-15', 'Autora de cuentos para niños.'),
('Sofía', 'Nieto', 'Argentina', '1972-08-10', 'Especialista en filosofía educativa.'),
('Miguel', 'Castro', 'México', '1985-02-14', 'Artista plástico y docente.'),
('Valeria', 'Medina', 'Perú', '1992-06-30', 'Profesora de educación física.'),
('Héctor', 'Fernández', 'España', '1970-11-22', 'Ingeniero de sistemas y autor.'),
('Emily', 'Johnson', 'Estados Unidos', '1988-04-18', 'Autora de libros para aprender inglés.');


--LIBRO_AUTOR
INSERT INTO LIBRO_AUTOR (id_libro, id_autor)
VALUES 
(1, 1), -- Cien años de soledad - Gabriel García Márquez
(2, 2), -- Ciencias Naturales - Luis Pérez
(3, 3), -- Historia del Perú - Ana Ramírez
(4, 4), -- Álgebra - Carlos Torres
(5, 5), -- Cuentos Infantiles - Lucía Salazar
(6, 6),  -- Introducción a la Filosofía - Sofía Nieto
(7, 7),  -- Arte y Expresión - Miguel Castro
(8, 8),  -- Educación Física Integral - Valeria Medina
(9, 9),  -- Informática Escolar - Héctor Fernández
(10, 10); -- English for Schools - Emily Johnson


--EJEMPLAR
INSERT INTO EJEMPLAR (id_libro, codigo_barras, estado, fecha_adquisicion, ubicacion_fisica)
VALUES 
(1, 'CB1001', 'DISPONIBLE', '2023-01-15', 'Estantería A1'),
(2, 'CB1002', 'PRESTADO', '2023-03-10', 'Estantería B2'),
(3, 'CB1003', 'DISPONIBLE', '2023-02-20', 'Estantería C1'),
(4, 'CB1004', 'REPARACION', '2022-11-05', 'Estantería D4'),
(5, 'CB1005', 'DISPONIBLE', '2024-01-12', 'Estantería E1'),
(6, 'CB1006', 'DISPONIBLE', '2023-04-01', 'Estantería F1'),
(7, 'CB1007', 'DISPONIBLE', '2023-05-12', 'Estantería G2'),
(8, 'CB1008', 'DISPONIBLE', '2023-06-20', 'Estantería H1'),
(9, 'CB1009', 'DISPONIBLE', '2023-07-05', 'Estantería I2'),
(10, 'CB1010', 'DISPONIBLE', '2023-08-15', 'Estantería J3');
