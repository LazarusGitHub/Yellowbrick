USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousing_Insert]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/3/2023
-- Description: This is a proc that inserts into 
--				the Client Housing table.
-- Code Reviewer: Raymond Medina

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[ClientHousing_Insert]
			@ClientId int
			,@IsHomeOwner bit
			,@IsRenter bit
			,@HasRentersInsurance bit
			,@RentPayment decimal(16,2) = null
			,@UserId int
			,@Id int OUTPUT
AS

/* ----- Test Code -----
	
	DECLARE @Id int = 0;

	DECLARE
			@ClientId int = 20
			,@IsHomeOwner bit = 0
			,@IsRenter bit = 0
			,@HasRentersInsurance bit = 0
			,@RentPayment decimal(16,2) = 2500.00
			,@UserId int = 1
			

	EXECUTE [dbo].[ClientHousing_Insert]

				@ClientId
			   ,@IsHomeOwner
			   ,@IsRenter
			   ,@HasRentersInsurance
			   ,@RentPayment
			   ,@UserId
			   ,@Id OUTPUT

	SELECT *
	FROM [dbo].[ClientHousing]
	WHERE Id = @Id
*/

BEGIN
	

	INSERT INTO [dbo].[ClientHousing]
			   ([ClientId]
			   ,[IsHomeOwner]
			   ,[IsRenter]
			   ,[HasRentersInsurance]
			   ,[RentPayment]
			   ,[CreatedBy]
			   ,[ModifiedBy]
			   )
		 VALUES
			   (@ClientId 
			   ,@IsHomeOwner
			   ,@IsRenter
			   ,@HasRentersInsurance
			   ,@RentPayment
			   ,@UserId
			   ,@UserId
			   )

	SET @Id = SCOPE_IDENTITY()

END


GO
