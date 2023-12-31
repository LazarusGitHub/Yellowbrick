USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[LoanTypes_SelectAll]    Script Date: 8/15/2023 2:06:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================
-- Author: Lazarus Wright
-- Create date: 6/30/2023
-- Description: This is the Loan Type Look up table.
-- Code Reviewer:	Raymond Medina

-- MODIFIED BY: author
-- MODIFIED DATE: 7/3/2023
-- Code Reviewer:
-- Note:
-- =================================================

CREATE PROC [dbo].[LoanTypes_SelectAll]

AS

/* ----- Test Code -----

	EXECUTE [dbo].[LoanTypes_SelectAll]

*/

BEGIN

	SELECT [Id]
		  ,[Name]
	  FROM [dbo].[LoanTypes]

END


GO
