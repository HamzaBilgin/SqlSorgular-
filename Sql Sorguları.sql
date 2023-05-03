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

