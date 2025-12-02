SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudje_khedmatDarsadIdSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje

	WHERE  [fldBudje_khedmatDarsadId]=@value

	if (@fieldname='fldCodingAcc_detailId')
	SELECT top(@h)[fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	WHERE  fldCodingAcc_detailId=@value
	
	if (@fieldname='fldCodingAcc_detailId_Darsad')
	SELECT [fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId],
sum([fldDarsad]) over (partition by [fldCodingAcc_detailId]) as [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	WHERE  fldCodingAcc_detailId=@value

	if (@fieldname='fldCodingBudje_DetailsId')
	SELECT top(@h)[fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	WHERE  fldCodingBudje_DetailsId=@value

	if (@fieldname='fldTitleAcc')
	SELECT top(@h)* from (select [fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	)t
	WHERE  fldTitleAcc like @value


	if (@fieldname='fldCodeAcc')
	SELECT top(@h)* from (select [fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	)t
	WHERE  fldCodeAcc like @value


	if (@fieldname='fldTitleBudje')
	SELECT top(@h)* from (select [fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	)t
	WHERE  fldTitleBudje like @value


	if (@fieldname='fldCodeBudje')
	SELECT top(@h)* from (select [fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	)t
	WHERE  fldCodeBudje like @value


	if (@fieldname='fldCodingBudje_DetailsId')
	SELECT top(@h)[fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	WHERE  [fldCodingBudje_DetailsId]=@value
	
	if (@fieldname='')
SELECT top(@h)[fldBudje_khedmatDarsadId], [fldCodingAcc_detailId], [fldCodingBudje_DetailsId], [fldDarsad], [fldDate], [fldUserId] 
	,isnull(acc.fldTitle,'') as fldTitleAcc,isnull(acc.fldCode,'') as fldCodeAcc,isnull(budje.fldTitle,'') as fldTitleBudje,isnull(budje.fldBudCode,'') as fldCodeBudje 
	FROM   [BUD].[tblBudje_khedmatDarsadId] 
	outer apply (select c.fldTitle,c.fldCode from acc.tblCoding_Details c where  c.fldid=fldCodingAcc_detailId)Acc
	outer apply (select c.fldTitle,c.fldBudCode from bud.tblCodingBudje_Details c where  c.fldCodeingBudjeId=[fldCodingBudje_DetailsId])budje
	


	COMMIT
GO
