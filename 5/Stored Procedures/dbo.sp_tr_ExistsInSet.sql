SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_ExistsInSet] 
	@Key varchar(255) = 0, 
	@Value varchar(255) = 0
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT 1 FROM [dbo].[tr_Set] WHERE [Id] = @Key AND [Member] = @Value)
		RETURN 1
	ELSE
		RETURN 0
END
GO
