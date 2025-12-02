SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblAshkhaseHoghoghi_DetailInsert] 

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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblAshkhaseHoghoghi_Detail] 
	INSERT INTO [Com].[tblAshkhaseHoghoghi_Detail] ([fldId], [fldAshkhaseHoghoghiId], [fldCodEghtesadi], [fldAddress], [fldCodePosti], [fldShomareTelephone], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldAshkhaseHoghoghiId, @fldCodEghtesadi, @fldAddress, @fldCodePosti, @fldShomareTelephone, @fldUserId, @fldDesc, getDate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
