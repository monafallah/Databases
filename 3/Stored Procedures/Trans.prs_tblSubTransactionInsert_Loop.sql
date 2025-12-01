SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblSubTransactionInsert_Loop] 
    @fldInputId int,
    @fldTransactiontTypeId int,
    @fldStatus bit,
	@fldEnNameTables varchar(100),
    @fldJsonParametr nvarchar(2000),
	@SubTransactionId int output
AS 

	BEGIN TRAN
	--[fldFlag]=0 جدول اصلی rowid
	--[fldFlag]=1 جدول هیستوری rowid
	--[fldStatus]=1 عملیات موفق
	--[fldStatus]=0 عملیات ناموفق

	declare  @fldTarikh int,@fldTime int,@fldNameTablesId int
	--set @fldTarikh= REPLACE( dbo.Fn_AssembelyMiladiToShamsi(GETDATE()),'/','')
	set @fldTarikh= REPLACE( dbo.MiladiTOShamsi(GETDATE()),'/','')
	set @fldTime=REPLACE( cast(GETDATE() as time(0)),':','')
	select @fldNameTablesId=fldId from Trans.tblNameTables where fldEnNameTables=@fldEnNameTables

	INSERT INTO [Trans].[tblSubTransaction] ([fldInputId], [fldTransactiontTypeId], [fldStatus], [fldTarikh], [fldTime])
	SELECT @fldInputId, @fldTransactiontTypeId, @fldStatus, @fldTarikh, @fldTime
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		set @SubTransactionId= SCOPE_IDENTITY()

		INSERT INTO [Trans].[tblSubTransactionParametrs] ([fldSubTransactionId], [fldJsonParametr])
		SELECT @SubTransactionId, @fldJsonParametr
		if (@@ERROR<>0)
			ROLLBACK
	end
	COMMIT
GO
