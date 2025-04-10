#1
delimiter //
create procedure precioMayorPromedio()
begin
	select * from products where buyPrice > (select avg(buyPrice) from products);
end //
delimiter ;

call precioMayorPromedio();


#2
delimiter //
create procedure borrarOrden(idOrder int)
begin
	delete from orderdetails where idOrder = orderNumber;
	delete from orders where idOrder = orderNumber;
end //
delimiter ;

call borrarOrden(10100);


#3
delimiter //
create procedure a()
begin
	
end //
delimiter ;


#4
delimiter //
create procedure listado()
begin
	select * from orders order by status;
end //
delimiter ;

call listado();


#5
delimiter //
create procedure empleadosAcargo()
begin
	select reportsTo, count(*) from employees where reportsTo is not null group by reportsTo;
end //
delimiter ;

call empleadosAcargo();
