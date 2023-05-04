-- Database olu�turma
create database Ornek1

-- Database silme
drop database Ornek1

--Tablo Olu�turma
create table Personel
(
PersonelID int,
Isim nvarchar(40),
Soyisim nvarchar(40),
EmailAdres nvarchar(60)
)

--Tablo silme 
drop table Personel

--Tabloda de�i�ikliik yapma ekleme ve ��karma
----Tabloya TelefonNumarasi s�tunu ekler
Alter table Personel
Add TelefonNumarasi nvarchar(12)
----Tabloya TelefonNumarasi s�tunu siler
Alter table Personel
Drop column TelefonNumarasi

--Tabloya veri girme
insert into Personel (PersonelID,Isim,Soyisim,EmailAdres) values(5,'Hamza','Bilgin','bilginha16@itu.edu.tr')

-- Tabloda basit�e sorgu atmak
Select ProductId,ProductName from Products
Select LastName from Employees

-- Tabloyu de�i�kene tan�mlay�p �a��rma
Select p.ProductName from Products p
Select e.LastName from Employees e

-- Tabloda update i�lemi yapma - Veriyi g�ncellemeyi sa�lar
update Personel set
Soyisim='Bilgin',
Isim='Hamza',
EmailAdres='update@gmail.com'
where
PersonelID=5

-- Tabloda delete i�lemi - veriyi silmeyi sa�lar
delete Personel where PersonelID=2

-- Tabloda verileri �ekerken kolon isimlerini de�i�tirme
select CompanyName as [Sirket Adi],City as Sehir from Customers

--And kullan�m� - Veriyi iki veya daha fazla �arta g�re �a��rmak i�in kullan�l�r
select * from Products where SupplierID = 1 and CategoryID=1

-- Max ve Min kullan�m�. Tablodaki stunlardaki en y�ksek ve en d���k de�eri bulmak i�in kullan�l�r
select max(SupplierID) as [En y�ksek ID] from Products

--Sql view olarak kaydetme - Sorgu ile �a�r�lan tablo sorgu ile geldi�inden kay�t olmaz,
---bunu istersek views olarak kaydedebiliriz. Bunu daha sonra �zerinde tekrar
----oynamak i�in yapar�z. Tekrar ayn� tabloyu sorgu ile �a��rmak yerine kaydedilen tabloyu kullan�r�z.
create view [Mexico Customers] as
select ContactName from Customers where Country = 'Mexico'

--Distinct kullan�m� - Distinct yap�lan sorgudaki s�tunlardaki benzer ��eleri tekrar ---yazd�rmaz.�rne�in �rnekteki gibi normalde birden ��k olan Brazil sorgu ile tek bir ----tane g�z�k�r. Analiz yaparken i�e yarar
select distinct Country from Customers

-- Gruop by kullan�m� - Distinct ile ayn� i�leve sahip. Sadece k�m�latif yani toplama ---gibi i�lemlerde group by sorgu s�resini k�salt�p daha verimli sorgu yapar.
Select Country,Count(*) Adet From Customers group by Country

-- Constrain kullan�m� - Tablolar olu�tururken belli k�s�tland�rmalar konulabilir bilir. Bu k�s�tland�rmalara
---Constraint denir. A�a��da kullan�lan contraintler ve a��klamalar mevcuttur.
create table constrainOrnek
(
kolon1 int not null,  -- Bir s�tunun null bir de�er almamas�n� sa�lar
kolon2 int unique, -- Bu s�tundaki b�t�n de�erler birbirinden farkl� olmas�n� sa�lar
kolon3 int primary key, -- not null ve unique in birle�imi gibidir
kolon4 int foreign key references Customers(CustomersID),
kolon5 int check ( kolon5<18), -- ko�ulu kontrol edip ona g�re de�er almas�n� sa�lar
kolon6 varchar default 3 -- Hi�bir ko�ul girilmedi�inde otomatik olarak bu de�erin atanmas�n� sa�lar
)

-- Count kullan�m� - Bize istedi�imiz sorguya ait ka� veri oldu�unu g�sterir
select count(*) from Products where CategoryID=1

-- AVG kullan�m� - Bize istedi�imiz sorguda ortalama de�er ��kar�r. �rne�in
--- �r�nlerinizin ortalama birim fiyat�n� ��renmek i�in kullan�labillir
select AVG(UnitPrice) from Products

-- Top kullan�m� - Bize yapac���m�z sorguda �rne�in ilk 10 veriyi getirmemizi sa�lar
select top 10 * from Products

-- Sum kullan�m� - Bize �rne�in stoktaki �r�n adeti ve birim fiyatlar�n�n �arp�m�m
---sonucu getirebilmemizi sa�lar
select sum(UnitPrice*UnitsInStock) from Products

-- Having kullan�m� - Aggregate functionlarda where kullan�lmaz. Yani toplama sayma gibi
--- i�lemlerde kullan�lmaz. Bunun i�in having metodu getirilmi�tir ve asl�nda hep ---- group by ile kullan�l�r.
Select Country,City,Count(*) Adet From Customers group by Country,City having Count(*)>1 order by Country  

-- �ki de�eri �arparak tek s�tunda getirme
Select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p

--�ki de�eri birle�tirerek tek s�tunda getirme
Select p.ProductName + '+' + p.QuantityPerUnit as birlestir from Products p

--�artl� Sorgu koyarak tablo getirme
Select * from Products Where CategoryID = 1
Select * from Products Where UnitsInStock>=10
Select * from Products Where UnitsInStock=10+7
Select * from Products Where CategoryID=3 and UnitsOnOrder>0
Select * from Products Where CategoryID=1 or UnitsOnOrder=0
Select * from Products Where ProductName = 'Chai'

-- �a�r�lan tablonun belli bir s�tuna g�re alfabetik veya say�sal olarak s�ralanmas�
Select * from Employees order by FirstName
Select * from Orders order by CustomerID
Select * from Products order by UnitPrice desc --terse �evirir

----order by dan sonra yaz�lma s�ras�na g�re s�ralama
Select * from Products order by UnitPrice,ProductName 
Select * from Employees order by FirstName,Title

--Like kullan�m� , sorgulama �art�nda i�erikte belli ko�ul arama
Select * from Products where ProductName like 'ch%' --- ch ile ba�layan t�m verileri bulur
Select * from Products where ProductName like '%a'  --- a ile b�t�n verileri bulur
Select * from Products where ProductName like '%ch%' --- Hanhangi bir konumda ch bulunan verileri bulur
Select * from Products where ProductName like '_u%' --  iki konumda u bulunan t�m verileri bulur
Select * from Products where ProductName like 'a_%' -- a ile ba�l�yan ve en az 2 karakter i�eren verileri bulur
Select * from Products where ProductName like 'a__%' -- a ile ba�l�yan ve en az 3 karakter i�eren verileri bulur
Select * from Products where ProductName like 'a%n' --a ile ba�lay�p u ile biten b�t�n verileri bulur

--BETWEEN kullan�m�
Select * from Products where UnitPrice between 10 and 50 order by UnitPrice --10 ve 50 dahil

-- In kullan�m�
Select * from Products where CategoryID in (1,2) //1 veya 2 olanlar geliyor

--------------------   JO�N KULLANIMLARI    ---------------------
--Join kullan�m� - iki tablonun e�it oldu�u veriler baz al�narak birle�tirmesini yapar
Select * from Products inner join Categories on Products.CategoryID = Categories.CategoryID

--- 3 tabloda ayn� anda birle�tirme yap�labilir. A�a��daki Products ile Order Details tablosundaki
---- ortak olan ProductID ile e�le�tirilmi� sonra da Order Details ile Orders tablolar�ndaki ortak 
----- olan OrderID e�le�tirilip tek tablo haline getirilmi�tir.
Select p.ProductName,o.OrderDate,od.Quantity * od.UnitPrice as TOTAL from Products p 
inner join [Order Details] od on p.ProductID=od.ProductID 
inner join Orders o on o.OrderID=od.OrderID

-- Left Join Kullan�m� - Leftjoin kullan�rken unutlmamas� gereken nokta. Sa� tarafa ekledi�imiz --- tabloda sol taraftan e�le�meyen bir yer varsa null de�er vermesidir.
Select c.Address,c.Country,o.ShipRegion from Customers c left join Orders o
on c.CustomerId = o.CustomerID

-- Right join kullan�m� 
Select c.Address,c.Country,o.ShipRegion from Orders o right join Customers c
on c.CustomerId = o.CustomerID


