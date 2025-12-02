SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblPishbiniSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldpishbiniId], [fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], P.fldDate, p.fldUserId
	,fldMotammamId,cd.fldTitle
	FROM   [BUD].[tblPishbini] P inner join acc.tblCoding_Details CD on P.fldCodingAcc_DetailsId=cd.fldId 
	WHERE  fldpishbiniId=@value
	
	if (@fieldname='fldCodingAcc_DetailsId_CodingBudje_DetailsId')
	SELECT top(@h)[fldpishbiniId], [fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], p.fldDate, p.fldUserId
	,fldMotammamId,cd.fldTitle
	FROM   [BUD].[tblPishbini] p inner join acc.tblCoding_Details CD on p.fldCodingAcc_DetailsId=cd.fldId 
	WHERE  fldCodingAcc_DetailsId=@value 
		and (( @value2 is null and  fldCodingBudje_DetailsId is null) or fldCodingBudje_DetailsId=@value2)

	if (@fieldname='')
	SELECT  top(@h) [fldpishbiniId], [fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], p.fldDate, p.fldUserId 
	,fldMotammamId,cd.fldTitle
	FROM   [BUD].[tblPishbini] p inner join acc.tblCoding_Details CD on p.fldCodingAcc_DetailsId=cd.fldId  
	


	COMMIT
GO
