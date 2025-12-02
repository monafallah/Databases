SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFishLogInsert] 
   
    @fldType tinyint,
    @fldPersonalId int = NULL,
    @fldOrganId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatPardakht tinyint,
    @fldFilterType tinyint = NULL,
    @fldFishType tinyint = NULL,
    @fldCostCenterId int = NULL,
    @fldMahaleKhedmat int = NULL,
    @fldCalcType tinyint,
    @fldMostamar tinyint = NULL,
    @fldIP varchar(16),
    @fldUserId int,
	@fldQRCode Nvarchar(200) out
AS 
	 
	
	BEGIN TRAN
declare @fldid int
--@fldType گروهی وانفرادی
--@fldFilterType تمام پرسنل، مرکز هزینه، محل خدمت
--@fldFishType نوع یک و دو وسه
--@fldCalcType فیش حقوقی, عیدی و...
declare @Tarikh varChar(10),@Time Varchar(8)
set @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
set @Time=cast(cast(GETDATE() as time(0)) as varchar(8))
set @fldQRCode=Com.fn_stringcode( @Tarikh+@Time+cast(@fldUserId as varchar(5))+@fldIP)

	select @fldid=isnull(max(fldId),0)+1  FROM   [Pay].[tblFishLog] 
	INSERT INTO [Pay].[tblFishLog] ([fldId], [fldType], [fldPersonalId], [fldOrganId], [fldYear], [fldMonth], [fldNobatPardakht], [fldFilterType], [fldFishType], [fldCostCenterId], [fldMahaleKhedmat], [fldCalcType], [fldMostamar], [fldDate], [fldIP], [fldUserId],fldQRCode)
	SELECT @fldId, @fldType, @fldPersonalId, @fldOrganId, @fldYear, @fldMonth, @fldNobatPardakht, @fldFilterType, @fldFishType, @fldCostCenterId, @fldMahaleKhedmat, @fldCalcType, @fldMostamar, GETDATE(), @fldIP, @fldUserId,@fldQRCode
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
