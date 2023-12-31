USE [YellowBrick]
GO
/****** Object:  Table [dbo].[ClientHousing]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientHousing](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[IsHomeOwner] [bit] NOT NULL,
	[IsRenter] [bit] NOT NULL,
	[HasRentersInsurance] [bit] NOT NULL,
	[RentPayment] [decimal](16, 2) NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ClientHousing] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientHousing] ADD  CONSTRAINT [DF_ClientHousing_IsHomeOwner]  DEFAULT ((0)) FOR [IsHomeOwner]
GO
ALTER TABLE [dbo].[ClientHousing] ADD  CONSTRAINT [DF_ClientHousing_IsRenter]  DEFAULT ((0)) FOR [IsRenter]
GO
ALTER TABLE [dbo].[ClientHousing] ADD  CONSTRAINT [DF_ClientHousing_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ClientHousing] ADD  CONSTRAINT [DF_ClientHousing_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ClientHousing]  WITH CHECK ADD  CONSTRAINT [FK_ClientHousing_Clients] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[ClientHousing] CHECK CONSTRAINT [FK_ClientHousing_Clients]
GO
ALTER TABLE [dbo].[ClientHousing]  WITH CHECK ADD  CONSTRAINT [FK_ClientHousing_Users2] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ClientHousing] CHECK CONSTRAINT [FK_ClientHousing_Users2]
GO
ALTER TABLE [dbo].[ClientHousing]  WITH CHECK ADD  CONSTRAINT [FK_ClientHousing_Users3] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ClientHousing] CHECK CONSTRAINT [FK_ClientHousing_Users3]
GO
