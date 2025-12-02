SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCaseBillsInsert] 
    
    @fldBillsTypeId int,
    @fldFileNum int,
    @fldCentercoId int,
    @fldOrganId int,
    @fldOrganChartId int,
    @fldAshkhasId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblCaseBills] 
	INSERT INTO [Com].[tblCaseBills] ([fldId], [fldBillsTypeId], [fldFileNum], [fldCentercoId], [fldOrganId], [fldOrganChartId], [fldAshkhasId], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldBillsTypeId, @fldFileNum, @fldCentercoId, @fldOrganId, @fldOrganChartId, @fldAshkhasId, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
