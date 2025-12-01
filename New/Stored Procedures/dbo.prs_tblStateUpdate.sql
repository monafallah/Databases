SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblStateUpdate] 
    @fldId tinyint,
    @fldNameState nvarchar(150),
    @fldCountryId smallint,
	@fldTimeStamp int
AS 

	BEGIN TRAN
	Declare @flag tinyint
	set @fldNameState=dbo.fn_TextNormalize(@fldNameState)
	if not exists(select * from tblState where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblState where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblState where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0
			
	if(@flag=1)
	begin		
	UPDATE [dbo].[tblState]
	SET    [fldNameState] = @fldNameState, [fldCountryId] = @fldCountryId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   
	select @flag as flag
	end
	else
		select @flag as flag
	COMMIT
GO
