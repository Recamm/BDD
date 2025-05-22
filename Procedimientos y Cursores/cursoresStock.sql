#1
delimiter //
create procedure actualizarStock()
begin
	declare hayFilas boolean default 1;
    declare cods int;
    
    declare cursorA cursor for select codProducto from producto;
    declare continue handler for not found set hayFilas = 0;
    
    open cursorA;
		recorrer:loop
		fetch cursorA into cods;
			if hayFilas = 0 then
				leave recorrer;
			end if;
            
            update producto 
            set stock = stock + (select sum(cantidad) from ingresostock_producto
            join ingresostock on idIngreso = ingresostock_producto
            where Producto_codProducto = cods and week(fecha) = week(current_date()))
            and codProducto = cods;
        
        end loop recorrer;
	close cursorA;
end //
delimiter ;


#2
delimiter //
create procedure reductorPrecio()
begin

	declare hayFilas boolean default 1;
    declare cods int;
    
    declare curorB cursor for select codProducto from producto;
    declare continue handler for not found set hayFilas = 0;
    
    open cursorB;
		recorrer:loop
        fetch cursorB into cods;
			if hayFilas = 0 then
				leave recorrer;
			end if;
            
            update producto set precio = precio * 0.9
            where 100 > (select ifnull(sum(cantidad), 0) from pedido 
            join pedido_producto on idPedido = Pedido_idPedido 
            where Producto_codProducto = cods and week(fecha) = week(current_date()));
            
		end loop recorrer;
	close cursorB;

end //
delimiter ;
