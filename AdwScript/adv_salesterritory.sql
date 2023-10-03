--DROP TABLE adv_salesterritory;
--SELECT * FROM adv_salesterritory;
CREATE TABLE adv_salesterritory(
	TerritoryID int NOT NULL,
	Name nvarchar2(100) NOT NULL,
	GroupName nvarchar2(50) NOT NULL
); 

--
INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (1, N'Northwest', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (2, N'Northeast', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (3, N'Central', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (4, N'Southwest', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (5, N'Southeast', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (6, N'Canada', N'North America')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (7, N'France', N'Europe')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (8, N'Germany', N'Europe')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (9, N'Australia', N'Pacific')
;INSERT INTO adv_salesterritory (TerritoryID, Name, GroupName) VALUES (10, N'United Kingdom', N'Europe')