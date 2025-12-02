SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAfradTahtePoosheshUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldName nvarchar(100),
    @fldFamily nvarchar(100),
    @fldBirthDate nvarchar(10),
    @fldStatus tinyint,
    @fldMashmul bit,
    @fldNesbat tinyint,
    @fldCodeMeli com.Codemeli,
    @fldSh_Shenasname nvarchar(10),
    @fldFatherName nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTarikhEzdevaj nvarchar(10),
	@fldNesbatShakhs tinyint,
	@fldMashmoolPadash bit,
	@fldTarikhTalagh	varchar(10)	

AS 
	BEGIN TRAN
		SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldFamily=Com.fn_TextNormalize(@fldFamily)
	SET @fldFatherName=Com.fn_TextNormalize(@fldFatherName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	if(@fldPersonalId<>0)
		UPDATE [Prs].[tblAfradTahtePooshesh]
		SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldName] = @fldName, [fldFamily] = @fldFamily, [fldBirthDate] = @fldBirthDate, [fldStatus] = @fldStatus, [fldMashmul] = @fldMashmul, [fldNesbat] = @fldNesbat, [fldCodeMeli] = @fldCodeMeli, [fldSh_Shenasname] = @fldSh_Shenasname, [fldFatherName] = @fldFatherName, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
		,fldTarikhEzdevaj=@fldTarikhEzdevaj,fldNesbatShakhs=@fldNesbatShakhs,fldMashmoolPadash=@fldMashmoolPadash
		,fldTarikhTalagh=@fldTarikhTalagh
		WHERE  [fldId] = @fldId
	else
		UPDATE [Prs].[tblAfradTahtePooshesh]
		SET     [fldStatus] = @fldStatus ,fldTarikhTalagh=@fldTarikhTalagh
		WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
