#1
delimiter //
create function niveles(idEmpleado int) returns text deterministic
begin
    declare num int;
	select count(*) into num from employees
	where reportsTo is not null and reportsTo = idEmpleado
	group by reportsTo;
    
    if num > 20 then
		return "Nivel 3";
	elseif num > 10 then
		return "Nivel 2";
	else
		return "Nivel 1";
	end if;
		
end//
delimiter ;

select niveles(1102);



#2
delimiter //
create function fechas(fechaA date, fechab date) returns int deterministic
begin
	declare dias int;
    select datediff(fechaA, fechaB) into dias;
    if dias < 0 then
		set dias = dias * -1;
	end if;
    return dias;
end//
delimiter ;

select fechas("2024-01-01", "2024-03-01");



#3
delimiter //
create function estadoOrdenes() returns int deterministic
begin
	declare cantidad int;
    set cantidad = (select count(*) from orders where entrefechas(orderDate, shippedDate) > 10);
    update orders set status = "cancelled" where entrefechas(orderDate, shippedDate) > 10;
    return cantidad;
end// 
delimiter ;
 
select estadoOrdenes;



#4
delimiter //
create function a(a int) returns int deterministic
begin

end//
delimiter ;
