USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ShortTermDebts_Delete_ById]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/3/2023
-- Description: This is a proc that deletes by ID  
--				from the Short Term Debts table.
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[ShortTermDebts_Delete_ById]
		@Id int
AS

/* ----- Test Code -----

	DECLARE	@Id int = 95

	EXECUTE [dbo].[ShortTermDebts_Delete_ById] @Id	

*/


BEGIN

	DELETE FROM [dbo].[ShortTermDebts]
		  WHERE Id = @Id
END


GO
