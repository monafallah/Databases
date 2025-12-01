SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblTreeGroupUpdate] 
@fieldname varchar(50),
@fldTitle nvarchar(150),
    @fldId int,
    @fldGroupId int,
		@inputid int,
    @fldPId int = NULL
AS 

	BEGIN TRAN
	 declare  @fldRowId varbinary(8),
	@fldRowId_Next_Up_Del varbinary(8)
	set @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	
	if(@fieldName='Id')
	begin
	UPDATE [Cnt].[tblTreeGroup]
	SET    [fldGroupId] = @fldGroupId, fldTitle=@fldTitle,fldInputId=@inputid
	WHERE  fldId=@fldId
	if(@@ERROR<>0)
		Begin
			rollback
			
		end
		
	end

	if(@fieldName='PId')
	begin
	UPDATE [Cnt].[tblTreeGroup]
	SET     [fldPId] = @fldPId,fldInputId=@inputid
	WHERE  fldId=@fldId
	if(@@ERROR<>0)
		Begin
			rollback
		
		
		end
	end
	COMMIT
GO
