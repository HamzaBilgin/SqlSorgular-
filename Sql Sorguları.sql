-- Database oluþturma
create database Ornek1

-- Database silme
drop database Ornek1

--Tablo Oluþturma
create table Personel
(
PersonelID int,
Isim nvarchar(40),
Soyisim nvarchar(40),
EmailAdres nvarchar(60)
)

--Tablo silme 
drop table Personel

--Tabloda deðiþikliik yapma ekleme ve çýkarma
----Tabloya TelefonNumarasi sütunu ekler
Alter table Personel
Add TelefonNumarasi nvarchar(12)
----Tabloya TelefonNumarasi sütunu siler
Alter table Personel
Drop column TelefonNumarasi

--Tabloya veri girme
insert into Personel (PersonelID,Isim,Soyisim,EmailAdres) values(5,'Hamza','Bilgin','bilginha16@itu.edu.tr')

-- Tabloda basitçe sorgu atmak
Select ProductId,ProductName from Products
Select LastName from Employees

-- Tabloyu deðiþkene tanýmlayýp çaðýrma
Select p.ProductName from Products p
Select e.LastName from Employees e

-- Tabloda update iþlemi yapma - Veriyi güncellemeyi saðlar
update Personel set
Soyisim='Bilgin',
Isim='Hamza',
EmailAdres='update@gmail.com'
where
PersonelID=5

-- Tabloda delete iþlemi - veriyi silmeyi saðlar
delete Personel where PersonelID=2

-- Tabloda verileri çekerken kolon isimlerini deðiþtirme
select CompanyName as [Sirket Adi],City as Sehir from Customers

--And kullanýmý - Veriyi iki veya daha fazla þarta göre çaðýrmak için kullanýlýr
select * from Products where SupplierID = 1 and CategoryID=1

-- Max ve Min kullanýmý. Tablodaki stunlardaki en yüksek ve en düþük deðeri bulmak için kullanýlýr
select max(SupplierID) as [En yüksek ID] from Products

--Sql view olarak kaydetme - Sorgu ile çaðrýlan tablo sorgu ile geldiðinden kayýt olmaz,
---bunu istersek views olarak kaydedebiliriz. Bunu daha sonra üzerinde tekrar
----oynamak için yaparýz. Tekrar ayný tabloyu sorgu ile çaðýrmak yerine kaydedilen tabloyu kullanýrýz.
create view [Mexico Customers] as
select ContactName from Customers where Country = 'Mexico'

--Distinct kullanýmý - Distinct yapýlan sorgudaki sütunlardaki benzer öðeleri tekrar ---yazdýrmaz.Örneðin örnekteki gibi normalde birden çýk olan Brazil sorgu ile tek bir ----tane gözükür. Analiz yaparken iþe yarar
select distinct Country from Customers

-- Gruop by kullanýmý - Distinct ile ayný iþleve sahip. Sadece kümülatif yani toplama ---gibi iþlemlerde group by sorgu süresini kýsaltýp daha verimli sorgu yapar.
Select Country,Count(*) Adet From Customers group by Country

-- Constrain kullanýmý - Tablolar oluþtururken belli kýsýtlandýrmalar konulabilir bilir. Bu kýsýtlandýrmalara
---Constraint denir. Aþaðýda kullanýlan contraintler ve açýklamalar mevcuttur.
create table constrainOrnek
(
kolon1 int not null,  -- Bir sütunun null bir deðer almamasýný saðlar
kolon2 int unique, -- Bu sütundaki bütün deðerler birbirinden farklý olmasýný saðlar
kolon3 int primary key, -- not null ve unique in birleþimi gibidir
kolon4 int foreign key references Customers(CustomersID),
kolon5 int check ( kolon5<18), -- koþulu kontrol edip ona göre deðer almasýný saðlar
kolon6 varchar default 3 -- Hiçbir koþul girilmediðinde otomatik olarak bu deðerin atanmasýný saðlar
)

-- Count kullanýmý - Bize istediðimiz sorguya ait kaç veri olduðunu gösterir
select count(*) from Products where CategoryID=1

-- AVG kullanýmý - Bize istediðimiz sorguda ortalama deðer çýkarýr. Örneðin
--- Ürünlerinizin ortalama birim fiyatýný öðrenmek için kullanýlabillir
select AVG(UnitPrice) from Products

-- Top kullanýmý - Bize yapacýðýmýz sorguda örneðin ilk 10 veriyi getirmemizi saðlar
select top 10 * from Products

-- Sum kullanýmý - Bize örneðin stoktaki ürün adeti ve birim fiyatlarýnýn çarpýmým
---sonucu getirebilmemizi saðlar
select sum(UnitPrice*UnitsInStock) from Products

-- Having kullanýmý - Aggregate functionlarda where kullanýlmaz. Yani toplama sayma gibi
--- iþlemlerde kullanýlmaz. Bunun için having metodu getirilmiþtir ve aslýnda hep ---- group by ile kullanýlýr.
Select Country,City,Count(*) Adet From Customers group by Country,City having Count(*)>1 order by Country  

-- Ýki deðeri çarparak tek sütunda getirme
Select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p

--Ýki deðeri birleþtirerek tek sütunda getirme
Select p.ProductName + '+' + p.QuantityPerUnit as birlestir from Products p

--Þartlý Sorgu koyarak tablo getirme
Select * from Products Where CategoryID = 1
Select * from Products Where UnitsInStock>=10
Select * from Products Where UnitsInStock=10+7
Select * from Products Where CategoryID=3 and UnitsOnOrder>0
Select * from Products Where CategoryID=1 or UnitsOnOrder=0
Select * from Products Where ProductName = 'Chai'

-- Çaðrýlan tablonun belli bir sütuna göre alfabetik veya sayýsal olarak sýralanmasý
Select * from Employees order by FirstName
Select * from Orders order by CustomerID
Select * from Products order by UnitPrice desc --terse çevirir

----order by dan sonra yazýlma sýrasýna göre sýralama
Select * from Products order by UnitPrice,ProductName 
Select * from Employees order by FirstName,Title

--Like kullanýmý , sorgulama þartýnda içerikte belli koþul arama
Select * from Products where ProductName like 'ch%' --- ch ile baþlayan tüm verileri bulur
Select * from Products where ProductName like '%a'  --- a ile bütün verileri bulur
Select * from Products where ProductName like '%ch%' --- Hanhangi bir konumda ch bulunan verileri bulur
Select * from Products where ProductName like '_u%' --  iki konumda u bulunan tüm verileri bulur
Select * from Products where ProductName like 'a_%' -- a ile baþlýyan ve en az 2 karakter içeren verileri bulur
Select * from Products where ProductName like 'a__%' -- a ile baþlýyan ve en az 3 karakter içeren verileri bulur
Select * from Products where ProductName like 'a%n' --a ile baþlayýp u ile biten bütün verileri bulur

--BETWEEN kullanýmý
Select * from Products where UnitPrice between 10 and 50 order by UnitPrice --10 ve 50 dahil

-- In kullanýmý
Select * from Products where CategoryID in (1,2) //1 veya 2 olanlar geliyor

--------------------   JOÝN KULLANIMLARI    ---------------------
--Join kullanýmý - iki tablonun eþit olduðu veriler baz alýnarak birleþtirmesini yapar
Select * from Products inner join Categories on Products.CategoryID = Categories.CategoryID

--- 3 tabloda ayný anda birleþtirme yapýlabilir. Aþaðýdaki Products ile Order Details tablosundaki
---- ortak olan ProductID ile eþleþtirilmiþ sonra da Order Details ile Orders tablolarýndaki ortak 
----- olan OrderID eþleþtirilip tek tablo haline getirilmiþtir.
Select p.ProductName,o.OrderDate,od.Quantity * od.UnitPrice as TOTAL from Products p 
inner join [Order Details] od on p.ProductID=od.ProductID 
inner join Orders o on o.OrderID=od.OrderID

-- Left Join Kullanýmý - Leftjoin kullanýrken unutlmamasý gereken nokta. Sað tarafa eklediðimiz --- tabloda sol taraftan eþleþmeyen bir yer varsa null deðer vermesidir.
Select c.Address,c.Country,o.ShipRegion from Customers c left join Orders o
on c.CustomerId = o.CustomerID

-- Right join kullanýmý 
Select c.Address,c.Country,o.ShipRegion from Orders o right join Customers c
on c.CustomerId = o.CustomerID


