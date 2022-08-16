

--Cleaning Data in SQL Queries

select *
from [project 4]..housing_details

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

select  saledate, CONVERT(date,saledate) as Sale_Date
from [project 4]..housing_details

update [project 4]..housing_details
set saledate = CONVERT(date,saledate)


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

select  a.ParcelID,a.PropertyAddress,  b.ParcelID ,b.PropertyAddress , ISNULL(a.PropertyAddress,b.PropertyAddress) as Property_Address
from [project 4]..housing_details a
join [project 4]..housing_details b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ] 
  where a.PropertyAddress is null


  update a
  set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
  from [project 4]..housing_details a
join [project 4]..housing_details b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ] 
  where a.PropertyAddress is null

 
--------------------------------------------------------------------------------------------------------------------------

-- Breaking out PropertyAddress into Individual Columns (Address, City, State)


select *
from [project 4]..housing_details



select PropertyAddress
from [project 4]..housing_details

select 
 PARSENAME (REPLACE(PropertyAddress,',','.'),1),
 PARSENAME (REPLACE(PropertyAddress,',','.'),2)
 from [project 4]..housing_details

alter table [project 4]..housing_details
add street_propertyaddress Nvarchar(255);

update [project 4]..housing_details
set street_propertyaddress = PARSENAME (REPLACE(PropertyAddress,',','.'),2)


alter table [project 4]..housing_details
add city_propertyaddress Nvarchar(255);

update [project 4]..housing_details
set city_propertyaddress = PARSENAME (REPLACE(PropertyAddress,',','.'),1)



select *
from [project 4]..housing_details


 
--------------------------------------------------------------------------------------------------------------------------
-- Breaking out PropertyAddress into Individual Columns (Address, City, State)




select OwnerAddress
from [project 4]..housing_details

select 
 PARSENAME (REPLACE(OwnerAddress,',','.'),1),
 PARSENAME (REPLACE(OwnerAddress,',','.'),2),
 PARSENAME (REPLACE(OwnerAddress,',','.'),3)
 from [project 4]..housing_details

alter table [project 4]..housing_details
add street_OwnerAddress Nvarchar(255);

update [project 4]..housing_details
set street_OwnerAddress = PARSENAME (REPLACE(OwnerAddress,',','.'),3)


alter table [project 4]..housing_details
add city_OwnerAddress Nvarchar(255);

update [project 4]..housing_details
set city_OwnerAddress= PARSENAME (REPLACE(OwnerAddress,',','.'),2)

alter table [project 4]..housing_details
add state_OwnerAddress Nvarchar(255);

update [project 4]..housing_details
set state_OwnerAddress= PARSENAME (REPLACE(OwnerAddress,',','.'),1)


select *
from [project 4]..housing_details


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field



select SoldAsVacant,
case when SoldAsVacant ='y' then 'yes'
	 when SoldAsVacant ='n' then 'no'
	 else SoldAsVacant 
	 end
from [project 4]..housing_details

update [project 4]..housing_details
set SoldAsVacant = case when SoldAsVacant ='y' then 'yes'
	 when SoldAsVacant ='n' then 'no'
	 else SoldAsVacant 
	 end


select distinct(SoldAsVacant) , count(SoldAsVacant)
from [project 4]..housing_details
group by SoldAsVacant
order by 2 desc




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


select *
from [project 4]..housing_details




alter table [project 4]..housing_details
drop column  TaxDistrict












