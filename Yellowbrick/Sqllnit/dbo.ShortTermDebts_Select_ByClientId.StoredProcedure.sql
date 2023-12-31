USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_Select_ByClientId]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/3/2023
-- Description: This is a proc that selects Client by Id
--				from the Short Term Debts table.
-- Code Reviewer: Raymond Medina

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
CREATE PROC [dbo].[ShortTermDebts_Select_ByClientId]
			@ClientId int
AS

/* ----- Test Code -----

	DECLARE @ClientId int = 6
	EXECUTE [dbo].[ShortTermDebts_Select_ByClientId] @ClientId


	SELECT *
	FROM dbo.ShortTermDebts
	SELECT *
	From dbo.Clients
	select *
	from users

	
*/

BEGIN
	
	SELECT 
			std.Id
			,c.Id AS ClientId
			,c.FirstName AS ClientFName
			,c.LastName AS ClientLName
			,c.Mi
			,Lt.Id
			,lt.[Name]
			,std.Balance
			,std.MonthlyPayments
			,std.InstitutionName
			,std.InterestRate
			,u.Id AS CreatedByUser
			,u.FirstName AS UserFName
			,u.LastName AS UserLName
			,u.Mi
			,u.AvatarUrl
			,std.DateCreated
			,std.DateModified
	  FROM [dbo].[ShortTermDebts] AS std
				JOIN dbo.clients AS c
					ON std.ClientId = c.Id
				JOIN dbo.Users AS u
					ON std.CreatedBy = u.Id
				JOIN dbo.LoanTypes AS lt
					ON std.LoanTypeId = lt.Id
			WHERE std.ClientId = @ClientId

END


GO
