use ecomerce;
show tables;

-- inserindo dados
insert into clients(fname,minit,lname,cpf,adress) 
	values  ('Maria','M','silva',9123456789,'rua silva de prata-centro'),
			('João','A','Clemente',298456137,'rua alameda 255'),
            ('Clayton','J','Pimentel',495861234,'rua laranjeiras 489,centro'),
            ('Matheus','K','França',598561234,'rua da alvorada 989'),
            ('Julia','D','Assis',598461529,'avenida alameda vinha 1009'),
            ('Isabella','L','Martins',125498656,'rua alameda das flores 455');

select * from clients;

insert into product(pname,classification_kids,category,avaliation,size)
	values	('Headset',false,'eletronico',4,null),
			('Barbie',true,'brinquedos',5,null),
            ('bodyCarter',true,'roupas',3,null),
            ('microfone',false,'eletronico',4,null),
            ('sofa',false,'moveis',3.5,'3x57x80'),
            ('arroz',false,'alimento',3,'1kg'),
            ('fire stick',false,'eletronico',4,null);
select * from product;

insert into orders(id_order_client,order_status,order_description,send_value)
	values	(1,default,'compra via aplicativo',null),
			(2,default,'compra via aplicativo',50),
            (3,'confirmado',null,null),
            (4,default,'compra via web site',150);
select * from orders;
			
insert into payments(id_client,id_payment,type_payment,data_valid)
	values	(1,1,'boleto',null),
			(2,2,default,'2023-08-20'),
            (3,3,'boleto',null),
            (4,4,'boleto',null),
            (5,5,default,'2030-01-01'),
            (6,6,default,'2033-01-03');
select * from payments;
  
insert into product_storage(storage_location,quantity)
	values	('Rio de janeiro',1000),
			('Rio de janeiro',500),
            ('Brasilia',789),
            ('São paulo',440),
            ('São paulo',150),
            ('São paulo',500);
select * from product_storage;

insert into storage_location(id_l_product,id_l_storage ,location)
	values	(22,1,'rj'),
			(23,2,'go');

select * from storage_location;

insert into supplier(social_name,cnpj,contact)
	values	('almeida e filhos',129850483298765,119837689),
			('Eletronicos silva',675893458976854,11976854786),
            ('silvinir',876857483876856,11935894876);
select * from supplier;
            
insert into product_supplier(id_ps_supplier,id_ps_product,quantity)
	values	(1,22,500),
			(2,23,900),
            (3,24,570);

insert into seller(social_name,abst_name,cnpj,cpf,contact)
	values	('tech eletronics',null,879605984884732,null,11947837668),
			('botique drall',null,348276859483768,null,11967785643),
            ('kids world',null,null,482121989,11923274876);
            
select * from seller;

insert into product_seller(id_p_seller,id_product,product_quantity)
	values (1,22,80),
		   (2,23,10);
           
-- consultando dados

-- retornando total de clientes
select count(*) from clients;

-- retornando as informações do pedido relacionadas do cliente
select * from clients c,orders o where c.id_client = id_order_client;

-- retornando nome completo dos clientes
select concat(fname,' ',minit,' ',lname) as complete_name from clients;

-- retornando total de pedidos dos clientes
select c.id_client,fname, count(*) as number_of_orders from clients c 
			inner join orders o on c.id_client = o.id_order_client
		group by id_client;
 
 -- retornando tipo de pagamento escolhido por cada pessoa,em ordem de pagamento
select type_payment,fname,lname from payments inner join clients
		on payments.id_client  = clients.id_client order by type_payment;
        
-- retornando apenas produtos eletronicos
select * from product where category = 'eletronico';
   
-- retornando apenas os produtos com avaliação maior que 3 
select * from product where avaliation >=3 
	order by avaliation desc;
        
        

