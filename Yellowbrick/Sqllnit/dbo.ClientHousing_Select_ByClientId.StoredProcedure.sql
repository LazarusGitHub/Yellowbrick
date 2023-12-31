USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousing_Select_ByClientId]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousing_Select_ByClientId]

		@ClientId INT

-- =============================================
-- Author: WENDY, RUIZ
-- Create date: 3 JULY 2023
-- Description: MORTGAGE_INSERT
-- Code Reviewer:Harrison Cook

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
/*
DECLARE @ClientId int = 5
Execute [dbo].[ClientHousing_Select_ByClientId] @ClientId
*/
AS

BEGIN
		
SELECT	 CH.Id
		,C.Id AS ClientId
		,C.FirstName
		,C.LastName
		,C.Mi
		,CH.IsHomeOwner
		,CH.IsRenter
		,CH.HasRentersInsurance
		,CH.RentPayment
		,Mortgages = ( SELECT			 M.Id
										,PT.Id AS 'PropertyType.Id'
										,PT.Name AS 'PropertyType.Name'
										,MLT.Id AS 'MortgageLoanType.Id'
										,MLT.Name AS 'MortgageLoanType.Name'
										,HLT.Id AS 'HomeLoanType.Id'
										,HLT.Name AS 'HomeLoanType.Name'
										,M.TermInYears
										,M.MonthlyPayment
										,M.Balance
										,M.InterestRate
										,M.InstitutionName
										,M.PropertyValue 
										,U.Id AS 'CreatedBy.Id'
										,U.FirstName AS 'CreatedBy.FirstName'
										,U.LastName AS 'CreatedBy.LastName'
										,U.Mi AS 'CreatedBy.Mi'
										,U.AvatarUrl AS 'CreatedBy.AvatarUrl'
										,M.DateCreated
										,M.ModifiedBy
										,M.DateModified

						FROM		    [DBO].[Mortgages]				 AS M 
										JOIN [DBO].[PropertyTypes]		 AS PT		ON	M.PropertyTypeId = PT.Id
										JOIN [DBO].[MortgageLoanTypes]	 AS MLT		ON	M.MortgageLoanTypeId = MLT.Id
										JOIN [DBO].[HomeLoanTypes]		 AS HLT		ON  M.HomeLoanTypeId = HLT.Id
										JOIN [DBO].[Users]				 AS U		ON  M.CreatedBy = U.Id
						   	
						 WHERE			M.ClientId = @ClientId
						 FOR JSON PATH)

		,CH.CreatedBy
		,U.FirstName AS CreatedBy_FirstName
		,U.LastName AS CreatedBy_LastName
		,U.Mi AS CreatedBy_Mi
		,U.AvatarUrl AS CreatedBy_AvatarUrl
		,CH.ModifiedBy
		,CH.DateCreated
		,CH.DateModified
		
FROM	[DBO].[ClientHousing] AS CH INNER JOIN [dbo].[Clients] AS C
ON		CH.ClientId=C.Id
INNER JOIN [dbo].[Users] AS U
ON		CH.CreatedBy = U.Id
WHERE	CH.ClientId = @ClientId
END

--select * from ClientHousing

--select * from Users where id=6
GO
