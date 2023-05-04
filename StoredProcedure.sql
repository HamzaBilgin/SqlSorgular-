-- Belirli bir işlevi veya görevi yerine getirmek için yapılandırılmış sql kod parçacıklarıdır.
--- Crud işlemler gibi her seferinde tekrar yazıp derlememiz gerekmediği için performans
----açısından kazanç sağlar Aynı java metodları gibi input parametreleri alır ve sonucunda
----- output yani çıktı verir. Derlendikten sonra tekrar derlemeye gerek kalmayıp veritabanında
------ execution plan olarak saklanır.
--Procedure oluşturma 
Create Procedure OrdersByDate
(
	@OrderBegindate DATETIME,
	@OrderEndDate Datetime,
	@ShipCity Varchar(30)
)
as
begin
select OrderID,CustomerID,OrderDate,ShippedDate,ShipName,ShipAddress from Orders
where OrderDate between @OrderBeginDate and  @OrderEndDate and ShipCity = @ShipCity
end;

--Oluşturulan Prosedürü çağırma
Exec OrdersByDate
@OrderBegindate = '1996-07-01',
@OrderEndDate = '1997-07-01',
@ShipCity = 'London';

-- Yukarıdaki procedure sayesinde begindate enddate gibi şartlar değiştikçe tekrar gidip
---yeni bir sql sorgusu yazmaya gerek kalmadı.

-- Oluşturulan procedure de değişiklik yapmak için create yerine alter yazmak ve 
---değiştirmek istediğimiz verileri değiştirmek yeterli.
Alter Procedure OrdersByDate
(
	@OrderBegindate DATETIME,
	@OrderEndDate Datetime,
	@ShipCity Varchar(30)
)
as
begin
select OrderID,CustomerID,OrderDate,ShippedDate,ShipName,ShipAddress from Orders
where OrderDate between @OrderBeginDate and  @OrderEndDate and ShipCity = @ShipCity
end;

--Oluşturulan procedure u silmek için drop yazma yeterli.
drop Procedure OrdersByDate


-- Procedure kilitlemek için şifreleme işlemine başvurular. Burdaki amaç procedurun 
---değiştirilmemesini sağlar. Dikkat edilmelidir ki bizde değiştiremeyiz bu yüzden 
--- kriptolamadan yani şifrelemeden önce bir yedeğinin alınması önemlidir.
Create Procedure OrdersByDate
(
	@OrderBegindate DATETIME,
	@OrderEndDate Datetime,
	@ShipCity Varchar(30)
)
with encryption
as
begin
select OrderID,CustomerID,OrderDate,ShippedDate,ShipName,ShipAddress from Orders
where OrderDate between @OrderBeginDate and  @OrderEndDate and ShipCity = @ShipCity
end;

-- Hadi başka örneklerle pekiştirelim 
create table Musteri
(
ID int primary key,
Isim nvarchar(30),
SoyIsim nvarchar(30),
OlusturmaTarih datetime default getdate()
)
create table MusteriGirisBilgileri
(
MID int primary key,
KullaniciAdi nvarchar(30) unique not null,
Sifre nvarchar(30) check(Len(sifre)>6), -- Şifrenin kontrolü yapıldı
foreign key(MID) references Musteri(ID) -- Burda müsteri tablosu ile bağladık.
)

--Yukaridaki iki tabloyu oluşturalım
-- Bir tane insert işlemi içeren procedure yazalım
create proc SP_Musteri_YeniKayit
(
@ID int,
@Isim nvarchar(30),
@Soyisim nvarchar(30),
@KullaniciAdi nvarchar(30),
@Sifre nvarchar(10),
)
as
begin
insert into Musteri(ID,Isim,SoyIsim) values (@ID,@Isim,@Soyisim)
	if(@@ROWCOUNT>0)
	begin
		insert into MusteriGirisBilgileri(MID,KullaniciAdi,Sifre) values (@ID,@KullaniciAdi,@Sifre)
	end
end

-- Başka bir örnek
create procedure selectAllCustomersWithMultipleParametre @City nvarchar(50),@Postalcode nvarchar(50)
as select * from Customers where City = @City and PostalCode = @Postalcode 
Go

--- Yukardaki örneğin Çağrılması
exec selectAllCustomersWithMultipleParametre @City = 'London',@PostalCode '12209'










