USE [YellowBrick]
GO
/****** Object:  UserDefinedTableType [dbo].[ShortTermDebtsTableType]    Script Date: 8/15/2023 2:06:45 PM ******/
CREATE TYPE [dbo].[ShortTermDebtsTableType] AS TABLE(
	[LoanTypeId] [int] NOT NULL,
	[Balance] [decimal](16, 2) NULL,
	[MonthlyPayments] [decimal](16, 2) NULL,
	[InstitutionName] [nvarchar](100) NOT NULL,
	[InterestRate] [decimal](5, 3) NULL
)
GO
