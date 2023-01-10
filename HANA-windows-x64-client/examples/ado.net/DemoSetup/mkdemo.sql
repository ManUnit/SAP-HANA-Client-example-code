-- Statements to undo what we do below

-- DROP INDEX DEMO.FK_CustomerID_ID2
-- DROP INDEX DEMO.FK_ProductID_ID
-- DROP INDEX DEMO.FK_ID_ID
-- DROP INDEX DEMO.FK_SalesRepresentative_EmployeeID
-- DROP INDEX DEMO.FK_FinancialCode_Code
-- DROP INDEX DEMO.FK_CustomerID_ID
-- DROP INDEX DEMO.FK_Code_Code

-- DELETE FROM DEMO.Contacts
-- DELETE FROM DEMO.SalesOrderItems
-- DELETE FROM DEMO.SalesOrders
-- DELETE FROM DEMO.Customers
-- DELETE FROM DEMO.Products
-- DELETE FROM DEMO.FinancialData
-- DELETE FROM DEMO.FinancialCodes
-- UPDATE DEMO.Departments SET DepartmentHead = NULL
-- DELETE FROM DEMO.Employees
-- DELETE FROM DEMO.Departments

-- DROP PROCEDURE DEMO.ShowProductInfo CASCADE
-- DROP VIEW DEMO.ViewSalesOrders CASCADE
-- DROP TABLE DEMO.Contacts CASCADE
-- DROP TABLE DEMO.SalesOrderItems CASCADE
-- DROP TABLE DEMO.SalesOrders CASCADE
-- DROP TABLE DEMO.Customers CASCADE
-- DROP TABLE DEMO.Products CASCADE
-- DROP TABLE DEMO.FinancialData CASCADE
-- DROP TABLE DEMO.FinancialCodes CASCADE
-- DROP TABLE DEMO.Departments CASCADE
-- DROP TABLE DEMO.Employees CASCADE
-- DROP SCHEMA DEMO CASCADE

CREATE SCHEMA DEMO#

SET SCHEMA DEMO#

CREATE COLUMN TABLE DEMO.Customers
(
        ID                    INTEGER PRIMARY KEY,
        Surname               VARCHAR(20) NOT NULL,
        GivenName             VARCHAR(20) NOT NULL,
        Street                VARCHAR(30) NOT NULL,
        City                  VARCHAR(20) NOT NULL,
        State                 VARCHAR(16) NULL,
        Country               VARCHAR(16) NULL,
        PostalCode            VARCHAR(10) NULL,
        Phone                 VARCHAR(13) NOT NULL,
        CompanyName           VARCHAR(32) NULL
)#

CREATE COLUMN TABLE DEMO.Contacts
(
        ID                    INTEGER PRIMARY KEY,
        Surname               VARCHAR( 20 ) NOT NULL,
        GivenName             VARCHAR( 20 ) NOT NULL,
        Title                 VARCHAR( 34 ) NULL,
        Street                VARCHAR( 30 ) NULL,
        City                  VARCHAR( 20 ) NULL,
        State                 VARCHAR( 16 ) NULL,
        Country               VARCHAR( 16 ) NULL,
        PostalCode            VARCHAR( 10 ) NULL,
        Phone                 VARCHAR( 13 ) NULL,
        Fax                   VARCHAR( 13 ) NULL,
        CustomerID            INTEGER NULL DEFAULT NULL
)#

CREATE COLUMN TABLE DEMO.Products
(
        ID                    INTEGER NOT NULL,
        Name                  VARCHAR(15) NOT NULL,
        Description           VARCHAR(30) NOT NULL,
        Size                  VARCHAR(18) NOT NULL,
        Color                 VARCHAR(18) NOT NULL,
        Quantity              INTEGER NOT NULL,
        UnitPrice             FLOAT NOT NULL,
        Photo                 BLOB NULL
)#

CREATE INDEX DEMO.ProductsIX ON DEMO.Products (ID) ASC#

ALTER TABLE DEMO.Products
	ADD CONSTRAINT "ProductsKey"
	PRIMARY KEY (ID)#

CREATE COLUMN TABLE DEMO.SalesOrders
(
        ID                    INTEGER PRIMARY KEY,
        CustomerID            INTEGER NOT NULL,
        OrderDate             DATE NOT NULL,
        FinancialCode         VARCHAR(2) NULL,
        Region                VARCHAR(7) NULL,
        SalesRepresentative   INTEGER NOT NULL
)#

CREATE COLUMN TABLE DEMO.SalesOrderItems
(
        ID                    INTEGER NOT NULL,
        LineID                SMALLINT NOT NULL,
        ProductID             INTEGER NOT NULL,
        Quantity              INTEGER NOT NULL,
        ShipDate              DATE NOT NULL
)#

ALTER TABLE DEMO.SalesOrderItems
        ADD CONSTRAINT "SalesOrderItemsKey"
	PRIMARY KEY (ID, LineID)#

CREATE COLUMN TABLE DEMO.FinancialCodes
(
        Code                  VARCHAR(2) PRIMARY KEY,
        Type                  VARCHAR(10) NOT NULL,
        Description           VARCHAR(50) NULL
)#

CREATE COLUMN TABLE DEMO.FinancialData
(
        Year                  VARCHAR(4) NOT NULL,
        Quarter               VARCHAR(2) NOT NULL,
        Code                  VARCHAR(2) NOT NULL,
        Amount                NUMERIC(9,0) NULL
)#

ALTER TABLE DEMO.FinancialData
	ADD CONSTRAINT "FinancialDataKey"
	PRIMARY KEY (Year, Quarter, Code)#

CREATE COLUMN TABLE DEMO.Departments
(
        DepartmentID          INTEGER PRIMARY KEY,
        DepartmentName        VARCHAR(40) NOT NULL,
        DepartmentHead        INTEGER NULL
)#

CREATE COLUMN TABLE DEMO.Employees
(
        EmployeeID            INTEGER PRIMARY KEY,
        ManagerID             INTEGER NULL,
        Surname               VARCHAR( 20 ) NOT NULL,
        GivenName             VARCHAR( 20 ) NOT NULL,
        DepartmentID          INTEGER NOT NULL,
        Street                VARCHAR( 30 ) NOT NULL,
        City                  VARCHAR( 20 ) NOT NULL,
        State                 VARCHAR( 16 ) NULL,
        Country               VARCHAR( 16 ) NULL,
        PostalCode            VARCHAR( 10 ) NULL,
        Phone                 VARCHAR( 13 ) NULL,
        Status                VARCHAR(2) NULL,
        SocialSecurityNumber  VARCHAR(11) NULL,
        Salary                NUMERIC(20,3) NOT NULL,
        StartDate             DATE NOT NULL,
        TerminationDate       DATE NULL,
        BirthDate             DATE NULL,
        BenefitHealthInsurance VARCHAR(1) NULL,
        BenefitLifeInsurance  VARCHAR(1) NULL,
        BenefitDayCare        VARCHAR(1) NULL,
        Sex                   VARCHAR(2) NULL
)#

ALTER TABLE DEMO.Employees
	ADD CONSTRAINT "SocialSecurityUnique"
	UNIQUE (SocialSecurityNumber)#
	
-- Populate Customers table

INSERT INTO DEMO.Customers VALUES
    ( 101,'Devlin','Michaels','114 Pioneer Avenue','Kingston','NJ','USA','07070','2015558966','The Power Group' )#
INSERT INTO DEMO.Customers VALUES
    ( 102,'Reiser','Beth','33 Whippany Road','Rockwood','NY','USA','10154','2125558725','AMF Corp.' )#
INSERT INTO DEMO.Customers VALUES
    ( 103,'Niedringhaus','Erin','190 Windsor Street','Tara','PA','USA','19301','2155556513','Darling Associates' )#
INSERT INTO DEMO.Customers VALUES
    ( 104,'Mason','Meghan','5520 Dundas Street East','Cheslea','TN','USA','37919','6155555463','P.S.C.' )#
INSERT INTO DEMO.Customers VALUES
    ( 105,'McCarthy','Laura','110 Highway 36','Clinton','IN','USA','46032','3175558437','Amo & Sons' )#
INSERT INTO DEMO.Customers VALUES
    ( 106,'Phillips','Paul','200 Cherry Creek N. Dr.','Brandon','CT','USA','64579','2035553464','Ralston Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 107,'Colburn','Kelly','1131 Vallco Parkway','Chandler','NC','USA','27695-7209','9195555152','The Home Club' )#
INSERT INTO DEMO.Customers VALUES
    ( 108,'Goforth','Matthew','101 Wayzata Blvd.','Harriston','TN','USA','37421','6155558926','Raleigh Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 109,'Gagliardo','Jessie','201 Park Avenue','Preston','PQ','Canada','K1A 0H3','8195559539','Newton Ent.' )#
INSERT INTO DEMO.Customers VALUES
    ( 110,'Agliori','Michael','135 North Glebe Road','Oshawa','OH','USA','43216','6145552496','The Pep Squad' )#
INSERT INTO DEMO.Customers VALUES
    ( 111,'Ricci','Dylan','1470 Prosperity Avenue','Hastings','NY','USA','13202','3155554486','Dynamics Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 112,'McDonough','Shawn','1575 S Main Street','Orillia','MN','USA','55428','6125555603','McManus Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 113,'Kaiser','Samuel','44 Bristol Street','Lake of the Woods','MN','USA','55041','6125553409','Lakes Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 114,'Chopp','Shane','95 Summer Street','Newmarket','MN','USA','55104','6125556453','Howard Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 115,'Phillips','Shannon','2055 Cory Road','Newmarket','MN','USA','55114','6125556425','Sterling & Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 116,'Gugliuzza','Brian','391 Wyman Street','Stayner','NY','USA','10543','9145553817','Sampson & Sons' )#
INSERT INTO DEMO.Customers VALUES
    ( 117,'Morgan','Meredith','9191 Galveston Drive','Unionville','OH','USA','43081','6145558989','Square Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 118,'Sanford','Kristina','22 96th Street','Chandler','NC','USA','27695-7209','9195555152','Raleigh Active Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 119,'Smith','Tomm','37 Post Oak Blvd.','Owen Sound','CA','USA','92677','7145554996','Ocean Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 120,'Steinberg','Gertrude','14 Amon Carter Blvd.','Hockley Valley','NY','USA','10523','9145553476','Carney Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 121,'Elkins','Pete','233 Lawerence Street','Clinton','IN','USA','46032','3175558437','Carmel Industries' )#
INSERT INTO DEMO.Customers VALUES
    ( 122,'Dente','Al','2 N.E. 38th Place','Conestogo','VA','USA','22102','7035557491','Virgina Power' )#
INSERT INTO DEMO.Customers VALUES
    ( 123,'Lin','Amanda','255 North Pine Grove','Pembroke','MB','Canada','R3C 3V6','2045555559','North Land Trading' )#
INSERT INTO DEMO.Customers VALUES
    ( 124,'Farmer','Fanny','240 Barnard Lane','Waterford','MA','USA','01887','6175559386','The Ristuccia Center' )#
INSERT INTO DEMO.Customers VALUES
    ( 125,'Smelledge','Sidney','3125 Merritt Drive','Keswick','MO','USA','63101','3145553426','Bush Pro Shop' )#
INSERT INTO DEMO.Customers VALUES
    ( 126,'Ovar','Sam','23 Lindenwood Drive','King City','CA','USA','94105','4155555972','Golden Gate Active Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 127,'Lamm','Mary','110 McKinney','Dundas','FL','USA','34243','8135557566','The Palms' )#
INSERT INTO DEMO.Customers VALUES
    ( 128,'Mums','Hardy','911 5th Avenue S.W.','Charlottetown','CO','USA','02106','6175554340','BoSox Club' )#
INSERT INTO DEMO.Customers VALUES
    ( 129,'Fahrvergnugen','Karl','113 Armagh Street','Stroud','MD','USA','21202','3015553322','Camden Sports Apparel' )#
INSERT INTO DEMO.Customers VALUES
    ( 130,'Monella','Sal','92 Eastlake Avenue','St. Jacobs','WI','USA','53141','4145556799','Wyse Corp.' )#
INSERT INTO DEMO.Customers VALUES
    ( 131,'Sinnot','Daljit','5145 Presidents Landing','Kenora','NY','USA','11716','5165559811','The Pro Shopp' )#
INSERT INTO DEMO.Customers VALUES
    ( 132,'King','Marilyn','2167 South Ulster','Fort Erie','IN','USA','46801','2195554551','Bristol Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 133,'Bilhome','Moe','18 W. Colfax Avenue','Sauble Beach','CA','USA','91505','8185558455','Bilhome Industries' )#
INSERT INTO DEMO.Customers VALUES
    ( 134,'O''Furniture','Paddy','180 W. Las Colinas','Whitby','OH','USA','44260','2165556283','Gifts & Things' )#
INSERT INTO DEMO.Customers VALUES
    ( 135,'Clarke','Belinda','24 Constitution Avenue','Rockwood','NY','USA','10001','2125555026','Hermanns' )#
INSERT INTO DEMO.Customers VALUES
    ( 136,'Wooten','Tommie','132 Hing Wai Building','Forest Hill','MN','USA','55447','6125553373','Leisure Time' )#
INSERT INTO DEMO.Customers VALUES
    ( 137,'Morfek','Polly','872 Hopyard Road','Hull','IN','USA','46808','2195554297','Sports Plus' )#
INSERT INTO DEMO.Customers VALUES
    ( 138,'Patoff','Regus','222 James Way','Hamilton','ON','Canada','L7N 5L1','9065554252','Sports Replay' )#
INSERT INTO DEMO.Customers VALUES
    ( 139,'Dimitros','Jai','2366 Marineship Way','Charlottetown','CO','USA','02201','6175556354','Martins Landing' )#
INSERT INTO DEMO.Customers VALUES
    ( 140,'Thumb','Thomas','2506 North Vine Street','Glasgow','UT','USA','84180','8015553550','Ski,Ski,Ski' )#
INSERT INTO DEMO.Customers VALUES
    ( 141,'Pyper','Peter','4089 Beta Mall','Fort Erie','IN','USA','46801','2195554552','Mall Side Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 142,'Margolis','Alfredo','40 Bloor Street East','Thunder Bay','MO','USA','64114','8165558543','Creative Customs Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 143,'Piper','Peter','310 Stevens Creek Blvd.','Pembroke','MB','Canada','R3C 3V6','2045559414','Molly''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 144,'Wan','Fangmei','3452 E. Hillsdale','Honey Harbor','MA','USA','01775','5085558979','Green Acre''s Custom Tee''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 145,'Doe','John','346 Wellworth Ave','Ingersol','VA','USA','22030','7035552184','Doe, Rae, Mee' )#
INSERT INTO DEMO.Customers VALUES
    ( 146,'Yost','Alberto','362 White Horse Road','Parry Sound','WA','USA','99216','5095559276','Custom Designs' )#
INSERT INTO DEMO.Customers VALUES
    ( 147,'Lela','Manoj','572 Third Avenue North','Campbellford','NJ','USA','07095','9085556021','Norton Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 148,'Crooker','Beth','450 College Road','Pembroke','MB','Canada','R3C 2P4','2045555554','Cooper Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 149,'Uhnfitte','Hans','9723 West Wacker Dr','Pembroke','MB','Canada','R3C 2P4','2045554744','The Ultimate' )#
INSERT INTO DEMO.Customers VALUES
    ( 150,'Mason','Carl','3087 Powell Street','Windsor','ON','Canada','M3C 3N4','4165555108','Power Play' )#
INSERT INTO DEMO.Customers VALUES
    ( 151,'Sinitskaya','Balwinder','2893 Century Blvd','Drayton','KS','USA','66210','9135554519','Toto''s Active Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 152,'Jones','Frank','8960 Inelt Business Ctr.','Barrie','NY','USA','11746','5165555952','Play it again Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 153,'Jones','Paul','8751 Innovation Drive','Guelph','OH','USA','45202','5135557622','Three Rivers Pro Shop' )#
INSERT INTO DEMO.Customers VALUES
    ( 154,'Smythe','Marvin','6329 North 27th Ave','New Hamburg','FL','USA','33181','3055559457','Marlin Mainia' )#
INSERT INTO DEMO.Customers VALUES
    ( 155,'Phipps','Milo','8230 Osterbrogade','Wiarton','OH','USA','44107','2165552264','Things Remembered' )#
INSERT INTO DEMO.Customers VALUES
    ( 156,'DuCode','Sue','3571 San Thomas Avenue','North Bay','MO','USA','63131','3145558227','Ozzie''s Haven' )#
INSERT INTO DEMO.Customers VALUES
    ( 157,'Watcom','William','3259 Silver Lake Road','Elmira','IL','USA','60645','3125557433','The Cub''s Den' )#
INSERT INTO DEMO.Customers VALUES
    ( 158,'Cass','DEMO','26 West Court Street','Newcastle','IL','USA','02173','6175558610','Jordan''s Basement' )#
INSERT INTO DEMO.Customers VALUES
    ( 159,'Shaw','Rick','15 West Loop South','Thamesford','MI','USA','48324','3135553638','ScrimShaw''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 160,'Nette','Clara','9824 Wilshire Blvd','Laurelwood','NY','USA','11050','5165556250','Discount Department Store' )#
INSERT INTO DEMO.Customers VALUES
    ( 161,'Poole','Gene','286 Vreeland Road','Port Colborne','DC','USA','20581','2025556537','State House Active Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 162,'Toste','Melba','90 51st Ave North','Beechwood','OH','USA','43065','6145558983','The Real Deal' )#
INSERT INTO DEMO.Customers VALUES
    ( 163,'Peese','R.I.','38 Buckingham','North York','ON','Canada','L4W 2S6','4165556026','Mount Eastern Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 164,'Najarian','Aram','257 Cambridge Center','Cambridge','CT','USA','6811','2035557907','Bloomfield''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 165,'Mournen','Tamara','35 Choke Cherry Road','Hull','IN','USA','46808','2195554297','Moran''s Gift Shop' )#
INSERT INTO DEMO.Customers VALUES
    ( 166,'Naddem','Malcolm','9813 Commerce Parkway','Long Point','GA','USA','30518','4045552529','Hospital Gift''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 167,'Cara','Nicklas','5762 State Highway 249','Wiarton','OH','USA','44107','2165552264','The Road Side Inn' )#
INSERT INTO DEMO.Customers VALUES
    ( 168,'de Joie','Almen','2150 Sweitzer Lane','Galt','CA','USA','92649','7145555475','Surf''s Up!' )#
INSERT INTO DEMO.Customers VALUES
    ( 169,'Terlemezian','Laura','123 First Street','Bracebridge','NC','USA','28105','7045558411','CoMed' )#
INSERT INTO DEMO.Customers VALUES
    ( 170,'Neubauer','Manh','236 Haddington Street','Easton','FL','USA','32206','9045553551','Jason''s Sporting Goods' )#
INSERT INTO DEMO.Customers VALUES
    ( 171,'Nahra','Vincent','9873 Harwin Drive','Timmins','IL','USA','60185-1120','3125555551','Iron Mike''s Apparel' )#
INSERT INTO DEMO.Customers VALUES
    ( 172,'Perez','Grace','230 Market Street','Collingwood','MA','USA','20785','3015557728','Avon Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 173,'Pendelton','Grover','861 Merritt Drive','Mississauga','MD','USA','20871','3015554284','Simply Tee''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 174,'Zoblotny','Anabai','36920 N.E. Airport Way','Harvard','CO','USA','80225','3035552757','Hats Etc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 175,'Perkins','Tawfik','325 N.W. 7th Avenue','Halton Hills','BC','Canada','V8W 2B7','6045553801','The Hat Company' )#
INSERT INTO DEMO.Customers VALUES
    ( 176,'Shumovich','Helen','980 Park Plaza #1800','Stroud','MD','USA','21209','4105553322','The Bird''s Loft' )#
INSERT INTO DEMO.Customers VALUES
    ( 177,'Zubenko','Joseph','960 Stonehollow Drive','Chandler','NC','USA','27695','9195555152','Avco Ent.' )#
INSERT INTO DEMO.Customers VALUES
    ( 178,'Naidu','Suresh','351 Sycamore Drive','Ayr','CT','USA','6320','2035554440','Amy''s Silk Screening' )#
INSERT INTO DEMO.Customers VALUES
    ( 179,'Nguyen','Marsha','21 Dunlaney Gate Circle','Goderich','FL','USA','33027','3055554336','Resco' )#
INSERT INTO DEMO.Customers VALUES
    ( 180,'Peros','Edith','39 Market Street','Rockland','NY','USA','14624','7165554275','Breswick''s Department Store' )#
INSERT INTO DEMO.Customers VALUES
    ( 181,'Teeven','Emunah','282 Wilshire Blvd.','Port Colborne','DC','USA','20240','2025552083','Hometown Tee''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 182,'Gardner','Leilani','901 Campus Drive','McCord','CA','USA','30102','4045559283','Polly''s Custom Design' )#
INSERT INTO DEMO.Customers VALUES
    ( 183,'Nakagama','Marilyn','109 Central Avenue','Killarney','FL','USA','32792','4075556776','Zoo Gift Shop' )#
INSERT INTO DEMO.Customers VALUES
    ( 184,'Serafina','Anoush','3248 Greenway Place','Drayton','KS','USA','66210','9135554519','Westend Dealers' )#
INSERT INTO DEMO.Customers VALUES
    ( 185,'Belmont','Serop','2158 Hadley Lane','Gimli','CT','USA','6115','2035555474','The Heartford' )#
INSERT INTO DEMO.Customers VALUES
    ( 186,'Tenorio','Thao','9000 Midway Road','Thunder Bay','MO','USA','64105','8165558543','Wally''s World' )#
INSERT INTO DEMO.Customers VALUES
    ( 187,'Bensoul','Sebouh','328 Van Ness Way','Ventura','IL','USA','61614','3095556915','Bensoul''s Boutique' )#
INSERT INTO DEMO.Customers VALUES
    ( 188,'Berenberg','Vartan','259 110th Avenue N.E.','Dashwood','IL','USA','60062','7085552914','Diva''s Design' )#
INSERT INTO DEMO.Customers VALUES
    ( 189,'Berejiklian','Herbert','36 Municiple Drive','Petersburg','KS','USA','02142','6175553547','Out of Town Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 190,'Arlington','Randy','529 N Franklin Turnpike','Chatham','MI','USA','48214','3135555716','Jim Dandy''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 191,'Richards','Marta','15920 Northridge Road','Winterbourne','FL','USA','33172','3055554711','Ocean Sports Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 192,'Beldov','Rosanna','153 Northside Parkway','Leamington','IA','USA','51102','7125552741','Morrell Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 193,'Neumann','Alfred','1657 Northeast 99th Way','Thunder Bay','MO','USA','64114','8165558543','Big Sky Design' )#
INSERT INTO DEMO.Customers VALUES
    ( 194,'Chin','Jen-Chang','3269 Oyster Point Blvd','Ingersol','VA','USA','02203','7035558037','Cinnamon Rainbow''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 195,'Jyh-Hwa','Li-Hui','107 Potrero Avenue','Oakville','GA','USA','30303','4045556762','Peachtree Active Wear' )#
INSERT INTO DEMO.Customers VALUES
    ( 196,'Andrews','Ling Ling','999 Roe Avenue','Orangeville','AB','Canada','T5N 1S5','4035554884','The Igloo' )#
INSERT INTO DEMO.Customers VALUES
    ( 197,'Chermak','Maio','203 Sycamore Road','Oakville','GA','USA','30346','4045558046','Southern Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 198,'Chen','Sheng','9214 W. Six Mile Road','Pickering','CA','USA','94583','5105558666','Able Inc.' )#
INSERT INTO DEMO.Customers VALUES
    ( 199,'Mentary','Ella','324 Embarcadero Center','Rockland','NY','USA','14644','7165554236','Nobel Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 200,'Chau','Helen','1542 Yamato Road','Linwood','MD','USA','20878','3015553099','Stone''s Sporting Goods' )#
INSERT INTO DEMO.Customers VALUES
    ( 201,'Singh','Amit','6530 Yonge Street','Drayton','KS','USA','66210','9135554519','Overland Army Navy' )#
INSERT INTO DEMO.Customers VALUES
    ( 202,'Murphy','Bubba','4263 N. 44th Street','Welland','NY','USA','10604','9145556961','Dane''s World' )#
INSERT INTO DEMO.Customers VALUES
    ( 203,'Pepper','Salton','201 Boylston Street','White Lake','WI','USA','53705','6085552673','Salt & Pepper''s' )#
INSERT INTO DEMO.Customers VALUES
    ( 204,'Spaid','Robert','222 Town Center','Victoriaville','MI','USA','49202','5175557883','Cognos Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 205,'Smythe','Elmo','2459 Plaza Street','Mildmay','MA','USA','01516','5085554761','East Coast Traders' )#
INSERT INTO DEMO.Customers VALUES
    ( 206,'Jones','JohnPaul','2999 Post Oak Blvd.','Dansbury','VA','USA','22091','7035556209','Chadwicks' )#
INSERT INTO DEMO.Customers VALUES
    ( 207,'Donchek','Wen-Chu','1425 N. Mission','Peterborough','IL','USA','60532','7085555055','The Country Store' )#
INSERT INTO DEMO.Customers VALUES
    ( 208,'Suess','Derek','397 King George Drive','Weyburn','NY','USA','12208','5185552623','Capital Center Sports' )#
INSERT INTO DEMO.Customers VALUES
    ( 209,'Boyle','Laura','234 Pillsbury Road','Niagara Falls','CA','USA','94022','4155559678','Boyle''s Swap Meet' )#
INSERT INTO DEMO.Customers VALUES
    ( 220,'Clark','Lewis N.','987 Expedition Hwy','Meaford','WY','USA','85293','3075556589','Trek Outfitters' )#
INSERT INTO DEMO.Customers VALUES
    ( 221,'Johnson','DEMO','65 Shoebox Lane','Armstrong','NM','USA','40420','5055554568','Turkey Creek Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 222,'Doe','Jane','54 Disk Drive','Ajax','CA','USA','94020','4085558796','Data Recovery Services' )#
INSERT INTO DEMO.Customers VALUES
    ( 330,'Major','Tom','97 Rocket Pad','Exeter','FL','USA','32200','4075558574','Launch Facilities' )#
INSERT INTO DEMO.Customers VALUES
    ( 331,'Johansen','Dominic','37 West Street','Wellesley','LA','USA','33552','5045558487','Mardi Gras Parties' )#
INSERT INTO DEMO.Customers VALUES
    ( 332,'Jue','Stanley','37 Bronco Circle','Kitchener','TX','USA','77057','7135558857','Bay Town Bus Co.' )#
INSERT INTO DEMO.Customers VALUES
    ( 333,'Jones','Harry','87 Software Rd','Ajax','CA','USA','94020','4085556689','Bits & Bytes' )#
INSERT INTO DEMO.Customers VALUES
    ( 440,'Curie','Marie','573 Helping Hand Hwy','Lefroy','MA','USA','02140','6175558875','Wind & Rain' )#
INSERT INTO DEMO.Customers VALUES
    ( 441,'Bordon','Elizabeth','21 Grinding Stone Rd','New Dundee','MA','USA','01801','5085558879','Blades & Things' )#
INSERT INTO DEMO.Customers VALUES
    ( 444,'Manager','Len','90 Network Way','Fergus','TX','USA','76552','2145552685','Let''s get Connected' )#
INSERT INTO DEMO.Customers VALUES
    ( 550,'Antolini','Tony','1539 Sliver Road','Woodstock','ND','USA','60500','7015553259','Flat Landers' )#
INSERT INTO DEMO.Customers VALUES
    ( 551,'Cruz','Tom','248 Far Away Lane','Byron','OR','USA','98524','5035557462','Raceway Engines' )#
INSERT INTO DEMO.Customers VALUES
    ( 552,'O''Toole','Janice','369 West Hill','Tweed','TN','USA','37320','6155553689','Greensleeves' )#
INSERT INTO DEMO.Customers VALUES
    ( 553,'Nickolas','Stevie','22 Recordings Circle','Hanover','WA','USA','96521','5095551695','It''s a Hit!' )#
INSERT INTO DEMO.Customers VALUES
    ( 555,'Fernandez','Philipe','24 Main Street','Arnprior','CA','USA','90205','2135554457','Quaker Fashions' )#
INSERT INTO DEMO.Customers VALUES
    ( 661,'Stutzman','Jennifer','8 Back Pages Lane','Etobicoke','IL','USA','60505','7085556857','Stutzman Advertising' )#
INSERT INTO DEMO.Customers VALUES
    ( 665,'Thompson','William','19 Washington Street','Bancroft','NY','USA','11700','5165552549','The Apple Farm' )#
INSERT INTO DEMO.Customers VALUES
    ( 0,'N/A','N/A','N/A','N/A','N/A','N/A','N/A','N/A','This is a dummy customer record' )#

COMMIT#

--Populate Products table

INSERT INTO DEMO.Products VALUES
    ( '300','Tee Shirt','Tank Top','Small','White','28','9.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '301','Tee Shirt','V-neck','Medium','Orange','54','14.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '302','Tee Shirt','Crew Neck','One size fits all','Black','75','14.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '400','Baseball Cap','Cotton Cap','One size fits all','Black','112','9.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '401','Baseball Cap','Wool cap','One size fits all','White','12','10.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '500','Visor','Cloth Visor','One size fits all','White','36','7.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '501','Visor','Plastic Visor','One size fits all','Black','28','7.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '600','Sweatshirt','Hooded Sweatshirt','Large','Green','39','24.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '601','Sweatshirt','Zipped Sweatshirt','Large','Blue','32','24.00','' )#
INSERT INTO DEMO.Products VALUES
    ( '700','Shorts','Cotton Shorts','Medium','Black','80','15.00','' )#

-- Insert photos here

COMMIT#

-- Populate Departments table

INSERT INTO DEMO.Departments VALUES
    ( '100','R & D','501' )#
INSERT INTO DEMO.Departments VALUES
    ( '200','Sales','902' )#
INSERT INTO DEMO.Departments VALUES
    ( '300','Finance','1293' )#
INSERT INTO DEMO.Departments VALUES
    ( '400','Marketing','1576' )#
INSERT INTO DEMO.Departments VALUES
    ( '500','Shipping','703' )#

COMMIT#

-- Populate the Employees table

INSERT INTO DEMO.Employees VALUES
    (  102, 501,'Whitney','Fran',100,'9 East Washington Street','Cornwall','NY','USA','02192','6175553985','A','017349033', 45700.000,'1984-08-28 00:00:00.0',NULL,'1958-06-05 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  105, 501,'Cobb','Matthew',100,'7 Pleasant Street','Grimsby','UT','USA','02154','6175553840','A','052345739', 62000.000,'1985-01-01 00:00:00.0',NULL,'1960-12-04 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  129, 902,'Chin','Philip',200,'539 Pond Street','Oakville','GA','USA','30339','4045552341','A','024608923', 38500.000,'1985-02-03 00:00:00.0',NULL,'1966-10-30 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  148,1293,'Jordan','Julie',300,'1244 Great Plain Avenue','Woodbridge','AZ','USA','01890','6175557835','A','501704733', 51432.000,'1985-04-05 00:00:00.0',NULL,'1951-12-13 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  160, 501,'Breault','Robert',100,'358 Cherry Street','Milton','PA','USA','02186','6175553099','A','025487623', 57490.000,'1985-06-17 00:00:00.0',NULL,'1947-05-13 00:00:00.0',1,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  184,1576,'Espinoza','Melissa',400,'1121 Apple Tree Way','Iroquois Falls','ME','USA','01775','5085552319','A','025481943', 36490.000,'1985-10-18 00:00:00.0',NULL,'1939-12-14 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  191, 703,'Bertrand','Jeannette',500,'2090A Concord Street','Waterloo','AZ','USA','01720','5085558138','A','017348821', 29800.000,'1985-11-19 00:00:00.0',NULL,'1964-12-21 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  195, 902,'Dill','Marc',200,'897 Hancock Street','Milton','PA','USA','02186','6175552144','A','079486634', 54800.000,'1985-12-06 00:00:00.0',NULL,'1963-07-19 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  207,1576,'Francis','Jane',400,'127 Hawthorne Drive','Scarborough','FL','USA','01742','5085559022','A','501708992', 53870.000,'1986-02-03 00:00:00.0',NULL,'1954-09-12 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  243, 501,'Shishov','Natasha',100,'151 Milk Street','Grimsby','UT','USA','02154','6175552755','A','043216799', 72995.000,'1986-06-07 00:00:00.0',NULL,'1949-04-22 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  247, 501,'Driscoll','Kurt',100,'1546 School Street','Grimsby','UT','USA','02154','6175551234','L','024601768', 48023.690,'1986-07-01 00:00:00.0',NULL,'1955-03-05 00:00:00.0',1,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  249, 501,'Guevara','Rodrigo',100,'72 East Main Street','Fort Henry','NY','USA','01701','5085550029','A','084329990', 42998.000,'1986-10-14 00:00:00.0',NULL,'1956-11-23 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  266, 501,'Gowda','Ram',100,'7 Page Street','Morrisburg','FL','USA','01760','5085558722','A','017346122', 59840.000,'1986-11-30 00:00:00.0',NULL,'1947-10-18 00:00:00.0',0,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  278, 501,'Melkisetian','Terry',100,'871 Oxford Road','Sarnia','CO','USA','02172','6175555188','A','087602311', 48500.000,'1986-12-06 00:00:00.0',NULL,'1966-05-17 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  299, 902,'Overbey','Rollin',200,'191 Companion Ct.','Kanata','CA','USA','94608','5105557255','A','025487133', 39300.000,'1987-02-19 00:00:00.0',NULL,'1964-03-15 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  316, 501,'Pastor','Lynn',100,'1423 Cricklewood Drive','Hamilton','MI','USA','01803','6175552001','A','048667211', 74500.000,'1987-04-26 00:00:00.0',NULL,'1962-07-14 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  318,1576,'Crow','John',400,'14531 Main Street','Sarnia','CO','USA','02172','6175553332','A','079349168', 41700.750,'1987-05-23 00:00:00.0',NULL,'1962-04-24 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  390,1293,'Davidson','Jo Ann',300,'273 Mount Vernon Road','Cornwall','NY','USA','02192','6175553870','A','027341657', 57090.000,'1987-06-02 00:00:00.0',NULL,'1957-02-17 00:00:00.0',0,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  409,1576,'Weaver','Bruce',400,'190 Westmoreland Street','Newcastle','IL','USA','02173','6175554444','A','048781192', 46550.000,'1987-06-10 00:00:00.0',NULL,'1946-04-05 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  445, 501,'Lull','Kim',100,'1997 Lincoln Street','Scarborough','FL','USA','01742','5085554444','A','017508821', 87900.000,'1987-06-15 00:00:00.0',NULL,'1955-01-19 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  453, 501,'Rabkin','Andrew',100,'444 Birds Hill Way','Hamilton','MI','USA','01803','6175554444','A','029458129', 64500.000,'1987-06-15 00:00:00.0',NULL,'1957-08-10 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  467, 902,'Klobucher','James',200,'1839 Corning Street','Kitchener','TX','USA','77079','7135558627','A','034281032', 49500.000,'1987-07-10 00:00:00.0',NULL,'1952-11-09 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  479, 501,'Siperstein','Linda',100,'3481 Hillside Avenue','St. Clements','WY','USA','02164','6175556588','L','022415639', 39875.500,'1987-07-23 00:00:00.0',NULL,'1967-09-21 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  501, 501,'Scott','David',100,'291 Riverdale Drive','Lethbridge','RI','USA','02178','6175553246','A','064983327', 96300.000,'1987-08-04 00:00:00.0',NULL,'1947-03-01 00:00:00.0',1,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  529, 501,'Sullivan','Dorothy',100,'1294 Minuteman Drive','Newcastle','IL','USA','02173','6175553947','A','501324492', 67890.000,'1988-02-03 00:00:00.0',NULL,'1950-04-19 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  582, 501,'Samuels','Peter',100,'504 Woodlawn Street','St. Clements','WY','USA','02164','6175558342','A','038218867', 37400.000,'1988-03-23 00:00:00.0',NULL,'1968-02-28 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  586,1293,'Coleman','James',300,'577 Heather Hill Drive','Waterloo','AZ','USA','01720','5085554735','L','031281245', 42300.000,'1988-04-05 00:00:00.0',NULL,'1966-03-04 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  591,1576,'Barletta','Irene',400,'937 Gleason Street','Elora','OR','USA','01730','6175558345','A','056872399', 45450.000,'1988-07-18 00:00:00.0',NULL,'1957-01-30 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  604, 501,'Wang','Albert',100,'488 Edwin Street','Grimsby','UT','USA','02154','6175558741','A','023486621', 68400.000,'1988-09-29 00:00:00.0',NULL,'1958-12-25 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  641, 902,'Powell','Thomas',200,'487 Kennedy Court','St. Clements','WY','USA','02162','6175551956','A','038726633', 54600.000,'1988-10-14 00:00:00.0',NULL,'1951-10-31 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  667, 902,'Garcia','Mary',200,'9 Purvis Street','Kitchener','TX','USA','77079','7135553431','A','042706188', 39800.000,'1988-11-22 00:00:00.0',NULL,'1963-01-23 00:00:00.0',0,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  690, 902,'Poitras','Kathleen',200,'501 The Fenway','Charlottetown','CO','USA','02118','6175553920','A','087236702', 46200.000,'1988-11-28 00:00:00.0',NULL,'1965-09-29 00:00:00.0',0,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  703, 902,'Martinez','Jose',500,'475 Washington Street','Waterdown','AZ','USA','02090','6175557114','A','012896755', 55500.800,'1988-12-01 00:00:00.0',NULL,'1953-07-22 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  750, 703,'Braun','Jane',500,'425 Wood Street','Petersburg','KS','USA','02140','6175557857','A','012459381', 34300.000,'1989-01-03 00:00:00.0',NULL,'1939-08-09 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  757,1293,'Higgins','Denis',300,'103 Massachusetts Avenue','Newcastle','IL','USA','02173','6175553985','A','067829311', 43700.000,'1989-02-23 00:00:00.0',NULL,'1968-05-12 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  839, 501,'Marshall','Dean',100,'4468 Mount Pleasant Street','Lethbridge','RI','USA','02178','6175553707','A','034629123', 42500.000,'1989-04-20 00:00:00.0',NULL,'1966-05-21 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  856, 902,'Singer','Samuel',200,'18 Orchard Road','Iroquois Falls','ME','USA','01775','5085553255','A','011349786', 34892.000,'1989-06-01 00:00:00.0',NULL,'1959-04-07 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  862, 501,'Sheffield','John',100,'405 Belleview Drive','Kitchener','TX','USA','77079','7135553877','A','018458291', 87900.000,'1989-06-15 00:00:00.0',NULL,'1955-09-25 00:00:00.0',1,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  868, 703,'Kuo','Felicia',500,'719 Oak Street','Petersburg','KS','USA','02140','6175552385','A','043592831', 28200.000,'1989-07-12 00:00:00.0',NULL,'1968-07-24 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  879,1293,'Coe','Kristen',300,'390 Rainbow Road','Trenton','WY','USA','02132','6175559192','A','027581035', 36500.000,'1989-07-18 00:00:00.0',NULL,'1965-11-11 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  888,1576,'Charlton','Doug',400,'578 Webster Street','Scarborough','FL','USA','01742','5085559246','A','036102935', 28300.000,'1989-09-09 00:00:00.0',NULL,'1966-01-23 00:00:00.0',0,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  902,1293,'Kelly','Moira',200,'127 Fountain Road','Wakefield','FL','USA','01930','5085553769','A','015923467', 87500.000,'1989-10-01 00:00:00.0',NULL,'1950-08-16 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  913, 902,'Martel','Ken',200,'230 Lincoln Street','Cornwall','NY','USA','02192','6175558474','A','022783569', 55700.000,'1989-10-16 00:00:00.0',NULL,'1943-04-23 00:00:00.0',0,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  921, 703,'Crowley','Charles',500,'4212 Beacon Street','Lethbridge','RI','USA','02178','6175559425','A','034568789', 41700.000,'1989-10-22 00:00:00.0',NULL,'1960-09-11 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  930, 902,'Taylor','Ann',200,'251 Westminster Street','Oakville','GA','USA','30339','4045551515','A','062890293', 46890.000,'1989-11-07 00:00:00.0',NULL,'1962-06-06 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  949, 902,'Savarino','Pamela',200,'1128 Beach Street','Sheffield','CA','USA','90806','3105551857','A','018762936', 72300.000,'1989-11-07 00:00:00.0',NULL,'1955-07-28 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    (  958, 501,'Sisson','Thomas',100,'547 School Street','Kitchener','TX','USA','77079','7135558390','A','017283997', 42100.000,'1990-01-15 00:00:00.0',NULL,'1969-10-02 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    (  992,1576,'Butterfield','Joyce',400,'1191 Adams Street','Petersburg','KS','USA','02140','6175552232','A','023487085', 34011.000,'1990-02-12 00:00:00.0',NULL,'1960-04-15 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1013, 703,'Barker','Joseph',500,'589 West Drive','Elora','OR','USA','01730','6175558021','A','023470756', 27290.000,'1990-03-12 00:00:00.0',NULL,'1969-02-14 00:00:00.0',0,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1021, 902,'Sterling','Paul',200,'1125 Endicott Street','Scarborough','FL','USA','01742','5085550295','A','037846595', 64900.000,'1990-04-29 00:00:00.0',NULL,'1950-02-27 00:00:00.0',1,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1039, 902,'Chao','Shih Lin',200,'5 Holyoke Street','Newcastle','IL','USA','02173','6175555921','A','046973741', 33890.000,'1990-05-13 00:00:00.0',NULL,'1969-12-12 00:00:00.0',0,1,1,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1062,1576,'Blaikie','Barbara',400,'665 Beaumont Terrace','Cornwall','NY','USA','02192','6175559345','A','019887257', 54900.000,'1990-05-22 00:00:00.0',NULL,'1953-11-14 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1090, 501,'Smith','Susan',100,'17 Johnson Street','Kitchener','TX','USA','77079','7135556613','A','013558813', 51411.000,'1990-06-14 00:00:00.0',NULL,'1950-11-30 00:00:00.0',0,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1101, 902,'Preston','Mark',200,'4971 Constitution Road','Charlottetown','CO','USA','02124','6175555862','A','027663454', 37803.000,'1990-07-11 00:00:00.0',NULL,'1966-09-14 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1142, 902,'Clark','Alison',200,'563 Carver Street','Kanata','CA','USA','94608','5105559437','A','055913622', 45000.000,'1990-07-21 00:00:00.0',NULL,'1957-05-04 00:00:00.0',0,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1157, 501,'Soo','Hing',100,'1921 Glenmeadow Street','Cornwall','NY','USA','02192','6175558748','A','023434587', 39075.000,'1990-07-31 00:00:00.0',NULL,'1970-03-07 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1162, 902,'Goggin','Kevin',200,'16 Wachusett Road','Stratford','UT','USA','02181','6175553785','A','075679377', 37900.000,'1990-08-05 00:00:00.0',NULL,'1952-04-18 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1191,1576,'Bucceri','Matthew',400,'527 Taylor Place','Newcastle','IL','USA','02173','6175555336','A','023749270', 45900.000,'1990-08-14 00:00:00.0',NULL,'1944-11-19 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1250, 501,'Diaz','Emilio',100,'5112 Evergreen Street','Stratford','UT','USA','02181','6175553567','A','023476492', 54900.000,'1990-08-19 00:00:00.0',NULL,'1936-01-02 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1293,1293,'Shea','Mary Anne',300,'297 Camden Road','Newcastle','IL','USA','02173','6175554616','A','019641485', 138948.000,'1990-09-01 00:00:00.0',NULL,'1955-03-13 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1336,1293,'Bigelow','Janet',300,'83 Lunda Street','Grimsby','UT','USA','02154','6175551493','A','017326112', 31200.000,'1992-02-25 00:00:00.0',NULL,'1950-07-21 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1390,1293,'Litton','Jennifer',300,'171 Downing Street','Scarborough','FL','USA','01742','5085553495','A','034786565', 58930.000,'1992-04-06 00:00:00.0',NULL,'1948-04-05 00:00:00.0',0,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1446, 902,'Yeung','Caroline',200,'252 Cypress Street','Oakville','GA','USA','30339','4045558347','A','038475825', 32300.000,'1992-10-29 00:00:00.0',NULL,'1971-06-21 00:00:00.0',0,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1483,1293,'Letiecq','John',300,'951 Vista Drive','Hamilton','MI','USA','01803','6175551167','L','079372285', 75400.000,'1993-03-01 00:00:00.0',NULL,'1939-04-27 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1507,1576,'Wetherby','Ruth',400,'38 Aberdeen Road','Cornwall','NY','USA','02192','6175555465','A','035673688', 35745.000,'1993-04-12 00:00:00.0',NULL,'1959-07-19 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1570, 703,'Rebeiro','Anthony',500,'93 Moody Street','Grimsby','UT','USA','02154','6175555737','A','034576347', 34576.000,'1993-05-29 00:00:00.0',NULL,'1963-04-12 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1576, 902,'Evans','Scott',400,'29-C Sunrise Circle','Scarborough','FL','USA','01742','5085550096','A','017429926', 68940.000,'1993-07-01 00:00:00.0',NULL,'1960-11-15 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1596, 902,'Pickett','Catherine',200,'457 Appleton Road','Elora','OR','USA','01730','6175553478','A','028375086', 47653.000,'1993-08-12 00:00:00.0',NULL,'1959-11-18 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1607,1576,'Morris','Mark',400,'13 Example Way','Grimsby','UT','USA','02154','6175558344','A','501787474', 61300.000,'1993-10-13 00:00:00.0',NULL,'1941-01-08 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1615, 703,'Romero','Sheila',500,'197 Oakview Terrace','Elora','OR','USA','01730','6175558138','A','501175874', 27500.000,'1993-11-19 00:00:00.0',NULL,'1972-09-12 00:00:00.0',1,1,1,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1643,1576,'Lambert','Elizabeth',400,'293 Union Street','Hamilton','MI','USA','01803','6175552357','A','023857807', 29384.000,'1993-12-15 00:00:00.0',NULL,'1968-09-12 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1658, 703,'Lynch','Michael',500,'716 Brookside Road','Grimsby','UT','USA','02154','6175558348','A','023850840', 24903.000,'1994-02-27 00:00:00.0',NULL,'1973-01-18 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1684,1576,'Hildebrand','Janet',400,'7 Hilltop Street','Grimsby','UT','USA','02154','6175553845','A','038957036', 45829.000,'1994-03-15 00:00:00.0',NULL,'1955-10-31 00:00:00.0',1,1,0,'F' )#
INSERT INTO DEMO.Employees VALUES
    ( 1740,1576,'Nielsen','Robert',400,'558 Sargent Avenue','Elora','OR','USA','01730','6175558757','A','037534650', 34889.000,'1994-06-24 00:00:00.0',NULL,'1965-06-19 00:00:00.0',1,1,0,'M' )#
INSERT INTO DEMO.Employees VALUES
    ( 1751,1576,'Ahmed','Alex',400,'1141 Cushing Street','Cornwall','NY','USA','02192','6175558748','A','032547384', 34992.000,'1994-07-12 00:00:00.0',NULL,'1963-12-12 00:00:00.0',1,1,0,'M' )#

COMMIT#

-- Populate FinancialCodes table

INSERT INTO DEMO.FinancialCodes VALUES
    ( 'e1','expense','Fees' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'e2','expense','Services' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'e3','expense','Sales & Marketing' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'e4','expense','R & D' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'e5','expense','Administration' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'r1','revenue','Fees' )#
INSERT INTO DEMO.FinancialCodes VALUES
    ( 'r2','revenue','Services' )#

COMMIT#

-- Populate FinancialData table

INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','e1','101' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','e2','403' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','e3','1437' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','e4','623' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','e5','381' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','r1','1023' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q1','r2','234' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','e1','93' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','e2','459' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','e3','2033' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','e4','784' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','e5','402' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','r1','2033' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q2','r2','459' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','e1','129' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','e2','609' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','e3','2184' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','e4','856' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','e5','412' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','r1','2998' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q3','r2','601' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','e1','145' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','e2','632' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','e3','2145' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','e4','1043' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','e5','467' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','r1','3014' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '1999','Q4','r2','944' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','e1','153' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','e2','643' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','e3','2478' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','e4','1051' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','e5','523' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','r1','3114' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q1','r2','992' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','e1','149' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','e2','687' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','e3','2998' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','e4','1158' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','e5','749' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','r1','3998' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q2','r2','1195' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','e1','157' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','e2','898' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','e3','3702' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','e4','1459' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','e5','723' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','r1','6523' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q3','r2','1704' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','e1','163' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','e2','923' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','e3','3600' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','e4','1439' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','e5','748' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','r1','7267' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2000','Q4','r2','1823' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','e1','198' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','e2','921' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','e3','4139' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','e4','1462' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','e5','798' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','r1','9144' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q1','r2','1839' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','e1','204' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','e2','975' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','e3','4500' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','e4','1472' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','e5','983' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','r1','10988' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q2','r2','2011' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','e1','214' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','e2','984' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','e3','4532' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','e4','1439' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','e5','956' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','r1','13567' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q3','r2','2897' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','e1','231' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','e2','982' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','e3','5298' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','e4','1498' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','e5','963' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','r1','15199' )#
INSERT INTO DEMO.FinancialData VALUES
    ( '2001','Q4','r2','4129' )#

COMMIT#

-- Populate SalesOrders table

INSERT INTO DEMO.SalesOrders VALUES
    ( 2001,101,'2000/03/16 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2002,102,'2000/03/20 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2003,103,'2000/03/23 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2004,104,'2000/03/25 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2005,101,'2001/03/26 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2006,105,'2001/03/30 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2007,106,'2001/03/30 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2008,107,'2001/04/02 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2009,108,'2001/04/05 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2010,109,'2001/04/06 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2011,110,'2001/04/07 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2012,111,'2001/04/07 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2013,112,'2001/04/07 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2014,113,'2001/04/08 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2015,114,'2001/04/01 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2016,115,'2000/04/02 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2017,116,'2001/04/02 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2018,117,'2001/03/09 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2019,118,'2000/02/12 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2020,119,'2001/03/04 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2021,120,'2001/04/09 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2022,121,'2001/05/06 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2023,122,'2001/06/04 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2024,123,'2001/07/13 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2025,124,'2001/05/03 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2026,125,'2001/02/03 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2027,126,'2001/06/14 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2028,127,'2000/07/01 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2029,128,'2000/06/12 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2030,129,'2001/04/07 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2031,130,'2000/05/29 00:00:00.000','r1','Western',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2032,131,'2001/07/05 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2033,132,'2000/02/13 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2035,134,'2001/04/30 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2036,135,'2001/01/05 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2037,136,'2000/01/23 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2038,137,'2001/02/01 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2039,138,'2000/03/02 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2040,139,'2001/04/27 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2041,140,'2001/05/03 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2042,141,'2001/02/26 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2043,142,'2001/03/15 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2044,143,'2000/07/15 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2045,144,'2000/07/02 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2046,145,'2001/02/02 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2047,146,'2001/03/10 00:00:00.000','r1','Western',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2048,147,'2001/03/09 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2049,148,'2001/02/17 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2050,149,'2001/02/26 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2051,150,'2000/05/15 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2052,151,'2001/07/02 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2053,152,'2001/06/30 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2054,153,'2001/05/31 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2055,154,'2001/03/31 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2056,155,'2001/04/15 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2057,156,'2001/03/22 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2058,157,'2001/04/07 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2059,158,'2001/04/06 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2060,159,'2001/05/03 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2061,160,'2000/07/20 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2062,161,'2001/06/15 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2063,162,'2001/06/21 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2064,163,'2001/04/30 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2065,164,'2000/01/03 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2067,166,'2001/04/23 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2068,167,'2001/05/03 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2069,168,'2001/02/15 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2070,169,'2000/03/02 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2071,170,'2001/05/24 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2072,171,'2001/05/17 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2073,172,'2001/05/31 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2074,173,'2001/07/22 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2075,174,'2001/02/16 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2076,175,'2001/03/18 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2077,176,'2001/04/07 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2078,177,'2001/05/03 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2079,178,'2001/04/02 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2080,179,'2001/05/03 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2081,180,'2000/06/03 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2082,181,'2001/07/02 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2083,182,'2000/01/13 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2084,183,'2001/02/12 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2085,184,'2000/03/12 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2086,185,'2001/04/12 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2087,186,'2001/05/12 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2089,187,'2001/06/11 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2090,188,'2001/07/12 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2091,189,'2001/07/01 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2092,190,'2001/01/12 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2093,191,'2000/02/13 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2094,192,'2001/03/15 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2095,193,'2001/04/15 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2096,194,'2001/05/17 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2097,195,'2000/06/17 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2098,196,'2001/07/19 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2099,197,'2000/01/17 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2100,198,'2001/02/19 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2101,198,'2000/03/20 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2102,199,'2001/04/22 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2103,200,'2001/05/24 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2104,201,'2000/06/24 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2105,202,'2001/07/23 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2106,203,'2001/01/05 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2107,204,'2000/02/06 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2109,206,'2000/04/08 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2110,207,'2001/05/07 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2111,208,'2001/06/10 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2112,165,'2001/01/11 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2113,209,'2001/01/12 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2114,206,'2001/02/12 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2115,201,'2000/03/16 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2116,209,'2001/04/15 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2117,204,'2000/05/15 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2118,147,'2001/06/17 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2119,168,'2001/07/19 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2120,110,'2001/01/19 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2121,189,'2000/02/20 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2122,132,'2001/03/22 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2123,175,'2001/04/22 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2124,134,'2000/05/25 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2125,101,'2001/06/24 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2126,136,'2000/01/03 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2127,142,'2000/01/06 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2128,155,'2000/01/28 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2129,166,'2000/01/07 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2130,146,'2000/01/17 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2131,128,'2000/01/02 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2132,110,'2000/01/08 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2133,167,'2000/01/10 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2134,168,'2000/01/14 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2135,205,'2000/01/06 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2136,188,'2000/01/09 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2137,170,'2000/01/14 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2138,198,'2000/01/16 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2139,203,'2000/01/17 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2140,209,'2000/01/20 00:00:00.000','r1','Western',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2141,166,'2000/01/21 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2142,102,'2000/01/22 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2143,115,'2000/01/23 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2144,110,'2000/01/24 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2145,135,'2000/01/27 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2146,189,'2000/01/28 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2147,200,'2000/01/29 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2148,199,'2000/01/30 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2149,190,'2000/01/31 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2150,169,'2000/02/03 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2151,144,'2000/02/04 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2152,132,'2000/02/05 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2153,111,'2000/02/06 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2154,122,'2000/02/07 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2155,143,'2000/02/10 00:00:00.000','r1','Canada',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2156,157,'2000/02/11 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2157,168,'2000/02/12 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2158,179,'2000/02/13 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2159,181,'2000/02/14 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2160,183,'2000/02/14 00:00:00.000','r1','South',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2161,199,'2000/02/17 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2162,202,'2000/02/18 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2163,204,'2000/02/19 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2164,206,'2000/02/20 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2165,104,'2000/02/21 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2166,113,'2000/02/24 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2167,121,'2000/02/25 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2168,137,'2000/02/26 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2169,148,'2000/02/27 00:00:00.000','r1','Canada',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2170,149,'2000/02/28 00:00:00.000','r1','Canada',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2171,153,'2000/03/03 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2172,202,'2000/03/02 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2173,107,'2000/03/03 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2174,129,'2000/03/04 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2175,208,'2000/03/05 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2176,140,'2000/03/06 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2177,134,'2000/03/06 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2178,103,'2000/03/09 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2179,119,'2000/03/10 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2180,209,'2000/03/11 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2181,136,'2000/03/12 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2182,195,'2000/03/13 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2183,118,'2000/03/17 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2184,182,'2000/03/18 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2185,107,'2000/03/19 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2186,111,'2000/03/20 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2187,136,'2000/03/23 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2188,144,'2000/03/24 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2189,156,'2000/03/24 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2190,192,'2000/03/25 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2191,118,'2000/03/26 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2192,158,'2000/03/27 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2193,183,'2000/03/30 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2194,124,'2000/03/31 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2195,131,'2000/04/01 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2196,157,'2000/04/02 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2197,161,'2000/04/03 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2198,144,'2000/04/06 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2199,116,'2000/04/07 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2200,198,'2000/04/08 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2201,139,'2000/04/09 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2202,166,'2000/04/10 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2203,107,'2000/04/13 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2204,139,'2000/04/14 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2205,200,'2000/04/15 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2206,101,'2000/04/16 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2207,103,'2000/04/17 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2208,201,'2000/04/20 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2209,204,'2000/04/21 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2210,206,'2000/04/22 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2211,207,'2000/04/23 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2212,190,'2000/04/24 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2213,191,'2000/04/27 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2214,192,'2000/04/28 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2215,193,'2000/04/29 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2216,194,'2000/04/30 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2217,195,'2000/05/01 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2218,196,'2000/05/04 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2219,197,'2000/05/05 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2220,198,'2000/05/06 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2221,199,'2000/05/07 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2222,200,'2000/05/08 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2223,201,'2000/05/11 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2224,202,'2000/05/12 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2225,203,'2000/05/13 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2226,204,'2000/05/14 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2227,205,'2000/05/15 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2228,107,'2000/05/18 00:00:00.000','r1','South',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2229,108,'2000/05/19 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2230,109,'2000/05/20 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2231,110,'2000/05/21 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2232,111,'2000/05/22 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2233,112,'2000/05/25 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2234,113,'2000/05/26 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2235,114,'2000/05/27 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2236,115,'2000/05/28 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2237,116,'2000/05/29 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2238,117,'2000/05/29 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2239,121,'2000/06/01 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2240,122,'2000/06/02 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2241,123,'2000/06/03 00:00:00.000','r1','Canada',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2242,124,'2000/06/04 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2243,125,'2000/06/05 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2244,126,'2000/06/08 00:00:00.000','r1','Western',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2245,127,'2000/06/09 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2246,128,'2000/06/10 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2247,129,'2000/06/11 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2248,130,'2000/06/12 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2249,132,'2000/06/15 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2250,133,'2000/06/16 00:00:00.000','r1','Western',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2251,145,'2000/06/17 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2252,147,'2000/06/18 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2253,104,'2000/06/19 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2254,107,'2000/06/22 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2255,182,'2000/06/23 00:00:00.000','r1','Western',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2256,170,'2000/06/24 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2257,166,'2000/06/25 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2258,151,'2000/06/26 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2259,198,'2000/06/29 00:00:00.000','r1','Western',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2260,176,'2000/06/30 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2261,149,'2000/07/01 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2262,185,'2000/07/02 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2263,201,'2000/07/06 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2264,209,'2000/07/07 00:00:00.000','r1','Western',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2265,199,'2000/07/08 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2266,104,'2000/07/09 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2267,121,'2000/07/10 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2268,136,'2000/07/13 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2269,205,'2000/07/14 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2270,149,'2000/07/15 00:00:00.000','r1','Canada',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2271,150,'2000/07/15 00:00:00.000','r1','Canada',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2272,191,'2000/07/16 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2273,182,'2000/07/16 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2274,104,'2000/07/17 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2275,127,'2000/07/20 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2276,153,'2000/07/21 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2277,208,'2000/07/22 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2278,189,'2000/07/22 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2279,101,'2000/07/23 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2280,104,'2000/07/23 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2281,204,'2000/07/24 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2282,123,'2000/07/27 00:00:00.000','r1','Canada',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2283,201,'2000/07/27 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2284,113,'2000/07/28 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2285,139,'2000/07/29 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2286,142,'2000/07/30 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2287,154,'2000/07/31 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2288,207,'2000/08/03 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2289,117,'2000/08/03 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2290,172,'2000/08/04 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2291,112,'2000/08/07 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2292,157,'2000/08/10 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2293,164,'2000/08/11 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2294,204,'2000/08/11 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2295,101,'2000/08/12 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2296,114,'2000/08/13 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2297,197,'2000/08/13 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2298,200,'2000/08/14 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2299,117,'2000/08/17 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2300,172,'2000/08/18 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2301,116,'2000/08/18 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2302,147,'2000/08/19 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2303,166,'2000/08/20 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2304,107,'2000/08/20 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2305,201,'2000/08/20 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2306,199,'2000/08/21 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2307,103,'2000/08/24 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2308,111,'2000/08/25 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2309,129,'2000/08/26 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2310,147,'2000/08/27 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2311,152,'2000/08/27 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2312,209,'2000/08/28 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2313,110,'2000/08/31 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2314,161,'2000/08/31 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2315,190,'2000/09/01 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2316,138,'2000/09/02 00:00:00.000','r1','Canada',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2317,159,'2000/09/03 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2318,102,'2000/09/04 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2319,117,'2000/09/07 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2320,172,'2000/09/08 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2321,201,'2000/09/08 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2322,189,'2000/09/09 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2323,119,'2000/09/09 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2324,174,'2000/09/10 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2325,143,'2000/09/11 00:00:00.000','r1','Canada',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2326,205,'2000/09/11 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2327,121,'2000/09/14 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2328,137,'2000/09/15 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2329,169,'2000/09/16 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2330,112,'2000/09/17 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2331,104,'2000/09/17 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2332,203,'2000/09/18 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2333,114,'2000/09/18 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2334,138,'2000/09/21 00:00:00.000','r1','Canada',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2335,146,'2000/09/22 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2336,207,'2000/09/22 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2337,101,'2000/09/23 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2338,102,'2000/09/24 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2339,209,'2000/09/24 00:00:00.000','r1','Western',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2340,103,'2000/09/25 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2341,208,'2000/09/25 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2342,104,'2000/09/28 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2343,207,'2000/09/28 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2344,105,'2000/09/29 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2345,206,'2000/09/29 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2346,106,'2000/09/30 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2347,205,'2000/09/30 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2348,107,'2000/10/01 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2349,204,'2000/10/01 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2350,108,'2000/10/02 00:00:00.000','r1','South',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2351,203,'2000/10/02 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2352,109,'2000/10/05 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2353,202,'2000/10/05 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2354,110,'2000/10/06 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2355,201,'2000/10/06 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2356,111,'2000/10/07 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2357,200,'2000/10/07 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2358,112,'2000/10/08 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2359,199,'2000/10/08 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2360,113,'2000/10/09 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2361,198,'2000/10/09 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2362,114,'2000/10/12 00:00:00.000','r1','Central',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2363,197,'2000/10/12 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2364,115,'2000/10/13 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2365,196,'2000/10/13 00:00:00.000','r1','Canada',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2366,116,'2000/10/14 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2367,195,'2000/10/15 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2368,117,'2000/10/15 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2369,194,'2000/10/16 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2370,118,'2000/10/16 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2371,193,'2000/10/19 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2372,119,'2000/10/19 00:00:00.000','r1','Western',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2373,192,'2000/10/20 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2374,120,'2000/10/20 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2375,191,'2000/10/21 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2376,121,'2000/10/21 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2377,190,'2000/10/22 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2378,122,'2000/10/22 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2379,189,'2000/10/23 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2380,123,'2000/10/26 00:00:00.000','r1','Canada',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2381,188,'2000/10/26 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2382,124,'2000/10/27 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2383,187,'2000/10/27 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2384,125,'2000/10/28 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2385,126,'2000/10/29 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2386,185,'2000/10/29 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2387,127,'2000/10/30 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2388,184,'2000/10/30 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2389,101,'2000/10/16 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2390,183,'2000/11/02 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2391,128,'2000/11/02 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2392,182,'2000/11/03 00:00:00.000','r1','Western',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2393,129,'2000/11/03 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2394,181,'2000/11/04 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2395,130,'2000/11/04 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2396,180,'2000/11/05 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2397,131,'2000/11/05 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2398,132,'2000/11/06 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2399,178,'2000/11/09 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2400,133,'2000/11/09 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2401,177,'2000/11/10 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2402,134,'2000/11/10 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2403,176,'2000/11/11 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2404,135,'2000/11/11 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2405,175,'2000/11/12 00:00:00.000','r1','Canada',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2406,136,'2000/11/12 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2407,174,'2000/11/13 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2408,137,'2000/11/13 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2409,173,'2000/11/16 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2410,138,'2000/11/16 00:00:00.000','r1','Canada',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2411,172,'2000/11/17 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2412,139,'2000/11/18 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2413,171,'2000/11/18 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2414,140,'2000/11/19 00:00:00.000','r1','Western',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2415,170,'2000/11/19 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2416,141,'2000/11/19 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2417,169,'2000/11/19 00:00:00.000','r1','South',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2418,142,'2000/11/20 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2419,168,'2000/11/20 00:00:00.000','r1','Western',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2420,143,'2000/11/23 00:00:00.000','r1','Canada',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2421,167,'2000/11/23 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2422,144,'2000/11/23 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2423,166,'2000/11/24 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2424,143,'2000/11/24 00:00:00.000','r1','Canada',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2425,165,'2000/11/25 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2426,144,'2000/11/25 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2427,164,'2000/11/25 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2428,145,'2000/11/30 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2429,163,'2000/11/30 00:00:00.000','r1','Canada',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2430,146,'2000/12/01 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2431,162,'2000/12/01 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2432,147,'2000/12/02 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2433,161,'2000/12/02 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2434,148,'2000/12/03 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2435,160,'2000/12/03 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2436,149,'2000/12/04 00:00:00.000','r1','Canada',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2437,159,'2000/12/04 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2438,150,'2000/12/07 00:00:00.000','r1','Canada',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2439,158,'2000/12/07 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2440,151,'2000/12/08 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2441,157,'2000/12/08 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2442,152,'2000/12/08 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2443,156,'2000/12/09 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2444,153,'2000/12/09 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2445,155,'2000/12/10 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2446,154,'2000/12/10 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2447,101,'2000/12/11 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2448,209,'2000/12/11 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2449,102,'2000/12/14 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2450,208,'2000/12/14 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2451,103,'2000/12/15 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2452,104,'2000/12/15 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2453,206,'2000/12/16 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2454,105,'2000/12/16 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2455,205,'2000/12/17 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2456,106,'2000/12/17 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2457,204,'2000/12/17 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2458,107,'2000/12/18 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2459,203,'2000/12/21 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2460,108,'2000/12/21 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2461,202,'2000/12/22 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2462,109,'2000/12/22 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2463,200,'2000/12/24 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2464,110,'2000/12/23 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2465,199,'2000/12/28 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2466,112,'2000/12/29 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2467,198,'2000/12/29 00:00:00.000','r1','Western',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2468,113,'2000/12/30 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2469,197,'2000/12/30 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2470,114,'2000/12/31 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2471,196,'2000/12/31 00:00:00.000','r1','Canada',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2472,115,'2000/12/31 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2473,195,'2001/01/04 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2474,116,'2001/01/04 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2475,194,'2001/01/05 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2476,117,'2001/01/06 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2477,193,'2001/01/06 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2478,118,'2001/01/07 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2479,192,'2001/01/07 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2480,119,'2001/01/08 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2481,191,'2001/01/08 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2482,120,'2001/01/11 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2483,190,'2001/01/11 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2484,121,'2001/01/13 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2485,189,'2001/01/13 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2486,122,'2001/01/14 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2487,188,'2001/01/14 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2488,123,'2001/01/15 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2489,187,'2001/01/15 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2490,124,'2001/01/18 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2491,186,'2001/01/18 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2492,125,'2001/01/19 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2493,185,'2001/01/20 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2494,126,'2001/01/20 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2495,184,'2001/01/21 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2496,127,'2001/01/22 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2497,183,'2001/01/22 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2498,128,'2001/01/25 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2499,182,'2001/01/25 00:00:00.000','r1','Western',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2500,129,'2001/01/26 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2501,181,'2001/01/26 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2502,130,'2001/01/27 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2503,180,'2001/01/27 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2504,131,'2001/01/28 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2505,179,'2001/01/28 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2506,132,'2001/01/29 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2507,178,'2001/01/29 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2508,133,'2001/02/01 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2509,177,'2001/02/02 00:00:00.000','r1','South',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2510,134,'2001/02/03 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2511,176,'2001/02/04 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2512,135,'2001/02/04 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2513,175,'2001/02/05 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2514,136,'2001/02/08 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2515,174,'2001/02/08 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2516,137,'2001/02/09 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2517,173,'2001/02/09 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2518,138,'2001/02/10 00:00:00.000','r1','Canada',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2519,172,'2001/02/10 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2520,139,'2001/02/11 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2521,171,'2001/02/11 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2522,140,'2001/02/11 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2523,170,'2001/02/15 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2524,133,'2001/02/16 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2525,169,'2001/02/17 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2526,134,'2001/02/18 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2527,168,'2001/02/18 00:00:00.000','r1','Western',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2528,135,'2001/02/19 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2529,167,'2001/02/22 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2530,136,'2001/02/22 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2531,166,'2001/02/23 00:00:00.000','r1','South',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2532,137,'2001/02/23 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2533,165,'2001/02/24 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2534,138,'2001/02/24 00:00:00.000','r1','Canada',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2535,164,'2001/02/25 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2536,139,'2001/02/25 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2537,163,'2001/02/26 00:00:00.000','r1','Canada',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2538,142,'2001/03/01 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2539,162,'2001/03/01 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2540,143,'2001/03/02 00:00:00.000','r1','Canada',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2541,161,'2001/03/02 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2542,160,'2001/03/03 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2543,144,'2001/03/03 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2544,159,'2001/03/04 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2545,145,'2001/03/04 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2546,158,'2001/03/05 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2547,146,'2001/03/05 00:00:00.000','r1','Western',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2548,157,'2001/03/05 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2549,147,'2001/03/08 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2550,156,'2001/03/08 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2551,148,'2001/03/09 00:00:00.000','r1','Canada',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2552,155,'2001/03/10 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2553,148,'2001/03/10 00:00:00.000','r1','Canada',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2554,154,'2001/03/11 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2555,149,'2001/03/11 00:00:00.000','r1','Canada',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2556,153,'2001/03/11 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2557,150,'2001/03/12 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2558,152,'2001/03/12 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2559,151,'2001/03/15 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2560,101,'2001/03/16 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2561,209,'2001/03/16 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2562,102,'2001/03/17 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2563,208,'2001/03/17 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2564,103,'2001/03/18 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2565,207,'2001/03/18 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2566,104,'2001/03/22 00:00:00.000','r1','South',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2567,206,'2001/03/22 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2568,105,'2001/03/23 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2569,205,'2001/03/23 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2570,106,'2001/03/24 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2571,204,'2001/03/24 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2572,107,'2001/03/24 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2573,203,'2001/03/25 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2574,108,'2001/03/25 00:00:00.000','r1','South',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2575,202,'2001/03/26 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2576,109,'2001/03/26 00:00:00.000','r1','Canada',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2577,201,'2001/03/29 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2578,110,'2001/03/29 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2579,133,'2001/03/31 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2580,200,'2001/03/30 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2581,111,'2001/03/31 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2582,209,'2000/04/01 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2583,101,'2001/04/05 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2584,208,'2001/04/06 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2585,102,'2001/04/08 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2586,207,'2001/04/09 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2587,103,'2001/04/12 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2588,206,'2001/04/13 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2589,104,'2001/04/13 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2590,205,'2001/04/14 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2591,105,'2001/04/14 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2592,204,'2001/04/14 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2593,106,'2001/04/16 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2594,203,'2001/04/16 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2595,107,'2001/04/16 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2596,202,'2001/04/19 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2597,108,'2001/04/19 00:00:00.000','r1','South',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2598,201,'2001/04/20 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2599,109,'2001/04/20 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2600,200,'2001/04/20 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2601,110,'2001/04/21 00:00:00.000','r1','Central',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2602,199,'2001/04/21 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2603,111,'2001/04/22 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2604,198,'2001/04/23 00:00:00.000','r1','Western',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2605,112,'2001/04/23 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2606,197,'2001/04/26 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2607,113,'2001/04/26 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2608,196,'2001/04/26 00:00:00.000','r1','Canada',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2609,114,'2001/04/27 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2610,195,'2001/04/27 00:00:00.000','r1','South',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2611,115,'2001/04/28 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2612,194,'2001/04/28 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2613,116,'2001/04/29 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2614,193,'2001/04/29 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2615,117,'2001/04/29 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2616,192,'2001/04/30 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2617,118,'2001/05/04 00:00:00.000','r1','South',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2618,191,'2001/05/04 00:00:00.000','r1','South',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2619,119,'2001/05/05 00:00:00.000','r1','Western',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2620,190,'2001/05/05 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2621,120,'2001/05/06 00:00:00.000','r1','Eastern',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2622,189,'2001/05/06 00:00:00.000','r1','Eastern',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2623,121,'2001/05/07 00:00:00.000','r1','Central',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2624,188,'2001/05/07 00:00:00.000','r1','Central',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2625,122,'2001/05/10 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2626,187,'2001/05/10 00:00:00.000','r1','Central',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2627,123,'2001/05/11 00:00:00.000','r1','Canada',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2628,186,'2001/05/11 00:00:00.000','r1','Central',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2629,124,'2001/05/12 00:00:00.000','r1','Eastern',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2630,185,'2001/05/12 00:00:00.000','r1','Eastern',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2631,125,'2001/05/13 00:00:00.000','r1','Central',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2632,184,'2001/05/13 00:00:00.000','r1','Central',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2633,126,'2001/05/14 00:00:00.000','r1','Western',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2634,183,'2001/05/14 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2635,127,'2001/05/17 00:00:00.000','r1','South',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2636,182,'2001/05/18 00:00:00.000','r1','Western',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2637,128,'2001/05/18 00:00:00.000','r1','Eastern',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2638,181,'2001/05/19 00:00:00.000','r1','Eastern',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2639,129,'2001/05/19 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2640,180,'2001/05/20 00:00:00.000','r1','Eastern',467 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2641,130,'2001/05/20 00:00:00.000','r1','Central',949 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2642,179,'2001/05/21 00:00:00.000','r1','South',902 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2643,129,'2001/05/21 00:00:00.000','r1','Eastern',856 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2644,178,'2001/05/25 00:00:00.000','r1','Eastern',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2645,130,'2001/05/25 00:00:00.000','r1','Central',667 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2646,177,'2001/05/26 00:00:00.000','r1','South',1142 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2647,131,'2001/05/26 00:00:00.000','r1','Eastern',129 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2648,176,'2001/05/27 00:00:00.000','r1','Eastern',195 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2649,132,'2001/05/27 00:00:00.000','r1','Central',690 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2650,175,'2001/05/28 00:00:00.000','r1','Canada',1596 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2651,133,'2001/05/28 00:00:00.000','r1','Western',299 )#
INSERT INTO DEMO.SalesOrders VALUES
    ( 2652,174,'2001/05/28 00:00:00.000','r1','Central',902 )#

COMMIT#

-- Populate SalesOrderItems table

INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2001,1,300,12,'2000/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2001,2,301,12,'2000/03/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2001,3,302,12,'2000/03/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2002,1,400,24,'2000/03/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2002,2,401,24,'2000/03/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2003,1,500,12,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2003,2,501,12,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2004,1,600,48,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2004,2,601,48,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2005,1,700,12,'2001/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2006,1,300,48,'2001/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2007,1,301,24,'2001/04/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2008,1,302,12,'2001/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2009,1,400,12,'2001/04/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2010,1,401,12,'2001/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2011,1,500,36,'2001/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2012,1,501,12,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2013,1,600,24,'2001/04/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2013,2,601,24,'2001/04/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2014,1,700,36,'2001/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2015,1,300,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2015,2,301,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2015,3,302,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2015,4,700,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2016,1,400,12,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2016,2,401,12,'2000/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2016,3,500,12,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2016,4,501,12,'2000/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2017,1,302,48,'2001/03/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2017,2,600,48,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2017,3,601,48,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2018,1,700,60,'2001/03/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2019,1,300,12,'2000/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2020,1,700,24,'2001/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2021,1,600,12,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2022,1,500,24,'2001/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2023,1,401,24,'2001/06/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2024,1,302,36,'2001/07/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2025,1,501,12,'2001/05/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2026,1,301,48,'2001/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2026,2,700,48,'2001/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2027,1,401,12,'2001/06/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2028,1,601,24,'2000/07/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2029,1,302,48,'2000/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2030,1,300,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2030,2,301,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2030,3,302,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2030,4,700,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2031,1,400,48,'2000/06/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2031,2,401,48,'2001/06/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2032,1,501,60,'2001/07/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2033,1,400,24,'2001/02/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2033,2,401,24,'2000/02/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2035,1,501,36,'2001/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2036,1,600,12,'2001/01/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2037,1,601,12,'2000/01/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2038,1,700,60,'2001/02/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2039,1,300,12,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2040,1,301,24,'2001/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2041,1,302,36,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2042,1,400,12,'2001/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2043,1,401,36,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2044,1,500,48,'2000/07/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2045,1,501,36,'2000/07/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2046,1,600,12,'2001/02/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2047,1,601,24,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2048,1,700,12,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2049,1,300,24,'2001/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2050,1,301,24,'2001/03/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2051,1,302,36,'2000/05/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2052,1,400,48,'2001/07/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2053,1,401,60,'2001/06/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2054,1,500,12,'2001/05/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2055,1,501,12,'2001/03/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2056,1,600,24,'2001/04/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2057,1,700,24,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2058,1,300,12,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2059,1,301,12,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2060,1,302,12,'2001/05/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2061,1,400,24,'2000/07/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2062,1,401,36,'2001/06/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2063,1,500,48,'2001/06/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2064,1,501,60,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2065,1,600,12,'2000/01/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2067,1,700,72,'2001/04/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2068,1,300,36,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2069,1,301,12,'2001/02/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2070,1,302,24,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2071,1,400,60,'2001/05/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2072,1,400,24,'2001/05/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2073,1,401,24,'2001/06/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2074,1,500,12,'2001/07/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2074,2,501,12,'2001/07/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2075,1,600,12,'2001/02/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2076,1,601,36,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2077,1,700,48,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2078,1,300,12,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2079,1,301,24,'2001/04/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2080,1,302,12,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2081,1,400,36,'2000/06/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2082,1,401,48,'2001/07/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2083,1,500,60,'2000/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2084,1,501,60,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2085,1,600,24,'2000/03/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2086,1,601,12,'2001/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2087,1,700,36,'2001/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2089,1,300,12,'2001/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2090,1,301,24,'2001/07/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2091,1,302,60,'2001/07/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2092,1,400,12,'2001/01/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2093,1,401,24,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2094,1,500,24,'2001/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2095,1,300,36,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2095,2,301,36,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2095,3,302,36,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2096,1,501,12,'2001/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2097,1,600,48,'2000/06/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2098,1,601,60,'2001/07/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2099,1,700,12,'2000/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2100,1,400,36,'2001/02/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2101,1,401,24,'2000/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2102,1,500,12,'2001/04/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2103,1,501,48,'2001/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2104,1,600,12,'2000/06/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2105,1,700,24,'2001/07/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2106,1,300,12,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2107,1,301,36,'2000/02/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2109,1,400,60,'2000/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2110,1,401,24,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2111,1,500,36,'2001/06/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2112,1,501,12,'2001/07/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2112,2,601,12,'2001/01/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2113,1,600,12,'2001/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2114,1,600,24,'2001/02/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2114,2,601,24,'2001/02/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2115,1,600,36,'2000/03/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2115,2,700,36,'2000/03/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2116,1,300,48,'2001/04/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2117,1,301,60,'2000/05/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2118,1,302,12,'2001/06/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2119,1,400,24,'2001/07/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2120,1,401,24,'2001/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2121,1,500,12,'2000/02/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2122,1,501,48,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2123,1,600,60,'2001/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2124,1,601,60,'2000/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2125,1,400,36,'2001/06/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2125,2,401,36,'2001/06/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2125,3,500,36,'2001/06/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2126,1,301,24,'2000/01/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2127,1,400,36,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2128,1,400,24,'2000/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2128,2,700,36,'2000/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2129,1,300,12,'2000/01/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2130,1,501,24,'2000/01/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2131,1,300,12,'2000/01/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2131,2,301,12,'2000/01/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2131,3,302,12,'2000/01/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2132,1,400,48,'2000/01/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2132,2,401,48,'2000/01/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2133,1,500,24,'2000/01/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2134,1,600,12,'2000/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2135,1,300,12,'2000/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2135,2,301,12,'2000/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2135,3,302,12,'2000/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2136,1,400,24,'2000/01/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2136,2,401,24,'2000/01/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2137,1,500,60,'2000/01/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2137,2,501,60,'2000/01/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2138,1,600,36,'2000/01/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2138,2,601,36,'2000/01/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2139,1,700,60,'2000/01/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2140,1,300,36,'2000/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2140,2,301,36,'2000/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2140,3,302,36,'2000/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2141,1,400,12,'2000/01/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2141,2,401,12,'2000/01/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2142,1,500,24,'2000/01/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2142,2,501,24,'2000/01/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2143,1,600,48,'2000/01/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2143,2,601,48,'2000/01/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2144,1,400,12,'2000/01/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2144,2,700,12,'2000/01/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2145,1,500,24,'2000/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2145,2,501,24,'2000/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2146,1,600,12,'2000/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2146,2,601,12,'2000/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2146,3,700,12,'2000/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2147,1,300,36,'2000/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2147,2,301,36,'2000/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2147,3,302,36,'2000/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2148,1,400,12,'2000/01/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2148,2,401,12,'2000/01/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2149,1,500,24,'2000/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2149,2,501,24,'2000/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2150,1,600,12,'2000/02/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2150,2,601,12,'2000/02/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2151,1,700,72,'2000/02/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2152,1,400,12,'2000/02/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2152,2,401,12,'2000/02/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2153,1,500,24,'2000/02/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2153,2,501,24,'2000/02/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2154,1,600,36,'2000/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2154,2,601,36,'2000/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2155,1,700,60,'2000/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2156,1,300,12,'2000/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2156,2,301,12,'2000/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2156,3,302,12,'2000/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2156,4,700,12,'2000/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2157,1,400,24,'2000/02/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2157,2,401,24,'2000/02/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2157,3,500,24,'2000/02/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2157,4,501,24,'2000/02/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2158,1,500,12,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2158,2,501,12,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2158,3,600,36,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2158,4,601,36,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2159,1,600,24,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2160,1,601,24,'2000/02/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2161,1,300,36,'2000/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2161,2,301,36,'2000/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2161,3,302,12,'2000/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2162,1,400,24,'2000/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2162,2,401,12,'2000/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2162,3,500,36,'2000/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2163,1,600,24,'2000/02/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2163,2,601,24,'2000/02/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2164,1,600,60,'2000/02/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2164,2,601,60,'2000/02/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2164,3,700,36,'2000/02/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2165,1,300,12,'2000/02/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2165,2,301,24,'2000/02/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2165,3,302,12,'2000/02/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2166,1,400,36,'2000/02/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2166,2,401,36,'2000/02/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2167,1,400,12,'2000/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2167,2,401,12,'2000/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2167,3,500,12,'2000/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2167,4,501,24,'2000/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2168,1,600,24,'2000/02/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2168,2,601,24,'2000/02/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2169,1,300,36,'2000/02/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2169,2,301,36,'2001/02/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2169,3,302,24,'2000/02/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2170,1,400,60,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2170,2,401,24,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2170,3,500,24,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2171,1,600,12,'2000/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2171,2,601,12,'2000/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2172,1,300,24,'2000/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2172,2,301,24,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2172,3,302,24,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2173,1,400,12,'2000/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2173,2,401,12,'2000/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2174,1,500,36,'2000/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2174,2,501,36,'2000/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2175,1,600,48,'2000/03/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2175,2,601,48,'2000/03/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2176,1,700,60,'2000/03/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2177,1,300,12,'2000/03/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2178,1,300,24,'2000/03/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2178,2,301,24,'2000/03/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2178,3,400,12,'2000/03/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2179,1,500,36,'2000/03/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2179,2,501,36,'2000/03/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2180,1,600,12,'2000/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2180,2,601,12,'2000/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2180,3,700,24,'2000/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2181,1,400,36,'2000/03/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2181,2,401,36,'2000/03/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2182,1,500,12,'2000/03/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2182,2,501,12,'2000/03/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2183,1,600,24,'2000/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2183,2,601,24,'2000/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2184,1,300,12,'2000/03/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2184,2,301,12,'2000/03/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2184,3,700,12,'2000/03/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2185,1,400,24,'2000/03/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2185,2,401,24,'2000/03/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2186,1,500,36,'2000/03/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2186,2,501,36,'2000/03/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2187,1,600,48,'2000/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2187,2,601,48,'2000/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2188,1,700,60,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2189,1,300,12,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2189,2,302,12,'2000/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2190,1,301,24,'2000/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2190,2,400,24,'2000/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2190,3,501,24,'2000/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2191,1,302,36,'2000/03/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2191,2,601,36,'2000/03/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2191,3,700,36,'2000/03/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2192,1,301,12,'2000/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2192,2,401,12,'2000/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2192,3,600,12,'2000/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2193,1,600,24,'2000/03/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2193,2,601,24,'2000/03/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2193,3,700,24,'2000/03/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2194,1,300,12,'2000/04/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2194,2,301,12,'2000/04/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2194,3,302,12,'2000/04/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2195,1,400,12,'2000/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2195,2,500,24,'2000/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2195,3,501,24,'2000/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2196,1,400,36,'2000/04/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2196,2,401,36,'2000/04/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2196,3,500,24,'2000/04/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2197,1,600,48,'2000/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2197,2,601,48,'2000/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2197,3,700,48,'2000/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2198,1,300,12,'2000/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2198,2,301,12,'2000/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2198,3,302,12,'2000/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2199,1,400,36,'2000/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2199,2,401,36,'2000/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2199,3,600,12,'2000/04/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2200,1,400,24,'2000/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2200,2,401,24,'2000/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2200,3,500,24,'2000/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2201,1,600,60,'2000/04/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2201,2,601,60,'2000/04/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2201,3,700,60,'2000/04/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2202,1,300,12,'2000/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2202,2,301,12,'2000/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2202,3,302,12,'2000/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2203,1,400,24,'2000/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2203,2,401,24,'2000/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2204,1,400,24,'2000/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2204,2,401,24,'2000/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2204,3,500,36,'2000/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2204,4,501,36,'2000/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2205,1,500,12,'2000/04/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2205,2,501,12,'2000/04/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2205,3,700,24,'2000/04/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2206,1,300,12,'2000/04/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2206,2,301,12,'2000/04/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2206,3,302,12,'2000/04/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2206,4,700,12,'2000/04/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2207,1,400,24,'2000/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2207,2,401,24,'2000/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2207,3,501,12,'2000/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2208,1,400,36,'2000/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2208,2,401,36,'2000/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2208,3,500,36,'2000/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2208,4,501,36,'2000/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2209,1,500,12,'2000/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2209,2,501,12,'2000/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2209,3,600,12,'2000/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2209,4,601,12,'2000/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2210,1,300,24,'2000/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2210,2,301,24,'2000/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2210,3,302,24,'2000/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2210,4,700,24,'2000/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2211,1,400,36,'2000/04/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2211,2,501,24,'2000/04/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2211,3,600,12,'2000/04/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2212,1,401,36,'2000/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2212,2,500,24,'2000/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2212,3,601,12,'2000/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2213,1,300,48,'2000/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2213,2,301,36,'2000/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2213,3,600,24,'2000/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2213,4,601,24,'2000/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2214,1,302,12,'2000/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2214,2,401,12,'2000/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2214,3,700,24,'2000/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2215,1,301,12,'2000/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2215,2,500,12,'2000/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2215,3,700,36,'2000/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2216,1,400,24,'2000/05/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2216,2,401,24,'2000/05/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2217,1,400,24,'2000/05/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2217,2,500,36,'2000/05/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2217,3,501,36,'2000/05/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2218,1,600,24,'2000/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2218,2,601,24,'2000/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2219,3,300,24,'2000/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2219,4,401,12,'2000/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2219,5,700,48,'2000/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2220,1,301,24,'2000/05/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2220,2,700,36,'2000/05/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2221,1,401,12,'2000/05/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2221,2,601,24,'2000/05/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2222,1,500,12,'2000/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2222,2,501,12,'2000/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2223,1,600,24,'2000/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2223,2,601,24,'2000/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2223,3,700,12,'2000/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2224,1,300,24,'2000/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2224,2,301,24,'2000/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2224,3,302,24,'2000/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2225,1,400,36,'2000/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2225,2,401,36,'2000/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2226,1,500,12,'2000/05/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2226,2,501,12,'2000/05/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2227,1,600,12,'2000/05/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2227,2,601,12,'2000/05/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2228,1,300,36,'2000/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2228,2,302,36,'2000/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2229,1,301,24,'2000/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2229,2,400,24,'2000/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2229,3,700,12,'2000/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2230,1,600,60,'2000/05/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2230,2,601,60,'2000/05/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2231,1,500,72,'2000/05/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2231,2,501,60,'2000/05/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2232,1,400,36,'2000/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2232,2,401,36,'2000/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2233,1,500,12,'2000/05/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2233,2,501,12,'2000/05/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2234,1,600,24,'2000/05/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2234,2,601,24,'2000/05/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2235,1,300,36,'2000/05/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2235,2,302,36,'2000/05/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2236,1,301,12,'2000/05/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2236,2,700,60,'2000/05/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2237,1,400,36,'2000/06/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2237,2,401,36,'2000/06/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2238,1,500,24,'2000/05/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2239,1,600,72,'2000/06/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2239,2,601,60,'2000/06/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2240,1,300,12,'2000/06/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2240,2,301,12,'2000/06/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2240,3,302,12,'2000/06/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2241,1,400,24,'2000/06/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2241,2,401,24,'2000/06/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2242,1,600,60,'2000/06/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2242,2,601,48,'2000/06/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2243,1,500,24,'2000/06/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2243,2,501,12,'2000/06/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2244,1,300,24,'2000/06/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2244,2,302,24,'2000/06/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2245,1,301,36,'2000/06/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2245,2,400,24,'2000/06/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2246,1,600,48,'2000/06/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2246,2,601,60,'2000/06/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2247,1,300,12,'2000/06/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2247,2,700,24,'2000/06/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2248,1,301,12,'2000/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2248,2,400,12,'2000/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2249,1,302,12,'2000/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2249,2,401,24,'2000/06/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2250,1,300,24,'2000/06/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2250,2,700,36,'2000/06/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2251,1,500,12,'2000/06/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2251,2,501,24,'2000/06/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2252,1,300,12,'2000/06/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2252,2,302,12,'2000/06/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2253,1,301,24,'2000/06/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2253,2,400,12,'2000/06/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2254,1,500,36,'2000/06/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2254,2,501,24,'2000/06/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2255,1,600,48,'2000/06/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2255,2,601,36,'2000/06/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2256,1,400,12,'2000/06/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2256,2,401,12,'2000/06/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2257,1,302,24,'2000/06/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2257,2,400,12,'2000/06/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2257,3,700,24,'2000/06/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2258,1,300,36,'2000/06/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2258,2,301,24,'2000/06/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2258,3,302,12,'2000/06/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2259,1,400,36,'2000/06/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2259,2,401,36,'2000/06/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2260,1,600,48,'2000/07/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2260,2,601,48,'2000/07/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2261,1,300,12,'2000/07/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2261,2,700,48,'2000/07/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2262,1,301,24,'2000/07/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2262,2,400,12,'2000/07/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2263,1,300,24,'2000/07/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2263,2,302,24,'2000/07/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2264,1,401,36,'2000/07/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2264,2,501,48,'2000/07/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2264,3,600,12,'2000/07/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2265,1,400,24,'2000/07/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2265,2,401,24,'2000/07/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2266,1,500,12,'2000/07/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2266,2,501,12,'2000/07/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2267,1,600,24,'2000/07/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2267,2,601,12,'2000/07/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2267,3,700,48,'2000/07/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2268,1,300,12,'2000/07/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2268,2,301,12,'2000/07/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2269,1,300,24,'2000/07/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2269,2,400,48,'2000/07/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2269,3,601,12,'2000/07/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2270,1,400,36,'2000/07/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2270,2,401,24,'2000/07/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2271,1,500,12,'2000/07/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2272,1,600,24,'2000/07/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2272,2,601,12,'2000/07/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2273,1,700,60,'2000/07/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2274,1,300,48,'2000/07/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2274,2,301,36,'2000/07/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2275,1,400,12,'2000/07/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2275,2,401,24,'2000/07/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2276,1,500,36,'2000/07/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2276,2,501,24,'2000/07/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2277,1,600,12,'2000/07/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2277,2,601,24,'2000/07/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2278,1,700,48,'2000/07/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2279,1,300,12,'2000/07/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2280,1,301,24,'2000/07/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2280,2,700,48,'2000/07/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2281,1,400,12,'2000/07/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2281,2,401,12,'2000/07/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2282,1,600,24,'2000/07/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2282,2,601,12,'2000/07/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2283,1,700,48,'2000/07/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2284,1,301,12,'2000/07/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2284,2,700,60,'2000/07/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2285,1,300,24,'2000/07/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2285,2,302,12,'2000/07/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2286,1,301,24,'2000/07/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2286,2,400,12,'2000/07/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2287,1,500,12,'2000/07/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2287,2,501,24,'2000/07/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2288,1,600,12,'2000/08/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2288,2,601,24,'2000/08/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2289,1,700,48,'2000/08/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2290,1,300,12,'2000/08/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2290,2,301,12,'2000/08/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2290,3,600,24,'2000/08/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2291,1,601,12,'2000/08/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2291,2,700,12,'2000/08/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2292,1,500,24,'2000/08/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2292,2,501,12,'2000/08/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2293,1,600,24,'2000/08/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2293,2,601,12,'2000/08/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2294,1,700,36,'2000/08/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2295,1,500,12,'2000/08/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2295,2,501,24,'2000/08/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2296,1,600,36,'2000/08/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2296,2,601,24,'2000/08/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2297,1,700,12,'2000/08/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2298,1,300,60,'2000/08/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2298,2,301,36,'2000/08/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2299,1,400,12,'2000/08/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2299,2,401,12,'2000/08/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2300,1,600,36,'2000/08/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2300,2,601,24,'2000/08/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2301,1,700,36,'2000/08/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2302,1,400,12,'2000/08/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2302,2,401,24,'2000/08/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2303,1,500,36,'2000/08/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2303,2,501,36,'2000/08/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2304,1,700,60,'2000/08/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2305,1,301,12,'2000/08/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2306,1,300,24,'2000/08/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2306,2,302,12,'2000/08/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2307,1,301,36,'2000/08/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2307,2,700,12,'2000/08/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2308,1,400,24,'2000/08/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2308,2,401,24,'2000/08/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2309,1,500,12,'2000/08/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2309,2,501,12,'2000/08/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2310,1,600,24,'2000/08/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2310,2,601,24,'2000/08/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2311,1,700,36,'2000/08/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2312,1,300,12,'2000/08/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2312,2,301,12,'2000/08/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2312,3,302,12,'2000/08/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2313,1,300,12,'2000/09/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2313,2,700,24,'2000/09/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2314,1,301,24,'2000/09/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2315,1,400,12,'2000/09/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2315,2,401,12,'2000/09/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2316,1,500,24,'2000/09/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2316,2,501,12,'2000/09/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2317,1,600,36,'2000/09/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2317,2,601,48,'2000/09/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2318,1,300,12,'2000/09/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2318,2,301,12,'2000/09/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2319,1,302,24,'2000/09/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2319,2,700,36,'2000/09/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2320,1,400,12,'2000/09/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2320,2,401,12,'2000/09/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2321,1,501,24,'2000/09/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2322,1,700,60,'2000/09/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2323,1,600,48,'2000/09/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2324,1,601,24,'2000/09/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2324,2,700,12,'2000/09/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2325,1,400,24,'2000/09/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2326,1,600,12,'2000/09/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2327,1,300,24,'2000/09/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2327,2,302,12,'2000/09/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2328,1,301,36,'2000/09/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2328,2,302,24,'2000/09/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2329,1,300,12,'2000/09/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2329,2,700,48,'2000/09/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2330,1,400,24,'2000/09/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2331,1,501,12,'2000/09/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2332,1,600,72,'2000/09/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2333,1,700,12,'2000/09/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2334,1,301,24,'2000/09/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2334,2,302,12,'2000/09/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2335,1,300,36,'2000/09/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2336,1,700,36,'2000/09/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2337,1,300,12,'2000/09/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2337,2,301,24,'2000/09/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2338,1,302,12,'2000/09/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2339,1,400,24,'2000/09/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2340,1,500,36,'2000/09/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2341,1,601,12,'2000/09/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2342,1,700,24,'2000/09/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2343,1,400,12,'2000/09/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2344,1,501,36,'2000/09/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2345,1,600,24,'2000/09/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2346,1,302,12,'2000/09/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2347,1,400,38,'2000/10/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2348,1,500,24,'2000/10/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2349,1,302,60,'2000/10/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2350,1,401,48,'2000/10/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2351,1,500,12,'2000/10/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2352,1,300,36,'2000/10/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2353,1,501,24,'2000/10/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2354,1,600,12,'2000/10/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2355,1,601,36,'2000/10/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2355,2,700,24,'2000/10/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2356,1,300,12,'2000/10/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2357,1,302,24,'2000/10/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2358,1,401,36,'2000/10/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2359,1,500,12,'2000/10/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2360,1,301,24,'2000/10/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2360,2,302,12,'2000/10/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2361,1,400,36,'2000/10/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2362,1,501,24,'2000/10/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2363,1,601,36,'2000/10/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2364,1,700,72,'2000/10/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2365,1,300,12,'2000/10/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2366,1,500,36,'2000/10/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2366,2,501,24,'2000/10/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2367,1,400,12,'2000/10/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2368,1,401,24,'2000/10/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2369,1,700,48,'2000/10/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2370,1,600,12,'2000/10/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2371,1,501,36,'2000/10/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2372,1,300,24,'2000/10/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2373,1,302,12,'2000/10/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2374,1,501,36,'2000/10/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2375,1,500,24,'2000/10/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2376,1,600,12,'2000/10/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2377,1,700,48,'2000/10/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2378,1,301,36,'2000/10/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2379,1,401,24,'2000/10/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2379,2,600,12,'2000/10/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2380,1,400,36,'2000/10/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2381,1,302,24,'2000/10/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2382,1,400,12,'2000/10/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2383,1,601,24,'2000/10/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2384,1,300,48,'2000/10/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2384,2,401,36,'2000/10/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2385,1,700,24,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2386,1,500,12,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2387,1,302,24,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2387,2,700,36,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2388,1,401,12,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2388,2,501,24,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2388,3,700,60,'2000/10/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2389,1,600,24,'2000/10/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2389,2,601,12,'2000/10/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2390,1,400,36,'2000/11/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2390,2,401,24,'2000/11/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2391,1,300,12,'2000/11/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2392,1,500,24,'2000/11/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2392,2,501,24,'2000/11/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2393,1,600,12,'2000/11/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2394,1,700,48,'2000/11/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2395,1,301,60,'2000/11/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2395,2,302,24,'2000/11/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2396,1,500,12,'2000/11/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2396,2,501,12,'2000/11/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2397,1,700,36,'2000/11/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2398,1,400,24,'2000/11/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2398,2,500,12,'2000/11/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2398,3,501,24,'2000/11/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2399,1,401,48,'2000/11/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2399,2,700,12,'2000/11/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2400,1,300,24,'2000/11/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2400,2,301,24,'2000/11/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2401,1,600,12,'2000/11/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2401,2,601,24,'2000/11/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2402,1,302,36,'2000/11/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2403,1,400,12,'2000/11/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2403,2,401,12,'2000/11/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2404,1,500,24,'2000/11/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2404,2,501,12,'2000/11/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2405,1,300,36,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2405,2,301,36,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2406,1,400,24,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2406,2,401,12,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2407,1,302,36,'2000/11/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2407,2,700,24,'2000/11/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2408,1,500,36,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2408,2,501,24,'2000/11/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2409,1,600,12,'2000/11/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2409,2,601,24,'2000/11/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2410,1,400,12,'2000/11/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2411,1,300,36,'2000/11/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2411,2,301,24,'2000/11/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2411,3,302,12,'2000/11/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2412,1,400,24,'2000/11/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2412,2,401,24,'2000/11/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2413,1,500,60,'2000/11/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2414,1,501,36,'2000/11/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2414,2,600,24,'2000/11/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2415,1,601,12,'2000/11/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2416,1,700,36,'2000/11/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2417,1,302,12,'2000/11/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2418,1,300,24,'2000/11/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2418,2,301,12,'2000/11/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2419,1,302,24,'2000/11/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2420,1,400,36,'2000/11/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2421,1,401,48,'2000/11/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2422,1,500,36,'2000/11/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2423,1,501,12,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2423,2,600,24,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2424,1,601,36,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2425,1,600,24,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2425,2,700,12,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2426,1,300,12,'2000/11/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2426,2,301,24,'2000/11/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2426,3,302,24,'2000/11/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2427,1,700,36,'2000/11/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2428,1,400,12,'2000/12/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2428,2,401,24,'2000/12/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2429,1,500,24,'2000/11/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2430,1,501,12,'2000/12/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2430,2,600,24,'2000/12/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2431,1,601,36,'2000/12/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2432,1,300,24,'2000/12/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2432,2,700,12,'2000/12/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2433,1,301,36,'2000/12/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2434,1,302,12,'2000/12/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2434,2,400,24,'2000/12/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2435,1,401,24,'2000/12/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2436,1,500,36,'2000/12/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2436,2,501,24,'2000/12/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2437,1,600,12,'2000/12/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2438,1,601,24,'2000/12/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2438,2,700,36,'2000/12/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2439,1,300,12,'2000/12/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2439,2,301,12,'2000/12/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2440,1,400,24,'2000/12/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2440,2,401,12,'2000/12/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2441,1,500,36,'2000/12/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2441,2,501,36,'2000/12/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2442,1,700,12,'2000/12/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2443,1,600,24,'2000/12/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2443,2,601,12,'2000/12/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2444,1,300,24,'2000/12/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2445,1,301,36,'2000/12/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2445,2,302,24,'2000/12/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2446,1,400,36,'2000/12/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2446,2,401,24,'2000/12/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2447,1,500,12,'2000/12/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2447,2,501,24,'2000/12/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2448,1,600,12,'2000/12/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2449,1,601,24,'2000/12/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2449,2,700,36,'2000/12/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2450,1,300,12,'2000/12/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2451,1,301,24,'2000/12/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2451,2,302,12,'2000/12/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2452,1,400,24,'2000/12/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2453,1,401,12,'2000/12/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2453,2,500,12,'2000/12/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2454,1,501,36,'2000/12/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2455,1,600,24,'2000/12/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2455,2,601,24,'2000/12/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2456,1,700,12,'2000/12/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2457,1,300,12,'2000/12/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2458,1,301,24,'2000/12/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2458,2,302,24,'2000/12/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2459,1,400,12,'2000/12/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2459,2,401,24,'2000/12/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2460,1,500,12,'2000/12/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2460,2,501,24,'2000/12/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2461,1,600,36,'2000/12/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2461,2,601,48,'2000/12/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2462,1,401,12,'2000/12/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2462,2,700,60,'2000/12/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2463,1,300,36,'2000/12/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2463,2,301,24,'2000/12/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2463,3,500,24,'2000/12/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2463,4,501,12,'2000/12/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2464,1,400,12,'2000/12/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2464,2,600,36,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2464,3,601,48,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2465,1,400,12,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2465,2,700,24,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2466,1,500,12,'2000/12/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2466,2,501,24,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2467,1,600,36,'2000/12/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2468,1,300,24,'2000/12/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2468,2,700,24,'2000/12/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2469,1,400,12,'2000/12/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2470,1,500,12,'2000/12/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2471,1,600,24,'2000/12/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2472,1,700,60,'2000/12/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2473,1,300,12,'2001/01/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2473,2,301,24,'2001/01/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2474,1,400,36,'2001/01/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2474,2,401,24,'2001/01/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2475,1,500,36,'2001/01/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2475,2,501,24,'2001/01/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2476,1,700,60,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2477,1,300,36,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2477,2,302,24,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2478,1,400,12,'2001/01/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2478,2,401,24,'2001/01/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2479,1,500,36,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2479,2,501,24,'2001/01/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2480,1,600,24,'2001/01/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2480,2,601,12,'2001/01/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2481,1,302,12,'2001/01/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2481,2,700,72,'2001/01/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2482,1,300,24,'2001/01/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2482,2,301,24,'2001/01/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2483,1,700,36,'2001/01/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2484,1,401,24,'2001/01/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2485,1,500,24,'2001/01/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2485,2,501,12,'2001/01/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2486,1,600,36,'2001/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2486,2,601,24,'2001/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2487,1,700,48,'2001/01/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2488,1,300,12,'2001/01/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2488,2,301,12,'2001/01/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2489,1,400,24,'2001/01/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2489,2,401,24,'2001/01/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2490,1,500,36,'2001/01/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2490,2,501,36,'2001/01/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2491,1,600,24,'2001/01/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2491,2,601,24,'2001/01/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2492,1,300,12,'2001/01/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2492,2,301,12,'2001/01/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2493,1,400,24,'2001/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2493,2,401,12,'2001/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2494,1,500,36,'2001/01/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2495,1,600,24,'2001/01/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2495,2,601,12,'2001/01/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2496,1,500,24,'2001/01/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2496,2,501,12,'2001/01/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2497,1,700,48,'2001/01/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2498,1,300,12,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2498,2,301,12,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2499,1,400,24,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2499,2,401,24,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2500,1,302,36,'2001/01/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2500,2,700,48,'2001/01/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2501,1,500,12,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2501,2,501,12,'2001/01/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2502,1,600,24,'2001/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2502,2,601,24,'2001/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2503,1,700,12,'2001/01/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2504,1,300,24,'2001/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2504,2,301,24,'2001/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2505,1,700,12,'2001/01/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2506,1,400,36,'2001/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2506,2,401,24,'2001/01/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2507,1,500,12,'2001/02/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2507,2,501,12,'2001/02/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2508,1,300,36,'2001/02/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2508,2,302,36,'2001/02/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2509,1,301,24,'2001/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2509,2,400,12,'2001/02/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2510,1,500,36,'2001/02/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2510,2,501,24,'2001/02/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2511,1,600,12,'2001/02/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2511,2,601,24,'2001/02/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2512,1,700,60,'2001/02/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2513,1,300,12,'2001/02/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2513,2,301,12,'2001/02/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2513,3,302,12,'2001/02/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2514,1,400,24,'2001/02/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2514,2,401,24,'2001/02/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2515,1,500,36,'2001/02/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2515,2,501,36,'2001/02/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2516,1,600,12,'2001/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2516,2,601,12,'2001/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2517,1,700,48,'2001/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2518,1,300,24,'2001/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2518,2,301,24,'2001/02/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2519,1,400,36,'2001/02/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2520,1,500,12,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2520,2,501,24,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2521,1,600,36,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2521,2,601,36,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2522,1,700,60,'2001/02/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2523,1,700,12,'2001/02/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2524,1,300,24,'2001/02/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2524,2,302,24,'2001/02/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2525,1,400,24,'2001/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2525,2,401,25,'2001/02/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2526,1,302,12,'2001/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2526,2,700,12,'2001/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2527,1,400,36,'2001/02/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2528,1,500,48,'2001/02/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2528,2,700,36,'2001/02/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2529,1,300,12,'2001/02/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2529,2,301,12,'2001/02/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2530,1,400,24,'2001/02/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2531,1,500,36,'2001/02/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2531,2,501,36,'2001/02/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2532,1,600,12,'2001/02/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2533,1,400,24,'2001/02/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2533,2,401,24,'2001/02/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2534,1,301,12,'2001/02/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2535,1,300,24,'2001/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2535,2,301,24,'2001/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2535,3,302,24,'2001/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2536,1,700,48,'2001/02/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2537,1,600,24,'2001/03/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2537,2,601,12,'2001/03/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2538,1,300,12,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2538,2,301,24,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2539,1,400,36,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2539,2,401,36,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2540,1,500,12,'2001/03/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2540,2,501,12,'2001/03/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2541,1,700,24,'2001/03/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2542,1,400,48,'2001/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2542,2,401,48,'2001/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2543,1,500,12,'2001/03/04 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2544,1,300,12,'2001/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2544,2,301,12,'2001/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2545,1,302,24,'2001/03/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2546,1,400,36,'2001/03/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2546,2,401,36,'2001/03/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2547,1,500,24,'2001/03/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2547,2,501,12,'2001/03/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2548,1,600,24,'2001/03/08 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2549,1,300,12,'2001/03/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2549,2,301,12,'2001/03/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2550,1,302,24,'2001/03/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2551,1,700,12,'2001/03/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2552,1,300,36,'2001/03/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2552,2,301,36,'2001/03/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2553,1,302,24,'2001/03/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2554,1,400,12,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2554,2,401,12,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2555,1,500,36,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2556,1,600,24,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2556,2,601,24,'2001/03/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2557,1,300,12,'2001/03/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2557,2,301,12,'2001/03/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2558,1,400,24,'2001/03/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2559,1,700,60,'2001/03/16 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2560,1,300,24,'2001/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2560,2,301,24,'2001/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2561,1,400,12,'2001/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2561,2,401,12,'2001/03/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2562,1,302,48,'2001/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2562,2,400,36,'2001/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2563,1,302,12,'2001/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2563,2,700,24,'2001/03/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2564,1,301,12,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2564,2,302,12,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2565,1,400,36,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2566,1,500,24,'2001/03/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2566,2,501,24,'2001/03/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2567,1,401,48,'2001/03/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2568,1,600,36,'2001/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2568,2,601,36,'2001/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2569,1,300,12,'2001/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2569,2,700,24,'2001/03/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2570,1,400,36,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2570,2,401,24,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2571,1,302,12,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2571,2,700,12,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2572,1,600,72,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2573,1,300,24,'2001/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2573,2,302,24,'2001/03/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2574,1,301,48,'2001/03/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2575,1,400,24,'2001/03/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2575,2,401,12,'2001/03/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2576,1,500,36,'2001/03/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2576,2,501,24,'2001/03/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2577,1,300,12,'2001/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2577,2,301,12,'2001/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2577,3,302,12,'2001/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2578,1,700,36,'2001/03/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2579,1,500,60,'2001/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2580,1,700,12,'2001/03/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2581,1,400,24,'2001/04/01 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2582,1,400,12,'2001/04/02 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2583,1,600,24,'2001/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2583,2,601,24,'2001/04/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2584,1,600,36,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2584,2,601,24,'2001/04/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2585,1,300,12,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2585,2,301,12,'2001/04/09 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2586,1,400,24,'2001/04/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2586,2,401,12,'2001/04/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2587,1,300,36,'2001/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2587,2,301,36,'2001/04/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2588,1,400,24,'2001/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2588,2,401,24,'2001/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2589,1,500,12,'2001/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2589,2,501,12,'2001/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2590,1,700,36,'2001/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2591,1,300,24,'2001/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2591,2,301,24,'2001/04/15 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2592,1,302,12,'2001/04/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2593,1,400,12,'2001/04/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2593,2,401,24,'2001/04/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2594,1,600,12,'2001/04/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2594,2,601,12,'2001/04/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2595,1,700,48,'2001/04/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2596,1,500,24,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2596,2,501,24,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2597,1,300,12,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2597,2,301,12,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2598,1,400,24,'2001/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2598,2,401,36,'2001/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2599,1,302,72,'2001/04/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2600,1,601,24,'2001/04/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2601,1,400,36,'2001/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2601,2,401,36,'2001/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2602,1,500,12,'2001/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2602,2,601,24,'2001/04/22 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2603,1,301,12,'2001/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2603,2,700,36,'2001/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2604,1,400,24,'2001/04/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2604,2,401,24,'2001/04/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2605,1,700,36,'2001/04/23 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2606,1,500,12,'2001/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2606,2,501,24,'2001/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2607,1,302,48,'2001/04/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2608,1,601,12,'2001/04/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2609,1,600,36,'2001/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2609,2,601,24,'2001/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2610,1,300,12,'2001/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2610,2,301,12,'2001/04/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2611,1,302,24,'2001/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2611,2,700,48,'2001/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2612,1,400,24,'2001/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2613,1,500,36,'2001/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2613,2,501,36,'2001/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2614,1,600,24,'2001/04/29 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2615,1,700,60,'2001/04/30 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2616,1,301,12,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2616,2,501,24,'2001/05/03 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2617,1,400,24,'2001/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2617,2,401,12,'2001/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2618,1,600,12,'2001/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2618,2,601,24,'2001/05/05 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2619,1,300,12,'2001/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2619,2,700,36,'2001/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2620,1,301,24,'2001/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2620,2,302,24,'2001/05/06 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2621,1,400,12,'2001/05/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2621,2,401,12,'2001/05/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2622,1,302,24,'2001/05/07 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2623,1,600,12,'2001/05/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2623,2,700,12,'2001/05/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2624,1,601,24,'2001/05/10 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2625,1,302,12,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2625,2,501,24,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2625,3,700,24,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2626,1,400,12,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2626,2,500,12,'2001/05/11 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2627,1,300,24,'2001/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2627,2,301,24,'2001/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2627,3,302,12,'2001/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2628,1,400,36,'2001/05/12 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2629,1,600,12,'2001/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2629,2,601,24,'2001/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2630,1,302,36,'2001/05/13 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2631,1,400,12,'2001/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2631,2,401,12,'2001/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2632,1,600,24,'2001/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2632,2,601,24,'2001/05/14 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2633,1,300,12,'2001/05/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2633,2,301,12,'2001/05/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2634,1,400,24,'2001/05/17 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2635,1,700,72,'2001/05/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2636,1,600,24,'2001/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2636,2,601,24,'2001/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2637,1,501,48,'2001/05/18 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2638,1,300,24,'2001/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2639,1,401,36,'2001/05/19 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2640,1,600,24,'2001/05/21 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2641,1,501,36,'2001/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2641,2,700,24,'2001/05/20 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2642,1,300,12,'2001/05/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2643,1,301,24,'2001/05/24 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2644,1,600,36,'2001/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2645,1,601,12,'2001/05/25 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2646,1,302,24,'2001/05/27 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2647,1,401,36,'2001/05/26 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2648,1,600,12,'2001/05/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2649,1,700,36,'2001/05/28 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2650,1,600,24,'2001/05/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2650,2,601,36,'2001/05/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2651,1,700,48,'2001/05/31 00:00:00.000' )#
INSERT INTO DEMO.SalesOrderItems VALUES
    ( 2652,1,400,36,'2001/05/28 00:00:00.000' )#

COMMIT#

-- Populate Contacts table
	
INSERT INTO DEMO.Contacts VALUES
    (     1,'Hildebrand','Jane','ma','280 Washington St.','Kanata','CA','USA','94608','5105551309','5105554209',119 )#
INSERT INTO DEMO.Contacts VALUES
    (     2,'Simmon','Larry','sa','343 Granville St.','Kitchener','TX','USA','77079','7135558960','7135559265',332 )#
INSERT INTO DEMO.Contacts VALUES
    (     3,'Critch','Susan','pd','457 Center St.','Yale','WY','USA','01923','5085554829','5085553025',220 )#
INSERT INTO DEMO.Contacts VALUES
    (     4,'Lambert','Terry','ad','20434 Page St.','Phillipsburg','CO','USA','94608','6175552246','6175553692',174 )#
INSERT INTO DEMO.Contacts VALUES
    (     5,'Sullivan','Dorothy','cs','541 Minuteman Dr.','Uxbridge','ME','USA','01742','5085553925','5085559931',0 )#
INSERT INTO DEMO.Contacts VALUES
    (     6,'Paull','Rose','fi','718 Bay St.','Huntsville','AZ','USA','01945','6175556392','6175551495',221 )#
INSERT INTO DEMO.Contacts VALUES
    (     7,'Glassmann','Beth','pd','144 Oak St.','Newcastle','IL','USA','02173','6175550273','6175559933',158 )#
INSERT INTO DEMO.Contacts VALUES
    (     8,'Powell','Gene','tr','52 West Main St.','Newcastle','IL','USA','02173','6175553528','6175559563',188 )#
INSERT INTO DEMO.Contacts VALUES
    (     9,'Fish','Jeffrey','ma','168 Red Acre Rd.','Newcastle','IL','USA','02173','6175553528','6175559563',158 )#
INSERT INTO DEMO.Contacts VALUES
    (    10,'Clarke','Molly','sa','557 Pine Grove Rd.','Newcastle','IL','USA','02173','6175554325','6175557638',188 )#
INSERT INTO DEMO.Contacts VALUES
    (    11,'Kelley','William','do','163 Rainbow Rd.','Hamilton','MI','USA','01803','6175558474','6175552594',204 )#
INSERT INTO DEMO.Contacts VALUES
    (    12,'Lyman','Thomas','cs','642 Story Rd.','Kanata','CA','USA','94608','5105555378','5105553372',126 )#
INSERT INTO DEMO.Contacts VALUES
    (    13,'Davidson','Joann','ma','6 Story Rd.','Kanata','CA','USA','94608','5105557363','5105559278',126 )#
INSERT INTO DEMO.Contacts VALUES
    (    14,'Pettengill','Mark','sa','126 Briarwood Ter.','Kanata','CA','USA','94608','5105553533','5105551146',168 )#
INSERT INTO DEMO.Contacts VALUES
    (    15,'Moore','Dawn','sa','One Park Drive','Oakville','GA','USA','30339','4045554834','4045558291',195 )#
INSERT INTO DEMO.Contacts VALUES
    (    16,'Lencki','John','cs','20 Brook Road','Hamilton','MI','USA','01803','6175555348','6175554619',204 )#
INSERT INTO DEMO.Contacts VALUES
    (    17,'Kaplan','Burt','sa','491 Keaton Lane','London','CO','USA','02174','6175553887','6175552398',139 )#
INSERT INTO DEMO.Contacts VALUES
    (    18,'Hayne','William','cs','883 Cornfield Ave.','Waterloo','AZ','USA','01720','5085557780','5085554422',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    19,'Chin','David','pd','162 Waverly Rd.','Hamilton','MI','USA','01803','6175553378','6175554453',204 )#
INSERT INTO DEMO.Contacts VALUES
    (    20,'White','Pauline','sa','5756 Prince St.','Kitchener','TX','USA','77079','7135553345','7135559222',332 )#
INSERT INTO DEMO.Contacts VALUES
    (    21,'Cobb','Paul','cs','81 Greenville St.','Oakville','GA','USA','30339','4045552239','4045558111',195 )#
INSERT INTO DEMO.Contacts VALUES
    (    22,'Goggin','Kevin','cs','808 East Main St.','Kitchener','TX','USA','77079','7135553340','7135559211',444 )#
INSERT INTO DEMO.Contacts VALUES
    (    23,'Cohen','Paul','cs','10 Park Street','Hamilton','MI','USA','01803','6175558883','6175554499',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    24,'Quinn','Peter','sa','8817 Shaw Rd.','Cornwall','NY','USA','02192','6175552222','6175559337',116 )#
INSERT INTO DEMO.Contacts VALUES
    (    25,'Brier','Michael','ad','97 Blackstone St.','London','CO','USA','02174','6175552398','6175553337',128 )#
INSERT INTO DEMO.Contacts VALUES
    (    26,'Mulley','Joan','pd','10 Westborn Ter.','Hamilton','MI','USA','01803','6175553998','6175552299',190 )#
INSERT INTO DEMO.Contacts VALUES
    (    27,'Evans','Carrie','sa','189 Washington St.','Oakville','GA','USA','30339','4045551169','4045558244',195 )#
INSERT INTO DEMO.Contacts VALUES
    (    28,'Philley','Mary','sa','592 Franklin Pl.','Kitchener','TX','USA','77079','7135553338','7135559066',444 )#
INSERT INTO DEMO.Contacts VALUES
    (    29,'Sinibaldi','Joseph','do','117 Center St.','London','CO','USA','02174','6175556699','6175554231',139 )#
INSERT INTO DEMO.Contacts VALUES
    (    30,'DeMarco','Michael','pd','231 Clare Ave.','Elora','OR','USA','01730','6175554400','6175557876',551 )#
INSERT INTO DEMO.Contacts VALUES
    (    31,'Miller','Henry','tr','932 Porter St.','Hamilton','MI','USA','01803','6175553356','6175551332',190 )#
INSERT INTO DEMO.Contacts VALUES
    (    32,'Reeves','Scott','cs','10 Linden St.','Hespeler','NJ','USA','08830','6035550988','6035555556',101 )#
INSERT INTO DEMO.Contacts VALUES
    (    33,'Page','Lynn','sa','53 Central Ave.','Cornwall','NY','USA','02192','6175558890','6175554544',111 )#
INSERT INTO DEMO.Contacts VALUES
    (    34,'Crowley','Charles','hr','19 Edson St.','Hamilton','MI','USA','01803','6175551344','6175559877',159 )#
INSERT INTO DEMO.Contacts VALUES
    (    35,'Burrill','Dana','pd','942 Beacon St.','Cornwall','NY','USA','02192','6175557956','6175552398',111 )#
INSERT INTO DEMO.Contacts VALUES
    (    36,'Caruso','William','fi','199 Edison St.','Elora','OR','USA','01730','6175552144','6175551656',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    37,'Purcell','Beth','sa','1348 Cherry Hill St.','London','CO','USA','02174','6175552349','6175551765',174 )#
INSERT INTO DEMO.Contacts VALUES
    (    38,'Weaver','Joe','ma','818 Main St.','Kitchener','TX','USA','77079','7135551956','7135554455',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    39,'Dewey','Michael','fi','105 Pleasant St.','Cornwall','NY','USA','02192','6175559877','6175552322',116 )#
INSERT INTO DEMO.Contacts VALUES
    (    40,'Jordan','Susan','pd','915 Gordon St.','Hamilton','MI','USA','01803','6175551123','6175551999',159 )#
INSERT INTO DEMO.Contacts VALUES
    (    41,'Romeo','John','ad','2350 Long Way','Sheffield','CA','USA','90806','3105554533','3105551233',133 )#
INSERT INTO DEMO.Contacts VALUES
    (    42,'Haddad','Paul','pd','89 Pleasant St.','Fort Frances','IL','USA','60173','7065558337','7045555644',661 )#
INSERT INTO DEMO.Contacts VALUES
    (    43,'Schott','Amy','hr','919 Remington St.','Kitchener','TX','USA','77079','7135558912','7135554565',444 )#
INSERT INTO DEMO.Contacts VALUES
    (    44,'Short','Russell','cs','412 Newton St.','Cornwall','NY','USA','02192','6175550993','6175551170',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    45,'Galvin','Liz','ma','3165 Lexington St.','London','CO','USA','02174','6175559312','6175559870',128 )#
INSERT INTO DEMO.Contacts VALUES
    (    46,'Crossland','Ellen','pd','527 Rush Rd.','Hamilton','MI','USA','01803','6175550004','6175558005',159 )#
INSERT INTO DEMO.Contacts VALUES
    (    47,'Bertrand','Coleman','do','978 Dunster Pl.','Fort Frances','IL','USA','60173','7065552886','7045554532',661 )#
INSERT INTO DEMO.Contacts VALUES
    (    48,'Rayner','Doug','ot','341 Chapin St.','Kitchener','TX','USA','77079','7135558444','7135559934',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    49,'Lull','John','sa','932 Lawn Rd.','Elora','OR','USA','01730','6175551745','6175551233',551 )#
INSERT INTO DEMO.Contacts VALUES
    (    50,'Shishov','Irina','ma','57 Park Drive','Oakville','GA','USA','30339','4045551233','4045556837',197 )#
INSERT INTO DEMO.Contacts VALUES
    (    51,'Trayers','Ken','sa','134 Heather Drive','London','CO','USA','02174','6175552384','6175554127',128 )#
INSERT INTO DEMO.Contacts VALUES
    (    52,'Long','Peter','tr','778 Grayson Rd.','Hamilton','MI','USA','01803','6175554519','6175554339',159 )#
INSERT INTO DEMO.Contacts VALUES
    (    53,'Tippet','Debbie','cs','185 Aberdeen Rd.','Fort Frances','IL','USA','60173','7065558227','7045558474',661 )#
INSERT INTO DEMO.Contacts VALUES
    (    54,'Hodson','DEMO','cs','969 Lincoln St.','Waterloo','AZ','USA','01720','5085552998','5085550022',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    55,'Kosko','Kim','pd','3234 Pleasant St.','Kitchener','TX','USA','77079','7135554657','7135552738',444 )#
INSERT INTO DEMO.Contacts VALUES
    (    56,'McEvoy','Jim','sa','323 Hawthorne Rd.','Fort Frances','IL','USA','60173','7065558532','7045550123',207 )#
INSERT INTO DEMO.Contacts VALUES
    (    57,'Goodall','Sandra','sa','756 Summer St.','Hamilton','MI','USA','01803','6175553647','6175550059',0 )#
INSERT INTO DEMO.Contacts VALUES
    (    58,'Elkins','John','tr','89 Goddard Highway','Hespeler','NJ','USA','08830','6035551200','6035550078',147 )#
INSERT INTO DEMO.Contacts VALUES
    (    59,'Masalsky','Kurt','cs','129 Garden St.','Oakville','GA','USA','30339','4045555111','4045558347',197 )#
INSERT INTO DEMO.Contacts VALUES
    (    60,'Collins','MaryBeth','cs','93 Lincoln Street','Hamilton','MI','USA','01803','6175551199','6175559586',661 )#

COMMIT#


ALTER TABLE DEMO.Contacts
        ADD CONSTRAINT FK_CustomerID_ID2
	FOREIGN KEY (CustomerID) REFERENCES DEMO.Customers (ID)#
	
ALTER TABLE DEMO.SalesOrderItems
	ADD CONSTRAINT FK_ProductID_ID
        FOREIGN KEY (ProductID) REFERENCES DEMO.Products (ID)
	ON UPDATE CASCADE
        ON DELETE CASCADE#

ALTER TABLE DEMO.SalesOrderItems
        ADD CONSTRAINT FK_ID_ID
	FOREIGN KEY (ID) REFERENCES DEMO.SalesOrders (ID)
	ON DELETE CASCADE#

ALTER TABLE DEMO.SalesOrders
        ADD CONSTRAINT FK_SalesRepresentative_EmployeeID
	FOREIGN KEY (SalesRepresentative) REFERENCES DEMO.Employees (EmployeeID)#

ALTER TABLE DEMO.SalesOrders
        ADD CONSTRAINT FK_FinancialCode_Code
	FOREIGN KEY (FinancialCode) REFERENCES DEMO.FinancialCodes (Code)
	ON DELETE SET NULL#

ALTER TABLE DEMO.SalesOrders
        ADD CONSTRAINT FK_CustomerID_ID
	FOREIGN KEY (CustomerID) REFERENCES DEMO.Customers (ID)#

ALTER TABLE DEMO.FinancialData
        ADD CONSTRAINT FK_Code_Code
	FOREIGN KEY (Code) REFERENCES DEMO.FinancialCodes (Code)
	ON DELETE CASCADE#

COMMIT#

CREATE PROCEDURE DEMO.ShowProductInfo(IN product_ID INTEGER) 
AS 
BEGIN 
    SELECT ID,Name,Description,Size,Color,Quantity,UnitPrice 
    FROM DEMO.Products 
    WHERE DEMO.Products.ID = :product_ID; 
END#

CREATE VIEW DEMO.ViewSalesOrders
(ID,LineID,ProductID,Quantity,OrderDate,ShipDate,Region,SalesRepresentativeName)
AS
    SELECT i.ID,i.LineID,i.ProductID,i.Quantity,s.OrderDate,i.ShipDate,s.Region,e.GivenName||' '||e.Surname
    FROM       DEMO.SalesOrderItems AS i
    INNER JOIN DEMO.SalesOrders AS s ON s.ID=i.ID
    INNER JOIN DEMO.Employees AS e ON s.SalesRepresentative=e.EmployeeID#

