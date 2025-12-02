SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAfradTahtePoosheshInsert] 

    @fldPersonalId int,
    @fldName nvarchar(100),
    @fldFamily nvarchar(100),
    @fldBirthDate nvarchar(10),
    @fldStatus tinyint,
    @fldMashmul bit,
    @fldNesbat tinyint,
    @fldCodeMeli Com.Codemeli,
    @fldSh_Shenasname nvarchar(10),
    @fldFatherName nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTarikhEzdevaj varchAR(10),
	@fldNesbatShakhs tinyint,
	@fldMashmoolPadash bit,
	@fldTarikhTalagh	varchar(10)	
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldFamily=Com.fn_TextNormalize(@fldFamily)
	SET @fldFatherName=Com.fn_TextNormalize(@fldFatherName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblAfradTahtePooshesh] 
	INSERT INTO [Prs].[tblAfradTahtePooshesh] ([fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc],fldTarikhEzdevaj,fldNesbatShakhs,fldMashmoolPadash,fldTarikhTalagh)
	SELECT @fldId, @fldPersonalId, @fldName, @fldFamily, @fldBirthDate, @fldStatus, @fldMashmul, @fldNesbat, @fldCodeMeli, @fldSh_Shenasname, @fldFatherName, @fldUserId, GETDATE(), @fldDesc,@fldTarikhEzdevaj,@fldNesbatShakhs,@fldMashmoolPadash,@fldTarikhTalagh
	if (@@ERROR<>0)
		ROLLBACK
	else if(@fldStatus=2 and @fldNesbatShakhs=1 AND @fldTarikhTalagh<>'')
	begin
		declare @fldMid int
		select @fldMid=isnull(max(fldId),0)+1  FROM   [Prs].[tblMohaseleen] 
		INSERT INTO [Prs].[tblMohaseleen] ([fldId], [fldAfradTahtePoosheshId], [fldTarikh], [fldUserId], [fldDate])
		SELECT @fldMId, @fldId, cast( REPLACE(@fldTarikhTalagh,'/','') as int), @fldUserId, GETDATE()
	
		if (@@error<>0)
			rollback
		 
	end
	COMMIT


GO
