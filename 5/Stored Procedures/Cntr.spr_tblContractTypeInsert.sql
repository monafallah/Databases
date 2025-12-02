SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Cntr].[spr_tblContractTypeInsert] 
   
    @fldTitle nvarchar(300),
    @fldDarsadBimePeymankar decimal(5, 2),
    @fldDarsadBimeKarfarma decimal(5, 2),
    @fldDarsadAnjamKar decimal(5, 2),
    @fldDarsadZemanatName decimal(5, 2),
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [cntr].[tblContractType] 

	INSERT INTO [cntr].[tblContractType] ([fldId], [fldTitle], [fldDarsadBimePeymankar], [fldDarsadBimeKarfarma], [fldDarsadAnjamKar], [fldDarsadZemanatName], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldDarsadBimePeymankar, @fldDarsadBimeKarfarma, @fldDarsadAnjamKar, @fldDarsadZemanatName, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
