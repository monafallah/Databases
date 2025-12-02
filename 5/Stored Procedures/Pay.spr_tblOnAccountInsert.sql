SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblOnAccountInsert] 

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
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Pay].[tblOnAccount] 
	INSERT INTO [Pay].[tblOnAccount] ([fldId], [fldCodeMeli], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], [fldUserId], [fldIP], [fldDate],  [fldFlag],fldGhatei,fldShomareHesab,fldOrganId)
	SELECT @fldId, @fldCodeMeli, @fldYear, @fldMonth, @fldTitle, @fldNobatePardakt, @fldKhalesPardakhti, @fldUserId, @fldIP, getdate(),  @fldFlag,@fldGhatei,@fldShomareHesab,@fldOrganId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
