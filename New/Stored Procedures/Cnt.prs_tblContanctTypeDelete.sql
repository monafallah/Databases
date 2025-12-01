SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContanctTypeDelete] 
@fldID int,

@fldTimeStamp int
AS 
	
	BEGIN TRAN
	
	declare  @fldRowId varbinary(8),@fileId int,@formulid int
	select @fileId=fldIconId,@formulid=fldFormulId from [Cnt].[tblContanctType] where fldid=@fldid
	Declare @flag tinyint
	if not exists(select * from   [Cnt].[tblContanctType] where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from   [Cnt].[tblContanctType] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from   [Cnt].[tblContanctType] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	if(@flag=1)
	begin
	DELETE
	FROM   [Cnt].[tblContanctType]
	where  fldId =@fldId
	if (@@ERROR<>0)
		begin	
			rollback
		
		end
		else
		begin
			
			delete from tblfile
			where fldid=@fileid
			if (@@ERROR<>0)
			begin	
			rollback
			
			end

			delete from tblComputationFormula
			where fldid=@formulid
			if (@@ERROR<>0)
			begin	
			rollback
			 
			end
		end
		select @flag as flag
	end
	else
		select @flag as flag 
	COMMIT
GO
