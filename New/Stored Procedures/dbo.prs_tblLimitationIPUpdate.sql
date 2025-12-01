SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationIPUpdate] 
    @fldId int,
    @fldUserLimId int,
    @fldIPValid varchar(50),
	@inputid int,
	@fldTimeStamp int,
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	Declare @flag tinyint
	if not exists(select * from tblLimitationIP where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblLimitationIP where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblLimitationIP where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	if(@flag=1)
	begin
	UPDATE [dbo].[tblLimitationIP]
	SET    [fldUserLimId] = @fldUserLimId, [fldIPValid] = @fldIPValid, [fldDesc] = @fldDesc,fldInputId=@inputid
	WHERE  fldId=@fldId
	if(@@Error<>0)
   
	    rollback   
	select @flag as flag
	
end
	else
		select @flag as flag
	
	COMMIT
GO
