SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_ClearAll] 
AS
BEGIN
	DELETE [dbo].[tr_Set]
	DELETE [dbo].[tr_Object]
	DELETE [dbo].[tr_String]
END
GO
