SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Trans].[prs_tblSubTransactionInsert] 
	@fieldName varchar(50),
    @fldInputId int,
    @fldTransactiontTypeId int,
    @fldStatus bit,
	@fldEnNameTables varchar(100),
	@fldRowId varbinary(8),
	@fldRowId_Next_Up_Del varbinary(8),
    @fldJsonParametr nvarchar(2000)
AS 

	BEGIN TRAN
	--[fldFlag]=0 جدول اصلی rowid
	--[fldFlag]=1 جدول هیستوری rowid
	--[fldStatus]=1 عملیات موفق
	--[fldStatus]=0 عملیات ناموفق

	declare  @fldTarikh int,@fldTime int,@SubTransactionId int,@fldNameTablesId int
	--set @fldTarikh= REPLACE( dbo.Fn_AssembelyMiladiToShamsi(GETDATE()),'/','')
	set @fldTarikh= REPLACE( dbo.MiladiTOShamsi(GETDATE()),'/','')
	set @fldTime=REPLACE( cast(GETDATE() as time(0)),':','')
	select @fldNameTablesId=fldId from Trans.tblNameTables where fldEnNameTables=@fldEnNameTables
	if(@fieldName='Update')
	begin
		update [Trans].[tblSubTransactionTables] set [fldRowId]=@fldRowId_Next_Up_Del,[fldFlag]=1
		where [fldRowId]=@fldRowId
	end
	INSERT INTO [Trans].[tblSubTransaction] ([fldInputId], [fldTransactiontTypeId], [fldStatus], [fldTarikh], [fldTime])
	SELECT @fldInputId, @fldTransactiontTypeId, @fldStatus, @fldTarikh, @fldTime
	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		set @SubTransactionId= SCOPE_IDENTITY()
		INSERT INTO [Trans].[tblSubTransactionTables] ([fldSubTransactionId], [fldNameTablesId], [fldRowId], [fldFlag])
		SELECT @SubTransactionId, @fldNameTablesId, @fldRowId, 0
		if (@@ERROR<>0)
			ROLLBACK

		INSERT INTO [Trans].[tblSubTransactionParametrs] ([fldSubTransactionId], [fldJsonParametr])
		SELECT @SubTransactionId, @fldJsonParametr
		if (@@ERROR<>0)
			ROLLBACK
	end
	COMMIT
GO
