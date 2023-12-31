USE [YellowBrick]
GO
/****** Object:  Table [dbo].[ShortTermDebts]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShortTermDebts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[LoanTypeId] [int] NOT NULL,
	[Balance] [decimal](16, 2) NULL,
	[MonthlyPayments] [decimal](16, 2) NULL,
	[InstitutionName] [nvarchar](100) NOT NULL,
	[InterestRate] [decimal](5, 3) NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ShortTermDebts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ShortTermDebts] ADD  CONSTRAINT [DF_ShortTermDebts_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ShortTermDebts] ADD  CONSTRAINT [DF_ShortTermDebts_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ShortTermDebts]  WITH CHECK ADD  CONSTRAINT [FK_ShortTermDebts_Clients] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[ShortTermDebts] CHECK CONSTRAINT [FK_ShortTermDebts_Clients]
GO
ALTER TABLE [dbo].[ShortTermDebts]  WITH CHECK ADD  CONSTRAINT [FK_ShortTermDebts_LoanTypes] FOREIGN KEY([LoanTypeId])
REFERENCES [dbo].[LoanTypes] ([Id])
GO
ALTER TABLE [dbo].[ShortTermDebts] CHECK CONSTRAINT [FK_ShortTermDebts_LoanTypes]
GO
