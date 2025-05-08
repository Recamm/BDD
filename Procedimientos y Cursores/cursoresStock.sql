#1
delimiter //
create procedure actualizacionStockProductos ()
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
            
            update producto set stock = stock + 
            (select sum(cantidad) from ingresostock_producto 
            join ingresostock on ingresostock.idIngreso = ingresostock_producto.IngresoStock_idIngreso
            where week(ingresostock.fecha) = week(current_date()) ) where cods = producto.codProducto;
            
	end loop recorrer;
    close cursorA;
end//
delimiter ;


#2
delimiter //
create procedure reducirPrecioProductos()
begin
	declare hayFilas boolean default 1;
    declare cod int;
    
    declare cursorB cursor for select codProducto from producto;
    declare continue handler for not found set hayFilas = 0;
    
    open cursorB;
    
    loopeado:loop
    fetch cursorB into cod;
		
        if hayFilas = 0 then
			leave loopeado;
		end if;
        
        update producto set precio = (select (precio * 0.9) from producto
        join pedido_producto on pedido_producto.Producto_codProducto = producto.codProducto
        where codProducto = cod and 
        (select sum(cantidad) from pedido_producto where Producto_codProducto = cod) > 100);
        
    end loop loopeado;
    close cursorB;
end //
delimiter ;
