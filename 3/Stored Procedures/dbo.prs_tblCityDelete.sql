SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCityDelete] 
@fldID int,
@fldTimeStamp int
AS 
	
	BEGIN TRAN
	Declare @flag tinyint
	if not exists(select * from tblCity where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblCity where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblCity where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0
			
	if(@flag=1)
	begin	
	DELETE
	FROM   [dbo].[tblCity]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback   
	select @flag as flag
	end
	else
		select @flag as flag
	COMMIT
GO
