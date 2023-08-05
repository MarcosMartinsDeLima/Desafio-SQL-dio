-- criaçao do banco de dados voltado á ecomerce 
create database ecomerce;
use ecomerce;

-- criação de tabelas
-- cliente
create table clients(
	id_client int auto_increment primary key,
    fname varchar(15),
    minit char(3),
    lname varchar(15),
    cpf char(11) not null,
    adress varchar(30),
    constraint unique_cpf_client unique(cpf) );
    
    alter table clients auto_increment = 1;
    
    -- produto
create table product(
	id_product int auto_increment primary key,
    pname varchar(10) not null,
    classification_kids boolean default false,
    category enum('eletronico','roupas','brinquedos','alimento','livros','moveis'),
    avaliation float default 0,
    size varchar(10) );


-- pedido
create table orders(
	id_order int auto_increment primary key,
    id_order_client int,
    order_status enum('cancelado','confirmado','em processamento') not null,
    order_description varchar(255),
    send_value float default 10,
    constraint fk_order_client foreign key(id_order_client) references clients(id_client) );
alter table orders drop column order_status;
alter table orders add column order_status enum('cancelado','confirmado','em processamento') default 'em processamento';
desc orders;

    -- pagamento
create table payments(
	id_client int,
	id_payment int,
    id_order int,
    type_payment enum('boleto','cartao') default 'cartao',
    data_valid date,
    primary key(id_client,id_payment),
    constraint fk_payment_order foreign key(id_order) references orders(id_order),
    constraint check(data_valid >='2023-08-01')
    );
    
    -- estoque
create table product_storage(
	id_storage int auto_increment primary key,
	storage_location varchar(255),
    quantity int default 0
    );
 -- fornecedor   
create table supplier(
	id_supplier int auto_increment primary key,
    social_name varchar(255) not null,
    cnpj char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (cnpj)
    );

-- vendedor
create table seller(
	id_seller int auto_increment primary key,
	social_name varchar(255) not null,
    abst_name varchar(255),
    cnpj char(15) ,
    cpf char(9) ,
    contact char(11) not null,
    constraint unique_seller unique (cnpj),
    constraint unique_cpf_seller unique (cpf)
    );
    
    -- relacionado produto vendedor
create table product_seller(
	id_p_seller int,
    id_product int,
    product_quantity int default 1,
    primary key (id_p_seller,id_product),
    constraint fk_product_seller foreign key (id_p_seller) references seller(id_seller),
    constraint fk_product_product foreign key (id_product) references product(id_product)
);

-- relacionado produto pedido
create table product_order(
	id_po_product int,
    id_po_order int,
    po_quantity int default 1,
    po_status enum('disponivel','sem estoque') default 'disponivel',
    primary key (id_po_product,id_po_order),
	constraint fk_productorder_seller foreign key (id_po_product) references product(id_product),
    constraint fk_productorder_product foreign key (id_po_order) references orders (id_order)
);

-- relacionado a estoque e produto
create table storage_location(
	id_l_product int,
    id_l_storage int ,
    location varchar(255) not null,
    primary key (id_l_product,id_l_storage),
    constraint fk__storage_location_product foreign key (id_l_product) references product(id_product),
    constraint fk_storage_location_storage foreign key (id_l_storage) references product_storage(id_storage)
);

drop table storage_location;

create table product_supplier(
	id_ps_supplier int,
    id_ps_product int,
    quantity int not null,
    primary key(id_ps_supplier,id_ps_product),
    constraint fk_supplier_supplier foreign key (id_ps_supplier) references supplier(id_supplier),
    constraint fk_supplier_product foreign key (id_ps_product) references product(id_product)
);

