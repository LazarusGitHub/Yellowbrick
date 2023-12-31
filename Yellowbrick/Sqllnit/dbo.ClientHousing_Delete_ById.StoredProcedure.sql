USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousing_Delete_ById]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Lazarus Wright
-- Create date: 7/4/2023
-- Description: This proc deletes a record by Id,
--				from the Client Housing table.
-- Code Reviewer:	Raymond Medina

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
CREATE PROC [dbo].[ClientHousing_Delete_ById]
	@Id int

AS

/* ----- Test Code -----

	DECLARE @Id int = 21

	EXECUTE [dbo].[ClientHousing_Delete_ById] @Id

*/

BEGIN

	DELETE FROM [dbo].[ClientHousing]
		  WHERE Id = @Id

END


GO
