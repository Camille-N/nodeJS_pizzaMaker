
DROP DATABASE IF EXISTS menu_pizza;

CREATE DATABASE menu_pizza default character set 'utf8';

use menu_pizza;

set foreign_key_checks= 0;

DROP table if exists pizzas;
CREATE TABLE pizzas(
id smallint auto_increment,
nom varchar(30) not null,
base varchar(30) not null,
primary key(id)
)engine=innodb 
default charset=utf8 collate=utf8_unicode_ci;


DROP table if exists ingredients;
CREATE TABLE ingredients(
id smallint auto_increment,
nom varchar(30) not null,
prix decimal(5,2) not null,
primary key(id)
)engine=innodb 
default charset=utf8 collate=utf8_unicode_ci;


DROP table if exists recettes;
CREATE TABLE recettes(
id_pizza smallint not null,
id_ingredient smallint not null,
primary key(id_pizza, id_ingredient),
constraint recettes_to_pizza
foreign key (id_pizza)
references pizzas(id),
constraint recettes_to_ingredients
foreign key (id_ingredient)
references ingredients(id)
)engine=innodb 
default charset=utf8 collate=utf8_unicode_ci;


INSERT INTO pizzas
(nom, base)
VALUES
('Margherita', 'sauce tomate'),
('Montagnarde', 'crème fraîche'),
('Royale', 'sauce tomate'),
('Raclette', 'crème fraîche');


INSERT INTO ingredients
(nom, prix)
VALUES
('jambon', 5),
('olives', 2),
('fromage mozarella', 4),
('champignons', 2),
('oignons', 2),
('pommes de terre', 4);

INSERT INTO recettes
(id_pizza, id_ingredient)
VALUES
(1, 2), (1, 3),
(2, 1), (2, 3), (2, 4),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 3), (4, 5), (4, 6);

set foreign_key_checks= 1;
