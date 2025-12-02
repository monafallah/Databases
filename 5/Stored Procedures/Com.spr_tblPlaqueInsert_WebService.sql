SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPlaqueInsert_WebService] 
	@fldId int out,
	@Haraf nvarchar(1),
    @Plaque1 varchar(2),
	@Plaque2 varchar(3),
	@serial tinyint,
    @fldDesc nvarchar(50)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	
	declare @fldPlaque nvarchar(13)
	set @fldPlaque='-'+@Plaque2+@Haraf+@Plaque1 

	if not exists(select * from [Com].[tblPlaque] where fldSerialPlaque=@serial and fldPlaque=@fldPlaque)
	begin
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblPlaque] 

	INSERT INTO [Com].[tblPlaque] ([fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId,@serial, @fldPlaque, 1, @fldDesc, getdate(), '::1'

	if(@@Error<>0)
        rollback   
	end	 
	select @fldID=fldid from [Com].[tblPlaque] where fldSerialPlaque=@serial and fldPlaque=@fldPlaque   
	select @fldId
	COMMIT
GO
