CREATE DATABASE Proyectoo;
USE Proyectoo;

CREATE TABLE categorias (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,   -- Identificador único para cada categoría
    nombre VARCHAR(100) NOT NULL                  -- Nombre de la categoría
);

INSERT INTO categorias (nombre) VALUES
("Herramientas manuales"),
("Materiales de construcción"),
("Iluminacion y electricidad"),
("Jardineria y exteriores"),
("Pinturas");


-- Crear tabla de productos
CREATE TABLE productos (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    precio INT UNSIGNED NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    categoria_id INT UNSIGNED,
    estado ENUM("Activo", "Inactivo") DEFAULT 'Activo',
	FOREIGN KEY (categoria_id) REFERENCES categorias(id)  -- Relación con la tabla categorias

);

-- Insertar registros en productos
INSERT INTO productos (nombre, cantidad, precio, descripcion, imagen, categoria_id, estado) VALUES
('Martillo de acero', 50, 15000, 'Martillo con mango ergonómico', 'martillo.jpg', 1, 'Activo'),
('Destornillador Philips', 100, 8000, 'Destornillador estrella de 6 pulgadas', 'destornillador.jpg', 1, 'Activo'),
('Cemento Portland', 200, 25000, 'Bolsa de 50 kg de cemento', 'cemento.jpg', 2, 'Activo'),
('Arena gruesa', 300, 1000, 'Saco de arena para construcción', 'arena.jpg', 2, 'Activo'),
('Lámpara LED 10W', 150, 12000, 'Lámpara LED de bajo consumo', 'lampara_led.jpg', 3, 'Activo'),
('Toma corriente doble', 500, 6000, 'Toma corriente doble con puesta a tierra', 'tomacorriente.jpg', 3, 'Activo'),
('Manguera de jardín 15m', 80, 25000, 'Manguera resistente para jardinería', 'manguera.jpg', 4, 'Activo'),
('Abono orgánico', 120, 18000, 'Abono para plantas en crecimiento', 'abono.jpg', 4, 'Activo'),
('Pintura acrílica blanca 1L', 200, 22000, 'Pintura blanca para interiores', 'pintura_acrilica.jpg', 5, 'Activo'),
('Rodillo para pintar', 150, 8000, 'Rodillo de espuma para pintura', 'rodillo.jpg', 5, 'Activo'),
('Sierra de mano', 75, 14000, 'Sierra de mano para madera', 'sierra.jpg', 1, 'Activo'),
('Clavos de acero 2 pulgadas', 400, 2000, 'Paquete de clavos para construcción', 'clavos.jpg', 1, 'Activo'),
('Enchufe triple', 200, 5000, 'Enchufe para tres tomas', 'enchufe.jpg', 2, 'Activo'),
('Tijeras de podar', 90, 16000, 'Tijeras para jardín', 'tijeras_podar.jpg', 4, 'Activo'),
('Brocha para pintura 2"', 160, 5000, 'Brocha para acabados finos', 'brocha.jpg', 5, 'Activo'),
('Llave inglesa 8"', 50, 12000, 'Llave ajustable para tuercas', 'llave_inglesa.jpg', 1, 'Activo'),
('Bloques de concreto', 350, 3000, 'Bloque para construcción', 'bloques.jpg', 2, 'Activo'),
('Cable eléctrico 10m', 100, 20000, 'Cable de alta resistencia', 'cable.jpg', 3, 'Activo'),
('Pala para jardín', 70, 13000, 'Pala metálica para jardinería', 'pala.jpg', 4, 'Activo'),
('Esmalte sintético rojo 1L', 50, 27000, 'Esmalte de alta calidad', 'esmalte.jpg', 5, 'Activo');

-- Crear tabla de usuario
CREATE TABLE usuario (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Contrasena VARCHAR(60) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Direccion varchar(255) NOT NULL,
    Genero enum('Masculino', 'Femenino') not null,
    Rol enum('Administrador', 'Almacenista', 'Cajero', 'Cliente') NOT NULL,
    Estado enum('Activo', 'Inactivo') default 'Activo',
    Usoc enum('Usada', 'NoUsada') default 'NoUsada',
    Codigo int unsigned
);

-- Crear tabla historial_activaciones
CREATE TABLE historial_activaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT UNSIGNED NOT NULL,    -- Aseguramos que sea del mismo tipo que 'id' en productos
  descripcion VARCHAR(250) NOT NULL,
  fecha_activacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  usuario_id INT,  
  FOREIGN KEY (producto_id) REFERENCES productos(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)     -- Referencia a la tabla usuarios
  ON DELETE CASCADE  -- Si se elimina el producto, se eliminarán las activaciones relacionadas
);

CREATE TABLE historial_inactivaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT UNSIGNED NOT NULL,
  descripcion VARCHAR(250) NOT NULL,
  fecha_inactivacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  usuario_id INT,  
  FOREIGN KEY (producto_id) REFERENCES productos(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)     
  ON DELETE CASCADE
);

CREATE TABLE historial_movimientos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT UNSIGNED NOT NULL,
  tipo_movimiento ENUM('agregacion', 'desagregacion') NOT NULL,
  cantidad INT NOT NULL,
  descripcion VARCHAR(250) NOT NULL,
  fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
  usuario_id INT,
  FOREIGN KEY (producto_id) REFERENCES productos(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
  ON DELETE CASCADE
);

-- Insertar registros en usuario
INSERT INTO usuario (Nombres, Apellidos, Correo, Contrasena, Telefono, Direccion, Genero, Rol, Estado, Usoc) VALUES
('Juan Carlos', 'Pérez Gómez', 'admin1@gmail.com', 'Admin123456789', '3001234567', 'Calle 123 #45-67', 'Masculino', 'Administrador', 'Activo', 'NoUsada'),
('María José', 'López Silva', 'admin2@gmail.com', 'Admin987654321', '3109876543', 'Avenida 45 #12-34', 'Femenino', 'Administrador', 'Activo', 'NoUsada'),
('Pedro Luis', 'Ramírez Torres', 'almacen1@gmail.com', 'Almacen123456', '3201234567', 'Carrera 78 #90-12', 'Masculino', 'Almacenista', 'Activo', 'NoUsada'),
('Ana María', 'García Ruiz', 'almacen2@gmail.com', 'Almacen654321', '3157894561', 'Calle 56 #78-90', 'Femenino', 'Almacenista', 'Activo', 'NoUsada'),
('Carlos Alberto', 'Martínez Díaz', 'cajero1@gmail.com', 'Cajero123456', '3501234567', 'Carrera 34 #56-78', 'Masculino', 'Cajero', 'Activo', 'NoUsada'),
('Laura Victoria', 'Sánchez Mora', 'cajero2@gmail.com', 'Cajero654321', '3187894562', 'Avenida 67 #89-12', 'Femenino', 'Cajero', 'Activo', 'NoUsada'),
('Roberto', 'González Pérez', 'cliente1@gmail.com', 'Cliente123456', '3401234567', 'Calle 89 #12-34', 'Masculino', 'Cliente', 'Activo', 'NoUsada'),
('Carmen Elena', 'Rojas Mesa', 'cliente2@gmail.com', 'Cliente654321', '3167894563', 'Carrera 12 #34-56', 'Femenino', 'Cliente', 'Activo', 'NoUsada'),
('Miguel Ángel', 'Torres Vargas', 'cliente3@gmail.com', 'Cliente789123', '3301234568', 'Avenida 90 #23-45', 'Masculino', 'Cliente', 'Activo', 'NoUsada'),
('Diana Patricia', 'Morales Luna', 'cliente4@gmail.com', 'Cliente321987', '3147894564', 'Calle 45 #67-89', 'Femenino', 'Cliente', 'Inactivo', 'NoUsada');

-- Crear tabla de pedidos
CREATE TABLE IF NOT EXISTS Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Numero VARCHAR(50) NOT NULL,
    Direccion TEXT NOT NULL,
    Metodo VARCHAR(100) NOT NULL,
    Fecha DATETIME NOT NULL,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
);

-- Crear tabla de detalle de pedido
CREATE TABLE IF NOT EXISTS Detalle_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_Id INT NOT NULL,
    producto_Id INT UNSIGNED NOT NULL,
    cantidad INT NOT NULL,
    precio_Unitario DECIMAL(10, 2) NOT NULL,
    precio_Total DECIMAL(10, 2) NOT NULL,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    FOREIGN KEY (pedido_Id) REFERENCES Pedido(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_Id) REFERENCES productos(id) ON DELETE CASCADE
);

-- Crear tabla de ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,            
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    descuento DECIMAL(5, 2) DEFAULT 0,            
    subtotal DECIMAL(10, 2) NOT NULL,             
    iva DECIMAL(10, 2) NOT NULL,                  
    total DECIMAL(10, 2) NOT NULL,                
    metodo_pago ENUM('Tarjeta', 'Efectivo') NOT NULL,  
    usuario_id INT NOT NULL,                     
    FOREIGN KEY (usuario_id) REFERENCES usuario(ID) 
);

-- Crear tabla de detalle de venta
CREATE TABLE detalle_venta (
    id INT AUTO_INCREMENT PRIMARY KEY,            
    venta_id INT NOT NULL,                         
    producto_id INT UNSIGNED,                      
    cantidad INT NOT NULL,                         
    precio_unitario DECIMAL(10, 2) NOT NULL,       
    subtotal DECIMAL(10, 2) NOT NULL,              
    FOREIGN KEY (venta_id) REFERENCES ventas(id), 
    FOREIGN KEY (producto_id) REFERENCES productos(id) 
);

select*from usuario;
update usuario set rol ='Administrador' where ID=11;
select * from historial_activaciones;

SELECT p.*, c.nombre AS categoria_nombre
FROM productos p
JOIN categorias c ON p.categoria_id = c.id
LIMIT 0, 1000;

