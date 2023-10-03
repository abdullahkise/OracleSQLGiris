--DROP TABLE adv_productsubcategory;
--SELECT * FROM adv_productsubcategory;

--
CREATE TABLE adv_productsubcategory(
	ProductSubcategoryID int NOT NULL,
	ProductCategoryID int NOT NULL,
	Name nvarchar2(100) NOT NULL
);

--
INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (1, 1, N'Mountain Bikes')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (2, 1, N'Road Bikes')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (3, 1, N'Touring Bikes')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (4, 2, N'Handlebars')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (5, 2, N'Bottom Brackets')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (6, 2, N'Brakes')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (7, 2, N'Chains')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (8, 2, N'Cranksets')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (9, 2, N'Derailleurs')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (10, 2, N'Forks')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (11, 2, N'Headsets')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (12, 2, N'Mountain Frames')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (13, 2, N'Pedals')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (14, 2, N'Road Frames')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (15, 2, N'Saddles')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (16, 2, N'Touring Frames')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (17, 2, N'Wheels')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (18, 3, N'Bib-Shorts')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (19, 3, N'Caps')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (20, 3, N'Gloves')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (21, 3, N'Jerseys')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (22, 3, N'Shorts')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (23, 3, N'Socks')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (24, 3, N'Tights')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (25, 3, N'Vests')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (26, 4, N'Bike Racks')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (27, 4, N'Bike Stands')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (28, 4, N'Bottles and Cages')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (29, 4, N'Cleaners')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (30, 4, N'Fenders')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (31, 4, N'Helmets')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (32, 4, N'Hydration Packs')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (33, 4, N'Lights')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (34, 4, N'Locks')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (35, 4, N'Panniers')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (36, 4, N'Pumps')
;INSERT INTO adv_productsubcategory (ProductSubcategoryID, ProductCategoryID, Name) VALUES (37, 4, N'Tires and Tubes')