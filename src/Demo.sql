create database SanPham;
use SanPham;
create table Products(
id int not null auto_increment primary key ,
pCode int,
productName varchar(50),
productPrice int,
productAmount double,
productDescription varchar(50),
productStatus varchar(50)
);

insert into Products values (1,4,'tu lanh',2000000,40,'500l','con hang');
insert into Products values (2,5,'quat',100000,40,'mau xanh','het hang');
insert into Products values (3,6,'dieu hoa',3000000,50,'loai nho','con hang');
insert into Products values (4,7,'dieu hoa',6000000,100,'loai lon','het hang');

#Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index productsIndex on products(pCode) ;
explain select * from products where pCode =4;
#Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create index pIndex on Products(productName,productPrice);
explain select * from products where productName='quat' or productPrice=100000;

#Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view product_view as select productPrice,pCode,productName,productStatus from products;
#Tiến hành sửa đổi view
update product_view set productPrice = 6000000 where productName='dieu hoa';
#Tiến hành xoá view
DROP view product_view;
#Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure allProducts()
begin
    select * from products;
end //
#tao store procedure de them san pham
delimiter //
create procedure addProducts()
begin
    insert into products values (6,7,'am nuoc sieu toc',500000,50,'mau do','con hang');
end //
call addProducts();
#Tạo store procedure sửa thông tin sản phẩm theo id

delimiter //
create procedure upDateProducts(id1 int)
begin
update Products set id=6,productName='noi com dien',productPrice=2000000,productAmount=40,productDescription='mau do',productStatus='het hang' where id=id1;
end //
call upDateProducts(4);
select * from products;
#Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure removeProductById(id2 int)
begin
    delete Products from Products where id=id2;
call removeProductById(6);
end //