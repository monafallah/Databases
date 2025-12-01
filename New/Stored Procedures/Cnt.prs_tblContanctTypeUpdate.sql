SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContanctTypeUpdate] 
    @fldId tinyint,
    @fldType nvarchar(100),
    @fldIconId int,
	@fldIcon varbinary(mAx),
	@Pasavand nvarchar(6),
	@FileName nvarchar(100),
	@inputid int,
	@fldTimeStamp int
AS 


	BEGIN TRAN
	Declare @flag tinyint,@flag1 bit=0
	SET @FileName=dbo.fn_TextNormalize(@FileName)
	SET @fldType=dbo.fn_TextNormalize(@fldType)
	if not exists(select * from [Cnt].[tblContanctType] where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from [Cnt].[tblContanctType] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from [Cnt].[tblContanctType] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	
	if(@flag=1)
	begin
	if(@fldIcon is not null)
	begin
	UPDATE dbo.tblFile
			SET fldFile=@fldIcon,fldPasvand=@Pasavand,fldFileName=@FileName,fldSize=cast(round((DATALENGTH(@fldIcon)/1024.0)/1024.0,2) as decimal(8,2))
			
			WHERE fldId=@fldIconId
			
		if(@@ERROR<>0)
		Begin
			rollback
			
			set @flag=1
		end
	end
	if(@flag=1)
	begin
	UPDATE [Cnt].[tblContanctType]
	SET    [fldType] = @fldType, [fldIconId] = @fldIconId,fldinputid=	@inputid 
	WHERE  fldId=@fldId
	if(@@ERROR<>0)
		Begin
			rollback
			
		end
		
	end
		select @flag as flag
	end
	else
		select @flag as flag
	COMMIT
GO
