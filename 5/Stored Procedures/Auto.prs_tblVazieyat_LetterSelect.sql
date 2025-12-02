SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[prs_tblVazieyat_LetterSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)v.[fldId], v.[fldLetterId], v.[fldStatusId], v.[fldTarikh], v.[fldDate], v.[fldUserId] 
	,s.fldName as fldStatusName
	FROM   [Auto].[tblVazieyat_Letter]v
	inner join auto.tblLetterStatus s on s.fldid=fldStatusId
	WHERE  v.fldId=@value
	

	if (@fieldname='fldLetterId')
	SELECT top(@h)v.[fldId], v.[fldLetterId], v.[fldStatusId], v.[fldTarikh], v.[fldDate], v.[fldUserId] 
	,s.fldName as fldStatusName
	FROM   [Auto].[tblVazieyat_Letter]v
	inner join auto.tblLetterStatus s on s.fldid=fldStatusId
	WHERE  v.fldLetterId=@value
	

	if (@fieldname='fldStatusId')
	SELECT top(@h)v.[fldId], v.[fldLetterId], v.[fldStatusId], v.[fldTarikh], v.[fldDate], v.[fldUserId] 
	,s.fldName as fldStatusName
	FROM   [Auto].[tblVazieyat_Letter]v
	inner join auto.tblLetterStatus s on s.fldid=fldStatusId
	WHERE  v.fldStatusId=@value
	

	if (@fieldname='')
		SELECT top(@h)v.[fldId], v.[fldLetterId], v.[fldStatusId], v.[fldTarikh], v.[fldDate], v.[fldUserId] 
	,s.fldName as fldStatusName
	FROM   [Auto].[tblVazieyat_Letter]v
	inner join auto.tblLetterStatus s on s.fldid=fldStatusId
	


	COMMIT
GO
