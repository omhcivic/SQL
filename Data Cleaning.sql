/*

Cleaning Data in SQL Queries

*/


SELECT * 
FROM NashvilleHousing 




--Standardize Date Format


SELECT SaleDate, CONVERT(Date,SaleDate) 
FROM NashvilleHousing 

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate) 


--If it doesn't Update properly


ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate) 

SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM NashvilleHousing




-- Populate Property Address Data

SELECT *
FROM NashvilleHousing 
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing  a
JOIN NashvilleHousing  b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing  a
JOIN NashvilleHousing  b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL



-- Breaking out Address into Individual Columns  (Address, CIty, State)

SELECT PropertyAddress 
FROM NashvilleHousing 


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS Address
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCIty NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCIty = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))


SELECT * 
FROM NashvilleHousing 



SELECT OwnerAddress
FROM NashvilleHousing 


SELECT
PARSENAME(Replace(OwnerAddress, ',','.') , 3),
PARSENAME(Replace(OwnerAddress, ',','.') , 2),
PARSENAME(Replace(OwnerAddress, ',','.') , 1)
FROM NashvilleHousing 

ALTER Table NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',','.') , 3)

ALTER Table NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',','.') , 2)

ALTER Table NashvilleHousing
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',','.') , 1)


SELECT * 
FROM NashvilleHousing 





--  Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM NashvilleHousing 
GROUP BY Soldasvacant 
ORDER BY 2



SELECT SoldAsVacant
,CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM NashvilleHousing 


UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END


	
--- Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UniqueID
					) row_num

FROM NashvilleHousing 
--ORDER BY ParcelID 
)

DELETE 
FROM RowNumCTE 
WHERE row_num > 1
--ORDER BY PropertyAddress 



--- Delete Unused Columns from views

SELECT * 
FROM NashvilleHousing 

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate