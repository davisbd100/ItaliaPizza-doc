DROP DATABASE IF EXISTS Pizza
USE Pizza
CREATE TABLE [Persona] (
  [idPersona] int PRIMARY KEY,
  [Nombre] nvarchar(255),
  [Apellido] nvarchar(255),
  [Telefono] nvarchar(255),
  [Email] nvarchar(255),
  [Calle] nvarchar(255),
  [Numero] nvarchar(255),
  [CodigoPostal] nvarchar(255),
  [Colonia] nvarchar(255),
  [Ciudad] nvarchar(255)
)
GO

CREATE TABLE [Cliente] (
  [idCliente] int PRIMARY KEY
)
GO

CREATE TABLE [Empleado] (
  [idEmpleado] int PRIMARY KEY,
  [TipoEmpleado] int,
  [NombreUsuario] nvarchar(255),
  [Contrasena] nvarchar(255),
  [FechaUltimoAcceso] datetime
)
GO

CREATE TABLE [TipoEmpleado] (
  [idTipoEmpleado] int PRIMARY KEY IDENTITY(1, 1),
  [TipoEmpleado] nvarchar(255)
)
GO

CREATE TABLE [Producto] (
  [Codigo] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre] nvarchar(255),
  [Descripcion] nvarchar(255),
  [Restriccion] nvarchar(255)
)
GO

CREATE TABLE [Inventario] (
  [idInventario] int PRIMARY KEY,
  [Producto] int,
  [ExistenciaInicial] int,
  [ExistenciaTotal] int,
  [UnidadMedida] nvarchar(255)
)
GO

CREATE TABLE [ProductoInventario] (
  [Inventario] int,
  [Producto] int,
  [CantidadIngreso] int,
  [PrecioCompra] float,
  [FechaIngreso] datetime,
  [Caducidad] datetime,
  PRIMARY KEY ([Inventario], [Producto])
)
GO

CREATE TABLE [Ubicacion] (
  [idUbicacion] int PRIMARY KEY,
  [NombreUbicacion] nvarchar(255)
)
GO

CREATE TABLE [UbicacionProducto] (
  [Ubicacion] int,
  [Producto] int,
  [Cantidad] int,
  PRIMARY KEY ([Ubicacion], [Producto])
)
GO

CREATE TABLE [ProductoVenta] (
  [idProductoVenta] int PRIMARY KEY,
  [PrecioPublico] float,
  [TipoProducto] int,
  [FotoProducto] nvarchar(255),
  [TieneReceta] bit,
  [Receta] int
)
GO

CREATE TABLE [TipoProducto] (
  [idTipoProducto] int PRIMARY KEY,
  [NombreTipoProducto] nvarchar(255)
)
GO

CREATE TABLE [ProductoIngrediente] (
  [idProductoIngrediente] int PRIMARY KEY,
  [TipoIngrediente] nvarchar(255)
)
GO

CREATE TABLE [Receta] (
  [idReceta] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre] nvarchar(255),
  [Procedimiento] nvarchar(255),
  [Rendimiento] float
)
GO

CREATE TABLE [RecetaIngrediente] (
  [idReceta] int IDENTITY(1, 1),
  [idProductoIngrediente] int,
  [Cantidad] int,
  [PrecioUnitario] float,
  PRIMARY KEY ([idReceta], [idProductoIngrediente])
)
GO

CREATE TABLE [Pedido] (
  [idPedido] int PRIMARY KEY,
  [FechaPedido] datetime,
  [NumeroMesa] int,
  [Estatus] int,
  [Cliente] int,
  [Empleado] int,
  [DiaVenta] int
)
GO

CREATE TABLE [DiaVenta] (
  [idVentaDiaria] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [Ingresos] float,
  [Fecha] datetime
)
GO

CREATE TABLE [PedidoProducto] (
  [idPedido] int,
  [idProductoVenta] int,
  [Cantidad] int,
  [Precio] float,
  PRIMARY KEY ([idPedido], [idProductoVenta])
)
GO

CREATE TABLE [Estatus] (
  [idEstatus] int PRIMARY KEY,
  [NombreEstatus] nvarchar(255)
)
GO

CREATE TABLE [PedidoDomicilio] (
  [idPedido] int PRIMARY KEY,
  [Comentario] nvarchar(255),
  [HoraSalida] datetime,
  [Repartidor] nvarchar(255)
)
GO

ALTER TABLE [Cliente] ADD FOREIGN KEY ([idCliente]) REFERENCES [Persona] ([idPersona])
GO

ALTER TABLE [Empleado] ADD FOREIGN KEY ([idEmpleado]) REFERENCES [Persona] ([idPersona])
GO

ALTER TABLE [Empleado] ADD FOREIGN KEY ([TipoEmpleado]) REFERENCES [TipoEmpleado] ([idTipoEmpleado])
GO

ALTER TABLE [Inventario] ADD FOREIGN KEY ([Producto]) REFERENCES [Producto] ([Codigo])
GO

ALTER TABLE [ProductoInventario] ADD FOREIGN KEY ([Inventario]) REFERENCES [Inventario] ([idInventario])
GO

ALTER TABLE [ProductoInventario] ADD FOREIGN KEY ([Producto]) REFERENCES [Producto] ([Codigo])
GO

ALTER TABLE [UbicacionProducto] ADD FOREIGN KEY ([Ubicacion]) REFERENCES [Ubicacion] ([idUbicacion])
GO

ALTER TABLE [UbicacionProducto] ADD FOREIGN KEY ([Producto]) REFERENCES [Producto] ([Codigo])
GO

ALTER TABLE [ProductoVenta] ADD FOREIGN KEY ([idProductoVenta]) REFERENCES [Producto] ([Codigo])
GO

ALTER TABLE [ProductoVenta] ADD FOREIGN KEY ([TipoProducto]) REFERENCES [TipoProducto] ([idTipoProducto])
GO

ALTER TABLE [ProductoVenta] ADD FOREIGN KEY ([Receta]) REFERENCES [Receta] ([idReceta])
GO

ALTER TABLE [ProductoIngrediente] ADD FOREIGN KEY ([idProductoIngrediente]) REFERENCES [Producto] ([Codigo])
GO

ALTER TABLE [RecetaIngrediente] ADD FOREIGN KEY ([idReceta]) REFERENCES [Receta] ([idReceta])
GO

ALTER TABLE [RecetaIngrediente] ADD FOREIGN KEY ([idProductoIngrediente]) REFERENCES [ProductoIngrediente] ([idProductoIngrediente])
GO

ALTER TABLE [Pedido] ADD FOREIGN KEY ([Estatus]) REFERENCES [Estatus] ([idEstatus])
GO

ALTER TABLE [Pedido] ADD FOREIGN KEY ([Cliente]) REFERENCES [Cliente] ([idCliente])
GO

ALTER TABLE [Pedido] ADD FOREIGN KEY ([Empleado]) REFERENCES [Empleado] ([idEmpleado])
GO

ALTER TABLE [Pedido] ADD FOREIGN KEY ([DiaVenta]) REFERENCES [DiaVenta] ([idVentaDiaria])
GO

ALTER TABLE [PedidoProducto] ADD FOREIGN KEY ([idPedido]) REFERENCES [Pedido] ([idPedido])
GO

ALTER TABLE [PedidoProducto] ADD FOREIGN KEY ([idProductoVenta]) REFERENCES [ProductoVenta] ([idProductoVenta])
GO

ALTER TABLE [PedidoDomicilio] ADD FOREIGN KEY ([idPedido]) REFERENCES [Pedido] ([idPedido])
GO

