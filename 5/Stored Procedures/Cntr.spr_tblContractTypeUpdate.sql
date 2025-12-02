SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Cntr].[spr_tblContractTypeUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldDarsadBimePeymankar decimal(5, 2),
    @fldDarsadBimeKarfarma decimal(5, 2),
    @fldDarsadAnjamKar decimal(5, 2),
    @fldDarsadZemanatName decimal(5, 2),
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [cntr].[tblContractType]
	SET    [fldTitle] = @fldTitle, [fldDarsadBimePeymankar] = @fldDarsadBimePeymankar, [fldDarsadBimeKarfarma] = @fldDarsadBimeKarfarma, [fldDarsadAnjamKar] = @fldDarsadAnjamKar, [fldDarsadZemanatName] = @fldDarsadZemanatName, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
