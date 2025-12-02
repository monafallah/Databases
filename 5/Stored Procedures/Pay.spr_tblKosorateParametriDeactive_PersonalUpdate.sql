SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosorateParametriDeactive_PersonalUpdate] 
    @fldPersonalId varchar(max),
    @fldParametrId int,
    @fldMablagh int,
    @fldTarikhePardakht nvarchar(10),
    @fldStatus bit,
    @fldDateDeactive int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKosorateParametri_Personal]
	SET     [fldStatus] = @fldStatus,fldUserId=@fldUserId,fldDate=GETDATE(),fldDateDeactive=@fldDateDeactive
	WHERE fldPersonalId in (select Item from  com.Split(@fldPersonalId,';')where Item<>'') 
	AND fldParametrId=@fldParametrId AND fldMablagh=@fldMablagh AND fldTarikhePardakht=@fldTarikhePardakht
	COMMIT TRAN
GO
