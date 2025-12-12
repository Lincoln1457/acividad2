-- Creación de la base de datos
create database TiendaTech;
use TiendaTech;

-- Tabla productos
create table Productos (
	id_producto int primary key auto_increment,
    nombre_producti varchar(100) not null,
    categoria varchar(50),
    precio decimal(10,2) not null,
    stock int default 0,
    fecha_ingreso date
);

-- Tabla clientes
create table Clients (
	id_cliente int primary key auto_increment,
    nombre_cliente varchar(100) not null,
    ciudad varchar(50),
    correo varchar(100),
    fecha_registro date
);

-- Tabla ventas
create table Venta (
	id_venta int primary key auto_increment,
    id_producto int not null,
    id_cliente int not null,
    cantidad int not null,
    valor_total decimal(10,2),
    fecha_venta date
);

-- Inserción de datos de ejemplo

-- Productos
INSERT INTO Productos (nombre_producto, categoria, precio, stock, fecha_ingreso) VALUES
('Laptop ASUS', 'Computadores', 2500000, 10, '2025-03-05'),
('Mouse Gamer Logitech', 'Accesorios', 120000, 50, '2025-03-10'),
('Teclado Mecánico Redragon', 'Accesorios', 200000, 30, '2025-03-15'),
('Monitor Samsung 24”', 'Monitores', 850000, 15, '2025-04-01'),
('Audífonos Sony WH1000XM5', 'Audio', 1800000, 8, '2025-04-05');

-- Clientes
INSERT INTO Clients (nombre_cliente, ciudad, correo, fecha_registro) VALUES
('Carlos López', 'Bogotá', 'carlos.lopez@example.com', '2025-03-02'),
('María Fernández', 'Medellín', 'maria.f@example.com', '2025-03-18'),
('Juan Rodríguez', 'Cali', 'juan.r@example.com', '2025-04-02'),
('Ana Torres', 'Bogotá', 'ana.torres@example.com', '2025-04-10');

-- Ventas
INSERT INTO Venta (id_producto, id_cliente, cantidad, valor_total, fecha_venta) VALUES
(1, 1, 1, 2500000, '2025-04-12'),
(2, 2, 2, 240000, '2025-04-15'),
(4, 3, 1, 850000, '2025-04-18'),
(3, 1, 1, 200000, '2025-04-20'),
(5, 4, 1, 1800000, '2025-04-22');

-- Consultas básicas

-- 1.
SELECT * FROM Productos;

-- 2.
SELECT * FROM Clientes
WHERE MONTH(fecha_registro) = 3 AND YEAR(fecha_registro) = 2025;

-- 3.
SELECT * FROM Ventas
WHERE MONTH(fecha_venta) = 4 AND YEAR(fecha_venta) = 2025;

-- 4.
SELECT SUM(stock) AS total_inventario FROM Productos;

-- Consultas avanzadas

-- Detalle de ventas uniendo tablas
SELECT 
    c.nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.valor_total,
    v.fecha_venta
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
JOIN Productos p ON v.id_producto = p.id_producto;

-- Extra

-- Vista resumen de ventas
CREATE OR REPLACE VIEW vw_resumen_ventas AS
SELECT 
    v.id_venta,
    c.nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.valor_total,
    v.fecha_venta
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
JOIN Productos p ON v.id_producto = p.id_producto;
