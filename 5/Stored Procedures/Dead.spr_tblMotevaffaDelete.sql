SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMotevaffaDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	declare @amantid int,@flag bit=0
	select @amantid=fldGhabreAmanatId from dead.[tblMotevaffa] where fldid=@fldid
	

	update [Dead].[tblMotevaffa] set fldUserID=@fldUserID,fldDate=GETDATE()
	where  fldId =@fldId
	if(@@Error<>0)
	begin
        rollback   
		set @flag=1
	end
	if(@flag =0)
	begin
		DELETE
		FROM   [Dead].[tblMotevaffa]
		where  fldId =@fldId
		if(@@Error<>0)
		begin
			rollback 
			set @flag=1
		end	
	end	  
	if (@flag=0)/*در صورت حذف از متوفی باید ان شماره قبر یا پاک شود یا طبقش نال شود*/
	begin
		if (select fldTarikhRezerv from dead.tblGhabreAmanat where fldid=@amantid ) is null/*قبر امانت از قبل نداشته*/
		begin
		delete from dead.tblGhabreAmanat
		where fldid =@amantid
		if(@@Error<>0)
			rollback   
		end
		else
		begin
		update dead.tblGhabreAmanat/*قبر امانت داشته*/
		set fldShomareTabaghe=NUll
		where fldid=@amantid and fldTarikhRezerv is not null
		if(@@Error<>0)
			rollback  
		end	 
	end
	COMMIT
GO
