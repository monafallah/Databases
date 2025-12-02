SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghiUpdate] 
    @fldId int,
    @fldShenaseMelli nvarchar(11),
    @fldName nvarchar(250),
    @fldShomareSabt nvarchar(20) ,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTypeShakhs TINYINT,
	@fldSayer TINYINT
AS 
	BEGIN TRAN
	set  @fldShenaseMelli=com.fn_TextNormalize(@fldShenaseMelli)
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldShomareSabt=com.fn_TextNormalize(@fldShomareSabt)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [com].[tblAshkhaseHoghoghi]
	SET    [fldShenaseMelli] = @fldShenaseMelli, [fldName] = @fldName, [fldShomareSabt] = @fldShomareSabt, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldTypeShakhs=@fldTypeShakhs,fldSayer=@fldSayer
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
