SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblAddressUpdate] 
    @fldId int,
    @fldShahrId int,
    @fldContactId int,
	@fldLatitude nvarchar(50),
	@fldLongitude nvarchar(50),
	@inputid int
AS 

	BEGIN TRAN
	Declare @flag tinyint,@flag1 bit=0
	
	

	UPDATE [Cnt].[tblAddress]
	SET    [fldShahrId] = @fldShahrId, [fldContactId] = @fldContactId,fldLatitude=@fldLatitude,fldLongitude=@fldLongitude
	,fldInputId=@inputid
	where fldid=@fldId
		
			if(@@ERROR<>0)
			rollback
	
	
	COMMIT
GO
