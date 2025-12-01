SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblAshkhasDelete] 
@fldID int,
@fldTimeStamp int
AS 
	
	BEGIN TRAN
	Declare @flag tinyint,@flag2 bit=0,@fldfileid int
	select @fldfileid=fldfileid from tblAshkhas where fldid=@fldid
	if not exists(select * from tblAshkhas where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblAshkhas where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblAshkhas where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	
	if (@flag=1)
	begin
		DELETE
		FROM   [dbo].[tblAshkhas]
		where  fldId =@fldId
		if(@@Error<>0)
		begin
			rollback
			set @flag2=1   
		end
		if (@flag2=0)
		begin
			delete from tblfile
			where fldid=@fldfileid
			if (@@error<>0)
			rollback
		end
	select @flag as flag
	end
	else
		select @flag as flag
	COMMIT
GO
