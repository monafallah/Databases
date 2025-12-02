SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_SetString] 
	@Key varchar(255) = 0, 
	@Value nvarchar(4000) = 0
AS
BEGIN
	SET NOCOUNT ON;

	MERGE [dbo].[tr_String] AS T 
	USING (SELECT @Key as Id, @Value as Value) AS S 
		ON (T.Id = S.Id) 
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT(Id, Value) VALUES(S.Id, S.Value) 
	WHEN MATCHED THEN 
		UPDATE SET T.Value = S.Value;
END
GO
