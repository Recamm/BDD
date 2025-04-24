# 1

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

# a
delimiter //
create trigger insertCustomerAudit after insert on customers
for each row
begin
	insert into customers_audit values 
    (null, "INSERT", current_date(), new.customerName, new.phone, new.addressLine1, new.city, new.country);
end//
delimiter ;


# b
delimiter //
create trigger updateCustomerAudit before update on customers
for each row
begin
	insert into customers_audit values
    (null, "UPDATE", current_date(), old.customerName, old.phone, old.addressLine1, old.city, old.country);
end//
delimiter ;


# c
delimiter //
create trigger deleteCustomerAudit before delete on customers
for each row
begin
	insert into customers_audit values
    (null, "DELETE", current_date(), old.customerName, old.phone, old.addressLine1, old.city, old.country);
end//
delimiter ;



# 2
create table employees_audit (
	idAudit int auto_increment not null primary key,
    operacion char(8),
    Last_date_modified date,
    employeeNumber int,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(50),
    jobTitle varchar(50)
);

#a
delimiter //
create trigger insertEmlpoyeesAudit after insert on emlpoyees
for each row
begin
	insert into emlpoyees_audit values
    (null, "INSERT", current_date(), new.emlpoyeeNumber, new.firstName, new.lastName, new.email, new.jobTitle);
end //
delimiter ;

#b
delimiter //
create trigger updateEmlpoyeesAudit before update on emlpoyees
for each row
begin
	insert into emlpoyees_audit values
    (null, "UPDATE", current_date(), old.emlpoyeeNumber, old.firstName, old.lastName, old.email, old.jobTitle);
end //
delimiter ;

#b
delimiter //
create trigger deleteEmlpoyeesAudit before delete on emlpoyees
for each row
begin
	insert into emlpoyees_audit values
    (null, "delete", current_date(), old.emlpoyeeNumber, old.firstName, old.lastName, old.email, old.jobTitle);
end //
delimiter ;


#3

delimiter //
create trigger deleteProductVerify before delete on products
for each row
begin
	declare verify int;
    select (datediff(current_date(), orderDate)/30.44) into verify from orders;
    
    if(verify > 2) then 
		select "Error, tiene ordenes asociadas";
    end if;
    
end //
delimiter ;
