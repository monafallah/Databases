SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifInsert] 
    @fldId INT OUT,
    @fldShomareMojavez nvarchar(50),
    @fldTarikhMojavez nvarchar(10),
    @fldAzTarikh nvarchar(10),
    @fldTaTarikh nvarchar(10),
    @fldTakhfifKoli decimal(5, 2),
    @fldTakhfifNaghdi decimal(5, 2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblTakhfif] 
	INSERT INTO [Drd].[tblTakhfif] ([fldId], [fldShomareMojavez], [fldTarikhMojavez], [fldAzTarikh], [fldTaTarikh], [fldTakhfifKoli], [fldTakhfifNaghdi], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldShomareMojavez, @fldTarikhMojavez, @fldAzTarikh, @fldTaTarikh, @fldTakhfifKoli, @fldTakhfifNaghdi, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
