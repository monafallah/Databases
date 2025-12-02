SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblTasviehHesabUpdate] 
    @fldId int,
    @fldPrsPersonalInfoId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 

	BEGIN TRAN

	UPDATE [Prs].[tblTasviehHesab]
	SET    [fldPrsPersonalInfoId] = @fldPrsPersonalInfoId, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =  GETDATE()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
