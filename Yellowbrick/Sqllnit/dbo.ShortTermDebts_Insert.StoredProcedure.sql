USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_Insert]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/21/2023
-- Description: This is a proc that inserts into 
--				the Short Term Debts table.
-- Code Reviewer: Elijah Branscum

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[ShortTermDebts_Insert]
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

	DECLARE @ClientId int = 7
			,@LoanTypeId int = 5
			,@Balance decimal(16,2) = 500.00
			,@MonthlyPayments decimal(16,2) = 10.50
			,@InstitutionName nvarchar(100) = 'TakersInc New'
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
	INSERT INTO [dbo].[ShortTermDebts]
						([ClientId]
						,[LoanTypeId]
						,[Balance] 
						,[MonthlyPayments]
						,[InterestRate]
						,[CreatedBy]
						,[ModifiedBy])
     VALUES
           (@ClientId
           ,@LoanTypeId
           ,@Balance
           ,@MonthlyPayments
        ,@InterestRate
           ,@UserId
		   ,@UserId
           )

	SET @Id = SCOPE_IDENTITY()

END


GO
