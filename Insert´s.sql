--Inserts repartidores
select * from repartidor

select ins_repartidor(8994168, 'Diego André', 'Casasola Flores', 72687912, 'root', '18-07-2000', 'Navi', '3210DCK', 'Honda');
select ins_repartidor(123456, 'Joel', 'Arias', 456789,'root', '20-03-2000', 'Vitara', '4210BXD', 'Suzuki');
select ins_repartidor(111222333, 'Herman', 'Reimer', 123654987, 'root', '03-10-2000', 'Celerio', '4567ABC', 'Suzuki');
select ins_repartidor(223344, 'Alejandro', 'Huaita', 321654, 'root','23-07-2000', 'Sentra', '2307DMF', 'Nissan');

delete from repartidor;

insert into hamburguesa values(1, 'Whopper', 51);
insert into hamburguesa values(2, 'Whopper Jr.', 23);


insert into acompañamiento values(1, 'Papas', 5);
insert into acompañamiento values(2, 'Tocino', 5);


select autenticar('Tiago', 'Hola')

select * from clientes

insert into ubicacion values(1, 'Av. Mutualista Nro. 2200, a lado de interpol', 'Los tucanes', 2200)

select ins_cliente(4686482, 'Tiago','Casasola Miranda', 73186973, 'Hola', 1)

insert into pedido_factura values(1, '1 Hamburguesa', 'Efectivo', '4686482', false, current_timestamp, 4686482, 123456, 1, 1)

insert into sucursal values (1, 'Hamburgueseria', 'Av. Japon')
select ins_cliente(456789,'Diego','Casasola',65415887,'12345');
select ins_cliente(123456, 'Herman', 'Reimer', 72687912, 'root')

select ins_repartidor(654321, 'Sergio', 'Aguirre', 45678932, 'root', '18/08/1998', 'Celica', '2307DMF', 'Toyota')

insert into ubicacion values(default,'2do anillo','Av. Pirai',5,123456);
insert into sucursal values(1,'cristo redentor','Cristo 2do anillo');
insert into pedido_factura values(default,'Compra ','contado','1234567890',true ,'25/11/2020',123456,123456,1,2);
insert into pedido_factura values(default,'Compra ','contado','1234567890',true,'25/11/2020',456789,654321,1,1);
insert into pedido_factura values(default,'Compra ','contado','1234567890',true,'16/02/2020',456789,654321,1,1);

insert into detalle_pedidos values(default,'Pedido de cliente',2,1,null,1);
insert into detalle_pedidos values(default,'Pedido de cliente',2,1,null,1);
insert into detalle_pedidos values(default,'Pedido de cliente',1,2,1,2);