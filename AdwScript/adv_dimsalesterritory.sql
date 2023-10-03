--DROP TABLE adv_dimsalesterritory;
--SELECT * FROM adv_dimsalesterritory;
CREATE TABLE adv_dimsalesterritory(
	SalesTerritoryKey int NOT NULL,
	SalesTerritoryRegion nvarchar2(50) NOT NULL,
	SalesTerritoryCountry nvarchar2(50) NOT NULL,
	SalesTerritoryGroup nvarchar2(50) NULL
);

INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (1, N'Northwest', N'United States', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (2, N'Northeast', N'United States', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (3, N'Central', N'United States', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (4, N'Southwest', N'United States', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (5, N'Southeast', N'United States', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (6, N'Canada', N'Canada', N'North America')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (7, N'France', N'France', N'Europe')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (8, N'Germany', N'Germany', N'Europe')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (9, N'Australia', N'Australia', N'Pacific')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (10, N'United Kingdom', N'United Kingdom', N'Europe')
;INSERT INTO adv_dimsalesterritory (SalesTerritoryKey, SalesTerritoryRegion, SalesTerritoryCountry, SalesTerritoryGroup) VALUES (11, N'NA', N'NA', N'NA')

