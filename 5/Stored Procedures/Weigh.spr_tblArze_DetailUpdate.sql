SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArze_DetailUpdate] 
    @fldId int,
    @fldHeaderId int,
    @fldParametrSabetCodeDaramd int,
    @fldValue nvarchar(200),

    @fldflag bit,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  
    @fldIP varchar(16)
AS 

	BEGIN TRAN

	UPDATE [Weigh].[tblArze_Detail]
	SET    [fldHeaderId] = @fldHeaderId, [fldParametrSabetCodeDaramd] = @fldParametrSabetCodeDaramd, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	,fldFlag=@fldflag
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
