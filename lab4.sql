Lab 4.1

CREATE TABLE "TransactionDetails".transactions (
	transactionid bigint GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1)
						PRIMARY KEY NOT NULL,
	customerid bigint NOT NULL,
	transactiontype int NOT NULL,
	dateentered timestamp(0) NOT NULL,
	amount numeric(18,5) NOT NULL,
	referencedetails varchar(50) NULL,
	notes varchar NULL,
	relatedshareid bigint NULL,
	relatedproductid bigint NOT NULL);
	
	
CREATE TABLE "TransactionDetails".transactiontypes (
	transactiontypesid int GENERATED ALWAYS AS IDENTITY NOT NULL,
	transactiondescription varchar(30) NOT NULL,
	credittype boolean NOT NULL);
	

ALTER TABLE "TransactionDetails".transactiontypes
ADD affectcashbalance boolean NULL;


ALTER TABLE "TransactionDetails".transactiontypes
ALTER COLUMN affectcashbalance SET NOT NULL;	

	
ALTER TABLE "TransactionDetails".transactiontypes
ADD CONSTRAINT PK_TrasactionTypes PRIMARY KEY (transactiontypesid);


CREATE TABLE "CustomerDetails".customersproducts (
	customerfinancialproductid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	customerid bigint NOT NULL,
	financialproductid bigint NOT NULL,
	amounttocollect money NOT NULL,
	frequency int NOT NULL,
	lastcollected timestamp(0) NOT NULL,
	lastcollection timestamp(0) NOT NULL,
	renewable boolean NOT NULL);	
	
	
CREATE TABLE "CustomerDetails".financialproducts (
	productid bigint NOT NULL,
	productname varchar(50) NOT NULL);
	
	
CREATE SCHEMA "ShareDetails" AUTHORIZATION postgres;


CREATE TABLE "ShareDetails".shareprices (
	sharepriceid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	shareid bigint NOT NULL,
	price numeric(18,5) NOT NULL,
	pricedate timestamp(0) NOT NULL);
	
	
CREATE TABLE "ShareDetails".shares (
	shareid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	sharedesc varchar(50) NOT NULL,
	sharetickerid varchar(50) NULL,
	currentprice numeric(18,5) NOT NULL);
	
	
ALTER TABLE "TransactionDetails".transactions
ADD CONSTRAINT fk_transactions_shares FOREIGN KEY (relatedshareid)
REFERENCES "ShareDetails".shares(shareid); 	


Lab 4.2

CREATE INDEX ix_customersproducts
ON "CustomerDetails".customersproducts (CustomerId);


CREATE UNIQUE INDEX ix_transactiontypes
	ON "TransactionDetails".transactiontypes
	USING btree
	(transactiontypesid ASC);


ALTER TABLE IF EXISTS "TransactionDetails".transactiontypes
	CLUSTER ON ix_transactiontypes;
	
	
CREATE INDEX ix_transactions_ttypes
	ON "TransactionDetails".transactions
	USING btree
	(transactiontype ASC);
	

DROP INDEX "TransactionDetails".ix_transactiontypes;	


CREATE UNIQUE INDEX ix_shareprices
ON "ShareDetails".shareprices (ShareID ASC, PriceDate ASC);


DROP INDEX IF EXISTS "ShareDetails".ix_shareprices;


CREATE UNIQUE INDEX ix_shareprices
ON "ShareDetails".shareprices (ShareID ASC, PriceDate DESC, Price);