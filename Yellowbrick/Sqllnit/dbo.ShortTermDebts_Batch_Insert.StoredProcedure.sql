USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_Batch_Insert]    Script Date: 8/15/2023 2:06:45 PM ******/
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

CREATE PROC [dbo].[ShortTermDebts_Batch_Insert]
    @batchDebts dbo.ShortTermDebtsTableType READONLY
    ,@clientId int
    ,@Id int

AS

/* ----- Test Code -----

		DECLARE @newBatchDebts dbo.ShortTermDebtsTableType;
		DECLARE @clientId int = 6
		DECLARE @Id int = 64
		
		INSERT INTO @newBatchDebts (
				
				LoanTypeId
				,Balance
				,MonthlyPayments
				,InstitutionName
				,InterestRate
			)
		VALUES (1 ,100.00 ,10.00 ,'testBatch-1', 1.123),
		(1, 200.00, 20.00, 'testBatch-2', 2.246 )

		EXECUTE dbo.ShortTermDebts_Batch_Insert
							@newBatchDebts
							, @clientId
							, @Id
		
		SELECT *
		FROM dbo.ShortTermDebts
		

*/
BEGIN
    INSERT INTO ShortTermDebts (
            ClientId
			,LoanTypeId
            ,Balance
            ,MonthlyPayments
            ,InstitutionName
            ,InterestRate
            ,CreatedBy
            ,ModifiedBy 
    )

    SELECT 
             @clientId
			 ,bd.LoanTypeId
            ,bd.Balance
            ,bd.MonthlyPayments
            ,bd.InstitutionName
            ,bd.InterestRate
            ,@Id
            ,@Id
			        
    FROM @batchDebts as bd

 
END

GO
