SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblComputationFormulaInsert] 
   @fldID int out,
    @fldFormul NVARCHAR(max),
    @fldLibrary nvarchar(MAX),
    @fldInputID INT,
    @fldDesc nvarchar(MAX),
	@Id int,
	@fieldname nvarchar(50),
	
	@fldCompiledCode VARBINARY(max)
AS 
	
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	SET @fldLibrary=dbo.fn_TextNormalize(@fldLibrary)
	declare /*@fldID int ,*/@flag bit=0,@MohasebatId INT,@fldFormulKoliId  INT,@ParametrOmoomiid INT,@ParametrSabet INT,@DaramdGroup INT
	
	if(@fieldname='FormulArchiveProperties')
	BEGIN
	declare @FormulArchive int=0
	SELECT @FormulArchive=fldFormulId FROM tblProperties WHERE fldid=@Id
	
	IF( @FormulArchive IS NOT NULL)
	BEGIN
			UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @FormulArchive
	END
		ELSE
		BEGIN
			select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
			INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
			SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update tblProperties
			Set fldFormulId=@fldId
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
		END
	END

	if(@fieldname='FormulRules')
	BEGIN
	--declare @FormulIdRule int
	--SELECT @FormulIdRule=fldFormulId FROM tblRules WHERE fldid=@Id
	--IF( @FormulIdRule is not null)
	--BEGIN
	--		UPDATE tblComputationFormula
	--		SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,[fldInputID] =@fldInputID ,  [fldDesc] = @fldDesc, [fldDate] = GETDATE(),[fldUserId] = @fldUserId,fldCompiledCode=@fldCompiledCode
	--		WHERE  [fldId] = @FormulIdRule
	--END
	--	ELSE
		--BEGIN
			select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
			INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary],[fldDesc], fldCompiledCode)
			SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
			if(@@Error<>0)
			begin
				 set @flag=1
				 Rollback
			end
			
			if (@flag=0)
			begin
			Update tblRules
			Set fldFormulId=@fldId,
			fldFormul=''
			where fldId=@Id 
				if(@@Error<>0)
				begin
					 set @flag=1
					 Rollback
				end
			end
		--ENd
	ENd
	
	if(@fieldname='WebService')
	BEGIN
		select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
		INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
		SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,  @fldCompiledCode
		if(@@Error<>0)
		begin
			set @flag=1
			Rollback
		end
			
		if (@flag=0)
		begin
		Update tblWebService
		Set fldFormulId =@fldId
		where fldId=@Id 
			if(@@Error<>0)
			begin
					set @flag=1
					Rollback
			end
		end
	ENd

	if(@fieldname='Operation')
	BEGIN
		select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
		INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary],[fldDesc],fldCompiledCode)
		SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc, @fldCompiledCode
		if(@@Error<>0)
		begin
			set @flag=1
			Rollback
		end
			
		if (@flag=0)
		begin
		Update tblOperation
		Set fldformulid =@fldId
		where fldId=@Id 
			if(@@Error<>0)
			begin
					set @flag=1
					Rollback
			end
		end
	END
	
	if(@fieldname='ReferralRules')
	BEGIN
		select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
		INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc],fldCompiledCode)
		SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc, @fldCompiledCode
		if(@@Error<>0)
		begin
			set @flag=1
			Rollback
		end
			
		if (@flag=0)
		begin
		Update dbo.tblReferralRules
		Set fldformulid =@fldId
		where fldId=@Id 
			if(@@Error<>0)
			begin
					set @flag=1
					Rollback
			end
		end
	ENd


	if(@fieldname='Event')
begin
if(select fldFormulId from Trans.tblEvent where fldid=@id) is null
begin
	select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update Trans.tblEvent
		set fldFormulId=@fldId
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @fldId=fldFormulId from Trans.tblEvent where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @fldId
			if(@@ERROR<>0)
			rollback
end
end

if(@fieldname='EventTables')
begin
if(select fldFormulId from Trans.tblEventTables where fldid=@id) is null
begin
	select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update Trans.tblEventTables
		set fldFormulId=@fldId
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @fldId=fldFormulId from Trans.tblEventTables where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @fldId
			if(@@ERROR<>0)
			rollback
end
end
	if(@fieldname='FormulTypeContact')
	begin
if(select fldFormulId from  cnt.tblContanctType where fldid=@id) is null
begin
	select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update cnt.tblContanctType
		set fldFormulId=@fldId
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @fldId=fldFormulId from  cnt.tblContanctType where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @fldId
			if(@@ERROR<>0)
			rollback
end
end

if(@fieldname='MoayenatDynamic_Parametr')
	begin
if(select fldFormuleId from tblMoayenatDynamic_Parametr where fldid=@id) is null
begin
	select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update tblMoayenatDynamic_Parametr
		set fldFormuleId=@fldId
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @fldId=fldFormuleId from  tblMoayenatDynamic_Parametr where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @fldId
			if(@@ERROR<>0)
			rollback
end
end


if(@fieldname='DastoorAmal_Moayene')
	begin
if(select fldFormuleId from tblDastoorAmal_Moayene where fldid=@id) is null
begin
	select @fldId =ISNULL(max(fldId),0)+1 from  tblComputationFormula 
	INSERT INTO tblComputationFormula ([fldId],  [fldFormul],  [fldLibrary], [fldDesc], fldCompiledCode)
	SELECT @fldId,  @fldFormul, @fldLibrary, @fldDesc,@fldCompiledCode
		if(@@ERROR<>0)
		rollback
	else
	begin
		update tblDastoorAmal_Moayene
		set fldFormuleId=@fldId
		where fldid=@id
		if(@@ERROR<>0)
		rollback
	end
end
else 
Begin
		select @fldId=fldFormuleId from  tblDastoorAmal_Moayene where fldid=@id
		UPDATE tblComputationFormula
			SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc, fldCompiledCode=@fldCompiledCode
			WHERE  [fldId] = @fldId
			if(@@ERROR<>0)
			rollback
end
end
	COMMIT
GO
