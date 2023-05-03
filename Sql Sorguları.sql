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

