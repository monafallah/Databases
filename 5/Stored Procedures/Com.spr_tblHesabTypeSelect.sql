SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblHesabTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId] ,[fldTitle] ,[fldType]
	FROM   [Com].[tblHesabType] 
	WHERE  fldId = @Value

	if (@fieldname=N'hoghoogh')
	SELECT [fldId] ,[fldTitle] ,[fldType]
	FROM   [Com].[tblHesabType] 
	WHERE  fldType = 2



	if (@fieldname=N'')
	SELECT top(@h) [fldId] ,[fldTitle] ,[fldType] 
	FROM   [Com].[tblHesabType] 

	COMMIT
GO
