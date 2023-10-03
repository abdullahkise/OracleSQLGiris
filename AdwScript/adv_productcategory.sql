--DROP TABLE adv_productcategory
--SELECT * FROM adv_productcategory
CREATE TABLE adv_productcategory(
	ProductCategoryID int NOT NULL,
	Name nvarchar2(100) NOT NULL
);
 
--
INSERT INTO adv_productcategory (ProductCategoryID, Name) VALUES (4, N'Accessories')
;INSERT INTO adv_productcategory (ProductCategoryID, Name) VALUES (1, N'Bikes')
;INSERT INTO adv_productcategory (ProductCategoryID, Name) VALUES (3, N'Clothing')
;INSERT INTO adv_productcategory (ProductCategoryID, Name) VALUES (2, N'Components')

