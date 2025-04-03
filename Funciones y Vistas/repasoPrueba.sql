CREATE DEFINER=`alumno`@`localhost` FUNCTION `clienteFrecuente`(idCl varchar(10)) RETURNS tinyint(1)
    DETERMINISTIC
begin
	declare comprasTotales int;
    declare comprasCliente int;
	select count(*) into comprasTotales from pedido;
	select count(*) into comprasCliente from pedido
    where Cliente_codCliente = idCl;
    
    if((comprasTotales * 0.05) <= comprasCliente) then #esta mal lo q comparas, nunca van a ser iguales
		return 1;
	else
		return 0;
    end if;
end

############################################################

CREATE DEFINER=`alumno`@`localhost` FUNCTION `estadoPedidos`(idCl varchar(20)) RETURNS int
    DETERMINISTIC
begin
	declare pedidoPendientePago int;
	select count(*) into pedidoPendientePago from pedido
    join estado on estado.idEstado = pedido.Estado_idEstado
    where pedido.Cliente_codCliente = idCl and estado.idEstado = 1;
    return pedidoPendientePago;
end

############################################################

CREATE DEFINER=`alumno`@`localhost` FUNCTION `precioPromedio`(codProduc int) RETURNS float
    DETERMINISTIC
begin
	declare precio float;
    select avg(producto_proveedor.precio) into precio from producto_proveedor 
    where Producto_codProducto = codProduc;
    return precio;
end

############################################################

CREATE DEFINER=`alumno`@`localhost` FUNCTION `proveedorFrecuente`(idPr int) RETURNS tinyint(1)
    DETERMINISTIC
begin
	declare ingreso int;
    declare ingresoPr int;
    select count(*) into ingreso from ingresostock;
    select count(*) into ingresoPr from ingresostock where Proveedor_idProveedor = idPr;
    if ((ingreso * 0.05) <= ingresoPr) then
		return true;
	else
		return false;
	end if;
end
