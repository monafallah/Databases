SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_DeleteLike] 
	@Key varchar(255) = 0
AS
BEGIN
	SET NOCOUNT ON;

	DELETE 
	FROM [dbo].[tr_String] 
	WHERE [Id] LIKE @Key + '%'
	
	DELETE 
	FROM [dbo].[tr_Object] 
	WHERE [Id] LIKE @Key + '%'

	DELETE 
	FROM [dbo].[tr_Set] 
	WHERE [Id] LIKE @Key + '%'
END
GO
