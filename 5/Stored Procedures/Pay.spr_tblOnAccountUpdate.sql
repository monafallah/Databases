SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblOnAccountUpdate] 
    @fldId int,
    @fldCodeMeli int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldTitle nvarchar(200),
    @fldNobatePardakt tinyint,
    @fldKhalesPardakhti int,
    @fldUserId int,
    @fldIP varchar(15),  
    @fldFlag bit,
	@fldGhatei bit,
	@fldShomareHesab varchar(25),
	@fldOrganId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Pay].[tblOnAccount]
	SET    [fldCodeMeli] = @fldCodeMeli, [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldTitle] = @fldTitle, [fldNobatePardakt] = @fldNobatePardakt, [fldKhalesPardakhti] = @fldKhalesPardakhti, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDate] = getdate(),  [fldFlag] = @fldFlag,fldOrganId=@fldOrganId,fldGhatei=@fldGhatei,fldShomareHesab=@fldShomareHesab
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
