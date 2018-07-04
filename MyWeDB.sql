/********************************************************
This script creates the database named MyWebDB 
*********************************************************/
USE master;
GO

IF  DB_ID('MyWebDB') IS NOT NULL
DROP DATABASE MyWebDB;
GO

/***** Object:  Create Database MyWebDB ******/
IF DB_ID('MyWebDB') IS NOT NULL
    DROP DATABASE MyWebDB
GO

CREATE DATABASE MyWebDB

USE MyWebDB
GO

/***** Object: Table Products ******/
CREATE TABLE Products
(ProductID int PRIMARY KEY NOT NULL,
ProductName varchar(50) NOT NULL)

CREATE INDEX IX_ProductName
    ON Products (ProductName)
GO

/****** Object: Table Users  ******/
CREATE TABLE Users
(UserID int PRIMARY KEY NOT NULL,
FirstName nvarchar(50) NOT NULL,
LastName nvarchar(50) NOT NULL,
EmailAddress nvarchar(50) NOT NULL)

CREATE INDEX IX_EmailAddress
    ON Users (EmailAddress)
GO

/****** Object:  Table Downloads     ******/
CREATE TABLE Downloads
(DownloadID int PRIMARY KEY NOT NULL,
UserID int NOT NULL,
DownloadDate datetime NOT NULL,
FileName nvarchar(50) NOT NULL,
ProductID int NOT NULL,
CONSTRAINT fk_DownloadUser FOREIGN KEY(UserID)
		REFERENCES Users(UserID),
	CONSTRAINT fk_DownloadProducts FOREIGN KEY(ProductID)
		REFERENCES Products(ProductID));


/** Object: Insert the data into tables  ***/
INSERT Users (UserID, FirstName, LastName, EmailAddress)
VALUES
(1, 'John', 'Smith', 'johnsmith@gmail.com'),
(2, 'Jane', 'Doe', 'janedoe@yahoo.com')

INSERT Products (ProductID, ProductName) 
VALUES
(1, 'Transformers IV'),
(2, 'Lost V')


INSERT Downloads (DownloadID, UserID, DownloadDate, FileName, ProductID)
VALUES
(1, 1, GETDATE(),'Sci_Fiction_Movie_TransformerIV',2),
(2, 2, GETDATE(),'Sci_Fiction_Movie_LostV',1),
(3, 2, GETDATE(),'Sci_Fiction_Movie_TransformerIV',2)

-- Extract the custmer email_address, names, download date, file and product				    
SELECT u.EmailAddress as email_address, u.FirstName as first_name, u.LastName as last_name,
       d.DownloadDate as download_date, d.FileName as filename, p.ProductName as product_name  
FROM Downloads d Join Users u
  ON d.UserID = u.UserID
Join Products p
  ON d.ProductID = p.ProductID
ORDER BY email_address DESC, product_name;
				  
