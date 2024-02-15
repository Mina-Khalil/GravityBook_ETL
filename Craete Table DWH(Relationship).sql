-- Create Dim_Book
CREATE TABLE [Dim_Book]
(
    [book_id_BK] INT PRIMARY KEY,
    [BookID_SK] INT IDENTITY(1,1),
    [title] VARCHAR(400),
    [isbn13] VARCHAR(13),
    [language_id_BK] INT,
    [num_pages] INT,
    [publication_date] DATE,
    [publisher_id_BK] INT,
    [langauge_code] VARCHAR(8),
    [language_name] VARCHAR(50),
    [publisher_name] NVARCHAR(1000),
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT
);

-- Create Dim_Customer
CREATE TABLE [Dim_Customer]
(
    [customer_id_SK] INT IDENTITY(1,1), -- Auto-incrementing column
    [customer_id_BK] INT PRIMARY KEY,
    [first_name] VARCHAR(200),
    [last_name] VARCHAR(200),
    [email] VARCHAR(350),
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT
);

-- Create Dim_Status
CREATE TABLE Dim_Status
(
    [status_id_SK] INT IDENTITY(1,1), -- Auto-incrementing column
    [status_id_PK] INT PRIMARY KEY,
    [HistoryID_BK] INT,
    [status_date] DATEtIME,
    [status_value] VARCHAR(50),
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT
);

-- Create Dim_Shipping_Method
CREATE TABLE Dim_Shipping_Method
(
    [shipping_method_SK] INT IDENTITY(1,1), -- Auto-incrementing column
    [shipping_method_BK] INT PRIMARY KEY,
    [Method_name] VARCHAR(50),
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT
);

-- Create Dim_Address
CREATE TABLE Dim_Address
(
    [address_id_PK] INT PRIMARY KEY,
    [address_id_SK] INT IDENTITY(1,1), -- Auto-incrementing column
    [Address_status] VARCHAR(30),
    [street_number] VARCHAR(10),
    [street_name] VARCHAR(200),
    [city] VARCHAR(100),
    [country_name] VARCHAR(200),
    [customer_id] INT,
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT,
    [source_system_code] INT,
    FOREIGN KEY ([customer_id]) REFERENCES [Dim_Customer]([customer_id_BK])
);

-- Create Dim_Author
CREATE TABLE Dim_Author
(
    [author_SK] INT IDENTITY(1,1), -- Auto-incrementing column
    [author_id_PK] INT PRIMARY KEY,
    [book_id_BK] INT,
    [author_name] VARCHAR(400),
    [start_date] DATETIME,
    [end_date] DATETIME,
    [is_current] BIT,
    [source_system_code] INT,
    FOREIGN KEY ([book_id_BK]) REFERENCES [Dim_Book]([book_id_BK])
);

-- Create Fact_Order
CREATE TABLE Fact_Order
(
    [Fact_Order_PK_SK] INT PRIMARY KEY,
    [BookID_FK] INT,
    [CustomerID_FK] INT,
    [OrderID_FK] INT,
    [OrderDate_FK] DATE,
    [shipping_method_FK] INT,
    [OrderPrice] decimal(5, 2), 
    [created_at] DATE,
    [method_cost] decimal(6, 2), 
    [lastModifiedDate] DATETIME,
    FOREIGN KEY ([BookID_FK]) REFERENCES [Dim_Book]([book_id_BK]),
    FOREIGN KEY ([CustomerID_FK]) REFERENCES [Dim_Customer]([customer_id_BK]),
    FOREIGN KEY ([shipping_method_FK]) REFERENCES [Dim_Shipping_Method]([shipping_method_BK]),
	FOREIGN KEY ([OrderDate_FK]) REFERENCES [DimDate]([Date]),

);

-- Create Fact_Order_History
CREATE TABLE Fact_Order_History
(
    [HistoryID_BK] INT PRIMARY KEY,
    [status_ID_BK] INT,
    [order_ID_BK] INT,
    [order_date] DATETIME,
    [customer_ID] INT,
    [status_received] VARCHAR(50),
    [status_pending] VARCHAR(50),
    [status_inprogress] VARCHAR(50),
    [status_delivered] VARCHAR(50),
    [status_cancelled] VARCHAR(50),
    [status_returned] VARCHAR(50),
    [received_date] DATETIME,
    [inprogress_date] DATETIME,
    [delivered_date] DATETIME,
    [cancelled_date] DATETIME,
    [returned_date] DATETIME,
    FOREIGN KEY ([status_ID_BK]) REFERENCES [Dim_Status]([status_id_PK]),
	FOREIGN KEY ([order_date]) REFERENCES [DimDate]([Date]),
	FOREIGN KEY ([received_date]) REFERENCES [DimDate]([Date]),
	FOREIGN KEY ([inprogress_date]) REFERENCES [DimDate]([Date]),
	FOREIGN KEY ([delivered_date]) REFERENCES [DimDate]([Date]),
	FOREIGN KEY ([cancelled_date]) REFERENCES [DimDate]([Date]),
	FOREIGN KEY ([returned_date]) REFERENCES [DimDate]([Date]),

);
