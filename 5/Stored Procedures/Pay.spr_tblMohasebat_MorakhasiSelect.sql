SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_MorakhasiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Morakhasi] 
	WHERE  fldId = @Value AND  Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Morakhasi] 
	WHERE  fldDesc LIKE @Value

if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Morakhasi] 
	WHERE  fldYear= @Value AND  Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Morakhasi] 
	where  Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'All')
	SELECT top(@h) [fldId], [fldPersonalId], [fldTedad], [fldMablagh], [fldMonth], [fldYear], [fldNobatPardakht], [fldSalHokm], [fldHokmId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Morakhasi]

	COMMIT
GO
