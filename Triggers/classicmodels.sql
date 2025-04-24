#1

create table customers_audit (
	idAudit int auto_increment not null primary key,
    operacion char(8),
    Last_date_modified date,
    customerName varchar(50),
    phone int,
    addressLine1 varchar(50),
    city varchar(50),
    country varchar(50)
);

delimiter //
create trigger insertCustomerAudit after insert on customers
for each row
begin
	insert into customers_audit values 
    ("INSERT", current_date(), new.customerName, new.phone, new.addressLine1, new.city, new.country);
end//
delimiter ;

# Autoincrement
# Eliminar un trigger


# 2

delimiter //
create trigger updateCustomerAudit before update on customers
for each row
begin
	insert into customers_audit values
    ("UPDATE", current_date(), old.customerName, old.phone, old.addressLine1, old.city, old.country);
end//
delimiter ;


# 3

delimiter //
create trigger deleteCustomerAudit before delete on customers
for each row
begin
	insert into customers_audit values
    ("DELETE", current_date(), old.customerName, old.phone, old.addressLine1, old.city, old.country);
end//
delimiter ;
