SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


create PROC [Trans].[prs_tblSubTransactionInsert_Report] 
    @fldInputId int,
    @fldTransactiontTypeName Nvarchar(200),
    @fldStatus bit,
	@fldTransactionGroupId int,
	@fldJsonParametr nvarchar(2000)
AS 

	BEGIN TRAN
	--[fldFlag]=0 جدول اصلی rowid
	--[fldFlag]=1 جدول هیستوری rowid
	--[fldStatus]=1 عملیات موفق
	--[fldStatus]=0 عملیات ناموفق

	declare  @fldTarikh int,@fldTime int,@fldTransactiontTypeId int,@idtype int
	declare @fldSubTransactionId int
	set @fldTarikh= REPLACE( dbo.Fn_AssembelyMiladiToShamsi(GETDATE()),'/','')
	set @fldTime=REPLACE( cast(GETDATE() as time(0)),':','')

	if not exists (select * from trans.tblTransactionType where fldTransactionGroupId=@fldTransactionGroupId and fldName=@fldTransactiontTypeName)
	begin
	select @fldTransactiontTypeId=max(fldId)+1 from tblTransactionType
		INSERT INTO [Trans].[tblTransactionType] (fldid,[fldName], [fldTransactionGroupId])
		SELECT @fldTransactiontTypeId,@fldTransactiontTypeName, @fldTransactionGroupId 
		--set @fldTransactiontTypeId=SCOPE_IDENTITY()
	end
	else
	select @fldTransactiontTypeId=fldId from trans.tblTransactionType where fldTransactionGroupId=@fldTransactionGroupId and fldName=@fldTransactiontTypeName
				
	INSERT INTO [Trans].[tblSubTransaction] ([fldInputId], [fldTransactiontTypeId], [fldStatus], [fldTarikh], [fldTime])
	SELECT @fldInputId, @fldTransactiontTypeId, @fldStatus, @fldTarikh, @fldTime
	set @fldSubTransactionId=SCOPE_IDENTITY()
	if (@@ERROR<>0)
	begin	
		ROLLBACK
	end
	else
	begin
	INSERT INTO [Trans].[tblSubTransactionParametrs] ([fldSubTransactionId], [fldJsonParametr])
	SELECT @fldSubTransactionId, @fldJsonParametr
	if (@@ERROR<>0)
		ROLLBACK
	end
	COMMIT
GO
