SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_tr_AddInSet] 
	@Key varchar(255) = 0, 
	@Value varchar(255) = 0
AS
BEGIN
	SET NOCOUNT ON;

	MERGE [dbo].[tr_Set] AS T 
	USING (SELECT @Key as [Id], @Value as [Member]) AS S 
		ON (T.Id = S.Id AND T.Member = S.Member) 
	WHEN NOT MATCHED BY TARGET THEN 
		INSERT(Id, Member) VALUES(S.Id, S.Member);
END
GO
