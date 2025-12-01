SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Trans].[prs_UpdateFormuleEvent](@fieldname varchar(50), @id int,  @fldFormul NVARCHAR(max),
    @fldLibrary nvarchar(MAX),@fldDesc nvarchar(MAX),@fldCompiledCode VARBINARY(max))
as
begin tran
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	SET @fldLibrary=dbo.fn_TextNormalize(@fldLibrary)
declare @idformul int
if(@fieldname='Event')
begin
if(select fldFormulId from Trans.tblEvent where fldid=@id) is null
begin
	select @idformul =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @idformul,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update Trans.tblEvent
		set fldFormulId=@idformul
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @idformul=fldFormulId from Trans.tblEvent where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @idformul
			if(@@ERROR<>0)
			rollback
end
end

if(@fieldname='EventTables')
begin
if(select fldFormulId from Trans.tblEventTables where fldid=@id) is null
begin
	select @idformul =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @idformul,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update Trans.tblEventTables
		set fldFormulId=@idformul
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @idformul=fldFormulId from Trans.tblEventTables where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @idformul
			if(@@ERROR<>0)
			rollback
end
end
GO
