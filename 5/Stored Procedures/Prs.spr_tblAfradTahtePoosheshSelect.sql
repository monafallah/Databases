SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAfradTahtePoosheshSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@organId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  fldId = @Value AND Com.fn_OrganId(fldPersonalId)=@organId
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  fldDesc LIKE @Value
                        order by [Prs].[tblAfradTahtePooshesh].fldId desc
	
	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh]  
	WHERE  fldPersonalId = @Value AND Com.fn_OrganId(fldPersonalId)=@organId
                        order by [Prs].[tblAfradTahtePooshesh].fldId desc
	
	if (@fieldname=N'Mohassel')
	begin
		declare @Year varchar(10)=cast(@h as varchar(4))
		SELECT a.[fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], a.[fldUserId], a.[fldDate], [fldDesc] 
		, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
		,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
		,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
		,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName
		,coalesce(format( m.fldTarikh,'####/##/##'),'') as fldTarikhTalagh
		FROM   [Prs].[tblAfradTahtePooshesh]  as a
		left join prs.tblMohaseleen as m on m.fldAfradTahtePoosheshId=a.fldId and SUBSTRING(cast(fldTarikh as varchar(10)),1,4)=@Year
		WHERE  fldPersonalId = @Value and fldNesbatShakhs=1 
	end

	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  fldPersonalId = @Value
	
		if (@fieldname=N'CheckCodeMeli')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  fldCodeMeli = @Value 
	
	
	if (@fieldname=N'fldCodeMeli')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  fldCodeMeli = @Value AND Com.fn_OrganId(fldPersonalId)=@organId
                        order by [Prs].[tblAfradTahtePooshesh].fldId desc
	
	if (@fieldname=N'ALL')
		SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
                        order by [Prs].[tblAfradTahtePooshesh].fldId desc
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldName], [fldFamily], [fldBirthDate], [fldStatus], [fldMashmul], [fldNesbat], [fldCodeMeli], [fldSh_Shenasname], [fldFatherName], [fldUserId], [fldDate], [fldDesc] 
	, CASE WHEN (fldStatus = 1) THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName
	,CASE WHEN (fldMashmul = 1) THEN N'بله' ELSE N'خیر' END AS fldMashmulName
	,CASE WHEN fldNesbat=1 THEN N'فرزند' WHEN fldNesbat=2 THEN N'همسر' WHEN fldNesbat=3 THEN N'تحت تکفل(تبعی3)'  WHEN fldNesbat=4 THEN N'مازاد(تبعی2)' WHEN fldNesbat=5 THEN N'تحت تکفل(تامین اجتماعی)' END AS fldNameNesbat
	,fldTarikhEzdevaj,fldNesbatShakhs,CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END AS fldNameNesbatShakhs,fldMashmoolPadash,case when fldMashmoolPadash=1 then N'هست' else N'نیست' end fldMashmoolPadashName,fldTarikhTalagh
	FROM   [Prs].[tblAfradTahtePooshesh] 
	WHERE  Com.fn_OrganId(fldPersonalId)=@organId 
                        order by [Prs].[tblAfradTahtePooshesh].fldId desc

	COMMIT
GO
