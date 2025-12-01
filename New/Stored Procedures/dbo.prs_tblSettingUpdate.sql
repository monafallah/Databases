SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_tblSettingUpdate] 
    @fldId int,
    @fldTitle nvarchar(MAX),
    @fldFile varbinary(MAX),
  
    @fldDesc nvarchar(MAX),
	@fldInputID int
AS 
	BEGIN TRAN
	UPDATE [dbo].[tblSetting]
	SET     [fldTitle] = @fldTitle, [fldFile] = @fldFile,[fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end
	--else
	--begin
	--insert into tbllogtable
	--			select 7 ,@fldId,@fldInputID,GETDATE(),2
	--			if(@@ERROR<>0)
	--			begin
	--				rollback
	--			end
	--end
	COMMIT TRAN
GO
