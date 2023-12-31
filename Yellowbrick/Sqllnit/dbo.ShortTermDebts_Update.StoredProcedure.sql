﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_Update]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ShortTermDebts_Update]
    @ClientId int
    ,@LoanTypeId int
    ,@Balance decimal(16,2) = null
    ,@MonthlyPayments decimal(16,2) = null
    ,@InstitutionName nvarchar(100)
    ,@InterestRate decimal(5,3) = null
    ,@UserId int
    ,@Id int OUTPUT
AS

/* ----- Test Code -----

	DECLARE @ClientId int = 5
			,@LoanTypeId int = 5
			,@Balance decimal(16,2) = 500.00
			,@MonthlyPayments decimal(16,2) = 12.50
			,@InstitutionName nvarchar(100) = 'HappyCampers Update'
			,@InterestRate decimal(5,3) = 1.203
			,@UserId int = 1
			,@Id int = 3

	EXECUTE [dbo].[ShortTermDebts_Insert]
					@ClientId
					,@LoanTypeId
					,@Balance
					,@MonthlyPayments
					,@InstitutionName
					,@InterestRate
					,@UserId
					,@Id OUTPUT

	SELECT *
	FROM [dbo].[ShortTermDebts]
	WHERE Id = @Id


*/


BEGIN

	DECLARE @dateModified datetime2(7) = GETUTCDATE();

	UPDATE [dbo].[ShortTermDebts]
	   SET [ClientId] = @ClientId
		  ,[LoanTypeId] = @LoanTypeId
		  ,[Balance] = @Balance
		  ,[MonthlyPayments] = @MonthlyPayments
		  ,[InstitutionName] = @InstitutionName
		  ,[InterestRate] = @InterestRate
		  ,[ModifiedBy] = @UserId
		  ,[DateModified] = @dateModified
		WHERE Id = @Id
END


GO
