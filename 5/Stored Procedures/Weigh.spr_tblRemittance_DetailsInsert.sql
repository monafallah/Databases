SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_DetailsInsert] 

    @fldRemittanceId int,
    @fldKalaId int,
    @fldMaxTon int,
    @fldControlLimit bit,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  
    @fldIP varchar(15)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblRemittance_Details] 

	INSERT INTO [Weigh].[tblRemittance_Details] ([fldId], [fldRemittanceId], [fldKalaId], [fldMaxTon], [fldControlLimit], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldRemittanceId, @fldKalaId, @fldMaxTon, @fldControlLimit, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
