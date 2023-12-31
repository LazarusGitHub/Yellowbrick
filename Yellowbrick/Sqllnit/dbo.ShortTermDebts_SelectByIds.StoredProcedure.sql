USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_SelectByIds]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ShortTermDebts_SelectByIds]
		@debt [dbo].[IntIdTable] READONLY


/*
	DECLARE @debt [dbo].[IntIdTable]

	INSERT INTO @debt (Data)
	VALUES (13), (11), (99999)

	--SELECT * from @debt


	EXECUTE dbo.ShortTermDebts_SelectByIds @debt


*/
AS

BEGIN


SELECT [Id]
      ,[ClientId]
      ,[LoanTypeId]
      ,[Balance]
      ,[MonthlyPayments]
      ,[InstitutionName]
      ,[InterestRate]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[DateCreated]
      ,[DateModified]
  FROM [dbo].[ShortTermDebts] as std INNER JOIN @debt as d
		ON std.ClientId = d.DATA

END
GO
