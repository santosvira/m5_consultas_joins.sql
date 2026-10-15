# m5_consultas_joins.sql
Consultas-JOINS
Objetivo

El objetivo de este módulo es enriquecer el análisis de ventas de TechStore mediante consultas SQL que relacionan las diferentes tablas de la base de datos Ventas_Tech_DB.

Se utilizaron INNER JOIN, LEFT JOIN y UNION ALL para obtener información comercial relevante que posteriormente podrá utilizarse en Power BI.

Consultas realizadas

1. Vista base del proyecto (INNER JOIN)

Se relacionaron las tablas ventas, clientes, productos y categorias para obtener una vista completa de las operaciones comerciales.

La consulta incluye fecha de venta, cliente, ciudad, producto, categoría, cantidad, precio unitario y total facturado.

2. Clientes sin ventas (LEFT JOIN)

Se identificaron los clientes registrados que no realizaron compras, con el objetivo de proporcionar información útil para el área de CRM.

3. Productos sin ventas (LEFT JOIN)

Se analizaron los productos del catálogo para detectar aquellos que no registraron ventas y facilitar la toma de decisiones comerciales.

4. Consolidado por período (UNION ALL)

Se dividieron las ventas en dos períodos: primera y segunda quincena del mes.

Se utilizó UNION ALL para consolidar los resultados y comparar la facturación de ambos períodos.

Resultados obtenidos

Se analizaron 10 ventas, con una facturación total de $6.444.

Todos los clientes registrados realizaron al menos una compra.

Todos los productos del catálogo registraron al menos una venta.

La primera quincena concentró el 100 % de la facturación registrada.

Archivo SQL

m5_consultas_joins.sql

Este archivo contiene las cuatro consultas SQL, acompañadas de comentarios que explican su propósito y los hallazgos comerciales obtenidos.
