SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_UpdateFormulTypeContact](@fldFormul nvarchar(MAX),@Id INT
  )
AS

BEGIN tran
	DECLARE @fldFormulIdOld INT
	Declare @flag tinyint,@flag1 bit=0,
    @fldRowId varbinary(8),
	@fldRowId_Next_Up_Del varbinary(8)
	
	SELECT @fldFormulIdOld=fldFormulId FROM [Cnt].[tblContanctType] WHERE fldId=@Id
	select @fldRowId=tblContanctType.%%physLoc%% from [Cnt].[tblContanctType] WHERE  [fldId] = @Id
	UPDATE [Cnt].[tblContanctType]
	SET fldFormul=@fldFormul,fldFormulId=null
	WHERE fldId=@Id
	if(@@ERROR<>0)
		Begin
			rollback
			 
			set @flag=1
		end
	
		if(@fldFormulIdOld is not null and @flag=0)
		begin
			DELETE FROM tblComputationFormula
			WHERE fldId=@fldFormulIdOld
				if(@@ERROR<>0)
				Begin
					rollback
					
					set @flag=1
			end
		end

	
commit	

GO
