SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblTozinInsert] 

    @fldWeighbridgeId int,
    @fldMaxW int,
    @fldPlaqueId int,
    @fldHour datetime,
    @fldStartDate datetime,
    @fldEndDate datetime
   
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblTozin] 

	INSERT INTO [Weigh].[tblTozin] ([fldId], [fldWeighbridgeId], [fldMaxW], [fldPlaqueId], [fldHour], [fldStartDate], [fldEndDate], [fldDate])
	SELECT @fldId, @fldWeighbridgeId, @fldMaxW, @fldPlaqueId, @fldHour, @fldStartDate, @fldEndDate, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
