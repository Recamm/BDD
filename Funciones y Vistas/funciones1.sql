#1
delimiter //
create function ordenesFechaEstado(fechaInicio date, fechaFin date, estado text) returns int deterministic
begin
	declare cantidadOrdenes int default 0;
    select count(*) into cantidadOrdenes from orders 
    where orderDate > fechaInicio and orderDate < fechaFin and status = estado;
    return cantidadOrdenes;
end//
delimiter ;

select ordenesFechaEstado("2004-03-25", "2004-08-02", "Shipped");



#2
delimiter //
create function ordenesEntregadas(fechaInicio date, fechaFin date) returns int deterministic
begin
	declare cantidadOrdenes int default 0;
	select count(*) into cantidadOrdenes from orders
    where shippedDate > fechaInicio and shippedDate < fechaFin and status = "Shipped";
    return cantidadOrdenes;
end//
delimiter ;

select ordenesEntregadas("2004-03-25", "2004-08-02");



#3
delimiter //
create function ciudadEmlpeado(idCliente int) returns text deterministic
begin
	declare pais text default "";
	select offices.country into pais from offices
	join employees on employees.officeCode = offices.officeCode
	join customers on employees.employeeNumber = customers.salesRepEmployeeNumber
    where customers.customerNumber = idCliente;
    return pais;
end//
delimiter ;

select ciudadEmlpeado(103);



#4
delimiter //
create function prdLine(prod text) returns int deterministic
begin
	declare prodBuscar int;
	select count(*) into prodBuscar from products
    where productLine = prod;
    return prodBuscar;
end //
delimiter ;

select prdLine("Classic Cars");



#5
delimiter //
create function clientsNumbers(ofcCode int) returns int deterministic
begin
	declare nroCl int;
    select count(*) into nroCl from offices
	join employees on employees.officeCode = offices.officeCode
	join customers on employeeNumber = salesRepEmployeeNumber
	where offices.officeCode = ofcCode;
    return nroCl;
end //
delimiter ;

select clientsNumbers(1);


#6
delimiter //
create function ordenesCant(ofcCode int) returns int deterministic
begin
	declare nroPedidos int;
	select count(*) into nroPedidos from offices
	join employees on employees.officeCode = offices.officeCode
	join customers on employeeNumber = salesRepEmployeeNumber
    join orders on customers.customerNumber = orders.customerNumber
    where offices.officeCode = ofcCode;
    return nroPedidos;
end //
delimiter ;

select ordenesCant(1);




#7
delimiter //
create function proffitProdOrder(orden int, prod text) returns int deterministic
begin
	declare proff int;
	select (priceEach - buyPrice) into proff from orders
	join orderdetails on orderdetails.orderNumber = orders.orderNumber
	join products on products.productCode = orderdetails.productCode
	where orders.orderNumber = orden and products.productCode = prod;
    return proff;
end //
delimiter ;

select proffitProdOrder(10104, "S24_4048");



#8
delimiter //
create function canceladoo(ordId int) returns int deterministic
begin
	declare numero int;
    declare condicion text;
    select status into condicion from orders where ordId = orderNumber;
    if condicion = "Cancelled" then
		set numero = -1;
	else 
		set numero = 0;
	end if;
    return numero;
end //
delimiter ;


select canceladoo(10167);



#9
delimiter //
create function firstOrder(clientId int) returns date deterministic
begin
	declare fecha date;
	select orders.orderDate into fecha from customers 
	join orders on customers.customerNumber = orders.customerNumber
	where customers.customerNumber = clientId
	order by orders.orderDate limit 1;
    return fecha;
end //
delimiter ;

select firstOrder(181);



#10
delimiter //
create function mrspPcj(prodCode text) returns int deterministic
begin
	declare total int;
    declare menosQue int;
    declare cuenta int;
    
    select count(*) into total from products
	join orderdetails on products.productCode = orderdetails.productCode
	where products.productCode = prodCode;

	select count(*) into menosQue from products
	join orderdetails on products.productCode = orderdetails.productCode
	where priceEach < MSRP and products.productCode = prodCode;
    
    set cuenta = (menosQue/total)*100;
    return cuenta;
end //
delimiter ;

select mrspPcj("S18_1589");



#11
delimiter //
create function ordenUltimaFecha(prodCode text) returns date deterministic
begin
	declare fecha date;
	select orderDate into fecha from orderdetails 
	join orders on orders.orderNumber = orderdetails.orderNumber
	where productCode = prodCode
	order by orderDate desc limit 1;
    return fecha;
end //
delimiter ;

select ordenUltimaFecha("S18_1749");



#12
delimiter //
create function prodMaxCompra(prodCode text, fechaInicio date, fechaFinal date) returns int deterministic
begin
	declare num int;
	select max(priceEach * quantityOrdered) into num from orderdetails
	join orders on orders.orderNumber = orderdetails.orderNumber
	where orders.orderDate > fechaInicio and orders.orderDate < fechaFinal and productCode = prodCode;
    	if num is null then
		set num = 0;
	end if;
    return num;
end //
delimiter ;

select prodMaxCompra("S10_1678", "2003-05-01", "2003-07-01");



#13
delimiter //
create function empleadoClientes(idEmpleado int) returns int deterministic
begin
	declare num int;
    select count(*) into num from employees
	join customers on employeeNumber = salesRepEmployeeNumber
	where employeeNumber = idEmpleado;
    return num;
end //
delimiter ;

select empleadoClientes(1370);



#14
delimiter //
create function empleadoNombre(idEmpleado int) returns text deterministic
begin
	declare apellido text;
    select lastName into apellido from employees
    where employeeNumber in (select reportsTo from employees where employeeNumber = idEmpleado);
    return apellido;
end //
delimiter ;

select empleadoNombre(1370);
