SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghi_DetailUpdate] 
    @fldId int,
    @fldAshkhaseHoghoghiId int ,
    @fldCodEghtesadi nvarchar(20) = NULL,
    @fldAddress nvarchar(MAX) = NULL,
    @fldCodePosti nvarchar(10) = NULL,
    @fldShomareTelephone nvarchar(11) = NULL,
    @fldUserId int,
    @fldDesc nvarchar(MAX)

AS 
	BEGIN TRAN
	set @fldCodEghtesadi=com.fn_TextNormalize(@fldCodEghtesadi)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)
	set @fldCodePosti=com.fn_TextNormalize(@fldCodePosti)
	set @fldShomareTelephone=com.fn_TextNormalize(@fldShomareTelephone)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblAshkhaseHoghoghi_Detail]
	SET    [fldAshkhaseHoghoghiId] = @fldAshkhaseHoghoghiId, [fldCodEghtesadi] = @fldCodEghtesadi, [fldAddress] = @fldAddress, [fldCodePosti] = @fldCodePosti, [fldShomareTelephone] = @fldShomareTelephone, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
