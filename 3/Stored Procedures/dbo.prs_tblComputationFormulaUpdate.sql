SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblComputationFormulaUpdate] 
    @fldId int,
    @fldFormul nvarchar(MAX),
    @fldLibrary nvarchar(MAX),
   
    @fldDesc nvarchar(MAX),
    @fldInputID int,
	@fldCompiledCode  VARBINARY(max)
AS 
	BEGIN TRAN
	UPDATE [dbo].[tblComputationFormula]
	SET    [fldFormul] = @fldFormul, [fldLibrary] = @fldLibrary,  [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
	begin
		rollback
	end
	else
	begin
	insert into tbllogtable
			select 2 ,@fldId,@fldInputID,GETDATE(),2
			if(@@ERROR<>0)
			begin
				rollback
			end
	end
	COMMIT TRAN
GO
