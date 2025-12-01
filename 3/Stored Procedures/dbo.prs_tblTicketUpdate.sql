SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketUpdate] 
    @fldId int,
    @fldHTML nvarchar(MAX),
    @fldInputID INT=null,
    @fldDesc nvarchar(MAX),
	@fldAshkhasId int ,
	@flduserId INT
AS 
	BEGIN TRAN
		SET @fldDesc =dbo.fn_TextNormalize(@fldDesc) 

	UPDATE [dbo].[tblTicket]
	SET    [fldHTML] = @fldHTML, [fldInputID] = @fldInputID,[fldDesc] = @fldDesc, [fldDate] = GETDATE(),[fldAshkhasId]=@fldAshkhasId,fldUserId=@fldUserId
	WHERE  [fldId] = @fldId
	 if (@@ERROR<>0)
		begin
		ROLLBACK
		END
       
	COMMIT TRAN
GO
