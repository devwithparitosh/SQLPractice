-- Columnstore Indexes
-- Syntax :- CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] 
--				INDEXES IDX_NAME ON TABLE_NAME [COLMUN_NAME]

-- RULE:- You can't specifiy columns in CLUSTERED index columnstore.

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;

Create Clustered Columnstore Index idx_DBCustomers_CS
ON Sales.DBCustomers;

/* CREATE NONCLUSTERED COLUMNSTORE INDEX index_Customers_lastname
ON Sales.DBCustomers (lastName);  */    -- Not Allowed because already have one columnstore index