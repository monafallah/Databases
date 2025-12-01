SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationTimeUpdate] 
    @fldId int,
    @fldUserLimId int,
    @fldRoozHafte nvarchar(50),
    @fldAzSaat int,
    @fldTaSaat int,
    @fldDesc nvarchar(100),
	@inputid int,
	@fldTimeStamp int
AS 

	BEGIN TRAN
	Declare @flag tinyint
	if not exists(select * from tblLimitationTime where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblLimitationTime where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblLimitationTime where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	if(@flag=1)
	begin
	UPDATE [dbo].[tblLimitationTime]
	SET    [fldUserLimId] = @fldUserLimId, [fldRoozHafte] = @fldRoozHafte, [fldAzSaat] = @fldAzSaat, [fldTaSaat] = @fldTaSaat, [fldDesc] = @fldDesc
	,fldinputid=@inputid
	WHERE  fldId=@fldId
	if(@@Error<>0)
    
	    rollback   
	select @flag as flag
	
end
	else
		select @flag as flag
	
	COMMIT
GO
