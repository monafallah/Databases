SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPardakhtFishUpdate] 
    @fldId int,
    @fldFishId int,
    @fldDatePardakht datetime,
    @fldNahvePardakhtId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldPardakhtFiles_DetailId int,
	@fldDateVariz datetime
   
AS 
begin try
	BEGIN TRAN
	declare @fldDocumentHeaderId1 int=0,@IdError int
	select @fldDocumentHeaderId1=fldDocumentHeaderId1 from drd.tblPardakhtFish where fldFishId=@fldFishId
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPardakhtFish]
	SET    [fldFishId] = @fldFishId, [fldDatePardakht] = @fldDatePardakht, [fldNahvePardakhtId] = @fldNahvePardakhtId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldPardakhtFiles_DetailId=@fldPardakhtFiles_DetailId
	,fldDateVariz=@fldDateVariz
	WHERE  [fldId] = @fldId


	if @fldDocumentHeaderId1 is not null and @fldDocumentHeaderId1<>0

	update acc.tblDocumentRecord_Header1
	set fldTarikhDocument=dbo.Fn_AssembelyMiladiToShamsi(@fldDatePardakht)
	where fldid=@fldDocumentHeaderId1
	
	COMMIT TRAN
end try

begin catch
	rollback
	select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),'',@fldUserId,'PardakhtFishUpdate',getdate() from com.tblUser where fldid=@fldUserId

end catch
GO
