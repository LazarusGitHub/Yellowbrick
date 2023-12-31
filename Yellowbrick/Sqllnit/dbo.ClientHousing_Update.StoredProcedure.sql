USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousing_Update]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/4/2023
-- Description: This is a proc that updates a Client 
--				using the Client Housing table.
-- Code Reviewer: Raymond Medina

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[ClientHousing_Update]
			@ClientId int
			,@IsHomeOwner bit
			,@IsRenter bit
			,@HasRentersInsurance bit
			,@RentPayment decimal(16,2) = null
			,@UserId int
			,@Id int
AS

/* ----- Test Code -----

select * from ClientHousing
	DECLARE  @Id int = 5

			,@ClientId int = 11
			,@IsHomeOwner bit = 1
			,@IsRenter bit = 1
			,@HasRentersInsurance bit = 1
			,@RentPayment decimal(16,2) = 188700.00
			,@UserId int = 1

	EXECUTE [dbo].[ClientHousing_Update]

				@ClientId
			   ,@IsHomeOwner
			   ,@IsRenter
			   ,@HasRentersInsurance
			   ,@RentPayment
			   ,@UserId
			   ,@Id

	SELECT *
	FROM [dbo].[ClientHousing]
	WHERE Id = @Id
	
select * from ClientHousing
*/

BEGIN
	--DECLARE @dateModified datetime2(7) = GETUTCDATE();

	UPDATE [dbo].[ClientHousing]
		SET [ClientId] = @ClientId
			,[IsHomeOwner] = @IsHomeOwner
			,[IsRenter] = @IsRenter
			,[HasRentersInsurance] = @HasRentersInsurance
			,[RentPayment] = @RentPayment
			,[ModifiedBy] = @UserId			
		WHERE Id = @Id

END

select * from dbo.Users

GO
