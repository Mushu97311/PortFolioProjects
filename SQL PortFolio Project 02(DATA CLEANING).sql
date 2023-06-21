

--Cleaning data in SQL Queries
 
 select *
 from PortfolioProject..NashvilleHousing

 --______________________________________________________________________________________

 --Standardize date format

  select SaleDateConverted
 from PortfolioProject..NashvilleHousing

 alter table Nashvillehousing
 add SaleDateConverted date;

 update NashvilleHousing
 set SaleDateConverted = convert(date,saledate)

 -----------------------------------------------------------------------------------------

 --Populate Property Address date

  select *
 from PortfolioProject..NashvilleHousing
 --where PropertyAddress is null
 order by ParcelID

 select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
 from PortfolioProject..NashvilleHousing a
 join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
 join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-------------------------------------------------------------------------------------------------

---breaking out address into individual columns (address,city,state)

select PortfolioProject..NashvilleHousing.PropertyAddress
from PortfolioProject..NashvilleHousing

select 
SUBSTRING(propertyaddress, 1, charindex(',',propertyaddress) -1) as address,
SUBSTRING(propertyaddress,  charindex(',',PropertyAddress) +1, len(PropertyAddress)) as address
from PortfolioProject..NashvilleHousing

alter table portfolioProject..NashvilleHousing
add propertsplitaddress varchar(200);

update PortfolioProject..NashvilleHousing
set propertsplitaddress = SUBSTRING(propertyaddress, 1, charindex(',',propertyaddress) -1) 

alter table portfolioProject..NashvilleHousing
add propertsplitcity varchar(200);

update PortfolioProject..NashvilleHousing
set propertsplitcity = SUBSTRING(propertyaddress,  charindex(',',PropertyAddress) +1, len(PropertyAddress))

-----------------------------or------------------------------------------------------------------------------------------

select PortfolioProject..NashvilleHousing.OwnerAddress
from PortfolioProject..NashvilleHousing

select
PARSENAME(replace(owneraddress,',','.'), 3),
PARSENAME(replace(owneraddress,',','.'), 2),
PARSENAME(replace(owneraddress,',','.'), 1)
from PortfolioProject..NashvilleHousing

alter table PortfolioProject..NashvilleHousing
add ownersplitaddress varchar(200);

update PortfolioProject..NashvilleHousing
set ownersplitaddress = PARSENAME(replace(owneraddress,',','.'), 3)

alter table PortfolioProject..NashvilleHousing
add ownersplitcity varchar(200);

update PortfolioProject..NashvilleHousing
set ownersplitcity = PARSENAME(replace(owneraddress,',','.'), 2)

alter table PortfolioProject..NashvilleHousing
add ownersplitstate varchar(200);

update PortfolioProject..NashvilleHousing
set ownersplitstate = PARSENAME(replace(owneraddress,',','.'), 1)

------------------------------------------------------------------------------------------------------------

--change Y and N to YES and NO in "sold as vaccant" field

select distinct(soldasvacant), count(soldasvacant)
from PortfolioProject..NashvilleHousing
group by SoldAsVacant
order by 2

select 
case
	when soldasvacant = 'y' then 'yes'
	when soldasvacant = 'n' then 'no'
	else soldasvacant
end
from  PortfolioProject..NashvilleHousing

update PortfolioProject..NashvilleHousing
set SoldAsVacant  = case
	when soldasvacant = 'y' then 'yes'
	when soldasvacant = 'n' then 'no'
	else soldasvacant
end
from  PortfolioProject..NashvilleHousing

-----------------------------------------------------------------------------------------------------------

--Remove Duplicates


with RowNumCTE as (
select *,
	ROW_NUMBER() over ( 
		partition by parcelid,
					 propertyaddress,
					 saleprice,
					 legalreference
					 order by uniqueid
					 ) row_num
from PortfolioProject..NashvilleHousing
)
select *
from RowNumCTE 
where row_num > 1
order by propertyaddress

--------------------------------------------------------------------------------------------------------------------

--delete unusedbcolumns

select *
from PortfolioProject..NashvilleHousing

alter table PortfolioProject..NashvilleHousing
drop column taxDistrict, address, landuse

alter table PortfolioProject..NashvilleHousing
drop column saledate




















