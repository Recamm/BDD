#1
select * from proveedor where ciudad = "La Plata";

#2
delete from articulo where codigo in (select articulo_codigo from compuesto_por where material_codigo is null);

#3
select articulo.codigo, articulo.descripcion from articulo 
join compuesto_por on articulo.codigo = articulo_codigo where material_codigo in 
(select material.codigo from material 
join provisto_por on material_codigo = material.codigo 
join proveedor on proveedor_codigo = proveedor.codigo
where proveedor.nombre like "%Lopez%");

#4
select proveedor.codigo, proveedor.nombre from proveedor
join provisto_por on proveedor_codigo = proveedor.codigo
where material_codigo in 
(select material.codigo from articulo 
join compuesto_por on articulo_codigo = articulo.codigo
join material on material_codigo = material.codigo
where articulo.precio > 10000);

#5
select codigo from articulo where precio in (select max(precio) from articulo);

#6
select articulo.descripcion as nombre, articulo.codigo from tiene
join articulo on articulo_codigo = articulo.codigo
where stock in (select max(sPrd) from 
(select articulo_codigo, sum(stock) as sPrd from tiene group by articulo_codigo) as stockProducto);

#7
select * from tiene
join articulo on tiene.articulo_codigo = articulo.codigo
join compuesto_por on compuesto_por.articulo_codigo = articulo.codigo
join material on material_codigo = material.codigo
where almacen_codigo = 2;

#8
select articulo_codigo, count(*) as mats from compuesto_por
group by articulo_codigo
having mats in
(select max(matss) from 
(select articulo_codigo, count(*) as matss from compuesto_por group by articulo_codigo) as sub);

#9
update articulo
set precio = precio*1.2
where articulo.codigo in 
(select articulo_codigo from tiene group by articulo_codigo having sum(stock) < 20);

#10
select avg(prom) from 
(select count(*) as prom from compuesto_por group by articulo_codigo) as sub;

#11
select almacen_codigo, max(articulo.precio), min(articulo.precio), avg(articulo.precio) from tiene 
join articulo on articulo_codigo = articulo.codigo 
group by almacen_codigo;

#12
select almacen_codigo, sum(articulo.precio*stock) from tiene 
join articulo on articulo_codigo = articulo.codigo 
group by almacen_codigo;

#13
select articulo.codigo, sum(articulo.precio*stock) from articulo 
join tiene on tiene.articulo_codigo = articulo.codigo
where stock > 100
group by articulo.codigo;

#14
select compuesto_por.articulo_codigo, count(*) as mats from compuesto_por
join articulo on articulo_codigo = articulo.codigo
where articulo.precio > 5000
group by articulo_codigo
having mats > 3;

#15
select material.codigo, descripcion from material
join compuesto_por on material.codigo = material_codigo
where articulo_codigo in 
(select articulo.codigo from articulo
where articulo.precio > 
(select avg(articulo.precio) from tiene
join articulo on articulo_codigo = articulo.codigo
where almacen_codigo = 2)) #poner -1 para probar si funciona
group by material.codigo;
