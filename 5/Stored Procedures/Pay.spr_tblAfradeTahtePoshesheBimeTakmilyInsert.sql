SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmilyInsert] 
  
    @fldPersonalId int,
    @fldTedadAsli int,
    @fldTedadTakafol60Sal int,
    @fldTedadTakafol70Sal int,
	@fldTedadBedonePoshesh int,
    @fldGHarardadBimeId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldAfradTahtePoshehsId varchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblAfradeTahtePoshesheBimeTakmily] 
	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily] ([fldId], [fldPersonalId], [fldTedadAsli], [fldTedadTakafol60Sal], [fldTedadTakafol70Sal], [fldGHarardadBimeId], [fldUserId], [fldDesc], [fldDate],fldTedadBedonePoshesh)
	SELECT @fldId, @fldPersonalId, @fldTedadAsli, @fldTedadTakafol60Sal, @fldTedadTakafol70Sal, @fldGHarardadBimeId, @fldUserId, @fldDesc, GETDATE(),@fldTedadBedonePoshesh
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		declare @fldDetailID int 
	select @fldDetailID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] 

	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ([fldId], [fldAfradTahtePoshehsId], [fldBimeTakmiliId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldDetailID+ROW_NUMBER() over(order by item), Item, @fldID, @fldUserId, @fldDesc, getdate()
			from com.Split(@fldAfradTahtePoshehsId,';')
			where Item<>''
	if(@@Error<>0)
        rollback   

	end

	COMMIT
GO
