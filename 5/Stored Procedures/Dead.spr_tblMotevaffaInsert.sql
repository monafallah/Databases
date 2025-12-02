SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMotevaffaInsert] 
   @fldShomareId int,
   @fldEmployeeId int,
    @fldCauseOfDeathId int,
   
    @fldTarikhFot int,
    @fldTarikhDafn int,
	@fldMahalFotId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @tabaghe tinyint,@idamanat int,@flag bit=0
	declare @fldID int
	/*select @tabaghe=isnull(max(fldShomareTabaghe),0)+1 from dead.tblGhabreAmanat where fldShomareId=@fldShomareId
	if exists (select * from dead.tblGhabreAmanat where fldEmployeeId=@fldEmployeeId)
	begin
		select @idamanat=fldid from dead.tblGhabreAmanat where fldEmployeeId=@fldEmployeeId
		update dead.tblGhabreAmanat
		set fldShomareTabaghe=@tabaghe
		where fldid=@idamanat
		if(@@Error<>0)
		begin
			rollback   
			set @flag=1 
		end
	end
	else 
	begin
		select @idamanat =ISNULL(max(fldId),0)+1 from [Dead].[tblGhabreAmanat] 
		INSERT INTO [Dead].[tblGhabreAmanat] ([fldId], [fldShomareId], [fldShomareTabaghe], [fldEmployeeId], [fldOrganId], [fldTarikhRezerv], [fldUserId], [fldDesc], [fldDate], [fldIP])
		SELECT @idamanat, @fldShomareId, @tabaghe, @fldEmployeeId, @fldOrganId, null, @fldUserId, @fldDesc, GETDATE(), @fldIP
		if(@@Error<>0)
		begin
			rollback   
			set @flag=1 
		end      

	end	
	 if (@flag=0)
	 begin*/
		select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblMotevaffa] 
		INSERT INTO [Dead].[tblMotevaffa] ([fldId], [fldCauseOfDeathId], [fldGhabreAmanatId], [fldTarikhFot], [fldTarikhDafn], [fldOrganId], [fldUserId], [fldDesc], [fldDate], [fldIP],fldMahalFotId)
		SELECT @fldId, @fldCauseOfDeathId, @idamanat, @fldTarikhFot, @fldTarikhDafn, @fldOrganId, @fldUserId, @fldDesc, GETDATE(), @fldIP,@fldMahalFotId
		if(@@Error<>0)
			rollback 
	--end	      
	COMMIT
GO
