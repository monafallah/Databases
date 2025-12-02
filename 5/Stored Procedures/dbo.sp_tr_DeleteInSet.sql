SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_DeleteInSet] 
	@Key varchar(255) = 0, 
	@Value varchar(255) = 0
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [dbo].[tr_Set] WHERE [Id] = @Key AND [Member] = @Value
	
	RETURN @@rowcount
END
GO
