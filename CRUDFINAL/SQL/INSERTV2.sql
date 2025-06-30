--ROL
INSERT INTO ROL (nombre_rol, descripcion) VALUES
('ADMIN', 'Administrador del sistema'),
('BIBLIOTECARIO', 'Usuario encargado de la gesti�n de la biblioteca'),
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
(5, 'STU001', 'Carlos', 'Ram�rez', '987654321', 'Ciencias', 'ACTIVO', 'admin1'),
(6, 'STU002', 'Luc�a', 'Gonzales', '912345678', 'Matem�ticas', 'ACTIVO', 'admin1'),
(7, 'STU003', 'Pedro', 'Quispe', '998877665', 'Literatura', 'ACTIVO', 'admin1'),
(8, 'STU004', 'Ana', 'Salas', '987123456', 'Historia', 'ACTIVO', 'admin1'),
(9, 'STU005', 'Diego', 'Flores', '954321789', 'F�sica', 'ACTIVO', 'admin1');
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
('Ciencia', 'Libros cient�ficos y de experimentos', 5, 'S'),
('Historia', 'Libros hist�ricos', 5, 'N'),
('Matem�tica', 'Libros de teor�a y problemas', 3, 'S'),
('Infantil', 'Libros para ni�os de primaria', 10, 'S'),
('Filosof�a', 'Textos introductorios a la filosof�a', 6, 'S'),
('Arte', 'Libros de arte, pintura y dibujo', 4, 'S'),
('Deporte', 'Libros sobre actividades f�sicas', 3, 'N'),
('Computaci�n', 'Libros de inform�tica b�sica y avanzada', 7, 'S'),
('Ingl�s', 'Libros para el aprendizaje del idioma ingl�s', 5, 'S');


--LIBRO
INSERT INTO LIBRO (isbn, titulo, editorial, anio_publicacion, edicion, id_categoria, ubicacion, resumen, usuario_creacion)
VALUES 
('978-84-376-0494-7', 'Cien a�os de soledad', 'Sudamericana', 1982, '3ra', 1, 'Estanter�a A1', 'Novela de realismo m�gico', 'EMP001'),
('978-612-317-085-1', 'Ciencias Naturales 6', 'Santillana', 2020, '1ra', 2, 'Estanter�a B2', 'Libro de ciencias escolares', 'EMP002'),
('978-84-348-1096-6', 'Historia del Per�', 'SM', 2018, '2da', 3, 'Estanter�a C1', 'Historia nacional desde �poca precolombina', 'EMP001'),
('978-84-9838-324-1', '�lgebra', 'Alfaomega', 2015, '5ta', 4, 'Estanter�a D4', 'Libro de problemas matem�ticos', 'EMP003'),
('978-84-9414-376-5', 'Cuentos Infantiles', 'Norma', 2021, '1ra', 5, 'Estanter�a E1', 'Historias para ni�os de primaria', 'EMP003'),
('978-612-304-987-1', 'Introducci�n a la Filosof�a', 'Pearson', 2019, '2da', 6, 'Estanter�a F1', 'Principales corrientes filos�ficas', 'EMP001'),
('978-612-4083-12-2', 'Arte y Expresi�n', 'Trillas', 2021, '1ra', 7, 'Estanter�a G2', 'T�cnicas b�sicas de dibujo y pintura', 'EMP002'),
('978-612-3109-99-3', 'Educaci�n F�sica Integral', 'Santillana', 2018, '2da', 8, 'Estanter�a H1', 'Rutinas de ejercicios para estudiantes', 'EMP003'),
('978-612-4503-00-0', 'Inform�tica Escolar', 'Alfaomega', 2022, '3ra', 9, 'Estanter�a I2', 'Manejo b�sico de computadoras', 'EMP001'),
('978-612-3010-78-0', 'English for Schools', 'Richmond', 2020, '1ra', 10, 'Estanter�a J3', 'Libro de ingl�s escolar con actividades', 'EMP002');


--AUTOR
INSERT INTO AUTOR (nombre, apellido, pais_origen, fecha_nacimiento, biografia)
VALUES 
('Gabriel', 'Garc�a M�rquez', 'Colombia', '1927-03-06', 'Premio Nobel de Literatura, creador del realismo m�gico.'),
('Luis', 'P�rez', 'Per�', '1980-05-12', 'Autor de libros escolares.'),
('Ana', 'Ram�rez', 'Espa�a', '1975-09-21', 'Escritora de textos hist�ricos.'),
('Carlos', 'Torres', 'M�xico', '1965-01-10', 'Matem�tico y autor de libros t�cnicos.'),
('Luc�a', 'Salazar', 'Chile', '1990-07-15', 'Autora de cuentos para ni�os.'),
('Sof�a', 'Nieto', 'Argentina', '1972-08-10', 'Especialista en filosof�a educativa.'),
('Miguel', 'Castro', 'M�xico', '1985-02-14', 'Artista pl�stico y docente.'),
('Valeria', 'Medina', 'Per�', '1992-06-30', 'Profesora de educaci�n f�sica.'),
('H�ctor', 'Fern�ndez', 'Espa�a', '1970-11-22', 'Ingeniero de sistemas y autor.'),
('Emily', 'Johnson', 'Estados Unidos', '1988-04-18', 'Autora de libros para aprender ingl�s.');


--LIBRO_AUTOR
INSERT INTO LIBRO_AUTOR (id_libro, id_autor)
VALUES 
(1, 1), -- Cien a�os de soledad - Gabriel Garc�a M�rquez
(2, 2), -- Ciencias Naturales - Luis P�rez
(3, 3), -- Historia del Per� - Ana Ram�rez
(4, 4), -- �lgebra - Carlos Torres
(5, 5), -- Cuentos Infantiles - Luc�a Salazar
(6, 6),  -- Introducci�n a la Filosof�a - Sof�a Nieto
(7, 7),  -- Arte y Expresi�n - Miguel Castro
(8, 8),  -- Educaci�n F�sica Integral - Valeria Medina
(9, 9),  -- Inform�tica Escolar - H�ctor Fern�ndez
(10, 10); -- English for Schools - Emily Johnson


--EJEMPLAR
INSERT INTO EJEMPLAR (id_libro, codigo_barras, estado, fecha_adquisicion, ubicacion_fisica)
VALUES 
(1, 'CB1001', 'DISPONIBLE', '2023-01-15', 'Estanter�a A1'),
(2, 'CB1002', 'PRESTADO', '2023-03-10', 'Estanter�a B2'),
(3, 'CB1003', 'DISPONIBLE', '2023-02-20', 'Estanter�a C1'),
(4, 'CB1004', 'REPARACION', '2022-11-05', 'Estanter�a D4'),
(5, 'CB1005', 'DISPONIBLE', '2024-01-12', 'Estanter�a E1'),
(6, 'CB1006', 'DISPONIBLE', '2023-04-01', 'Estanter�a F1'),
(7, 'CB1007', 'DISPONIBLE', '2023-05-12', 'Estanter�a G2'),
(8, 'CB1008', 'DISPONIBLE', '2023-06-20', 'Estanter�a H1'),
(9, 'CB1009', 'DISPONIBLE', '2023-07-05', 'Estanter�a I2'),
(10, 'CB1010', 'DISPONIBLE', '2023-08-15', 'Estanter�a J3');
