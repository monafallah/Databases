SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReferralRulesDelete] 
@fldPostErjaDahandeId int,
@fldOrganErjaGirande int,
@fldUserID int
AS 
	--اونهایی رو پاک کن که پست گیرنده یا چارت گیرندشون تو اون ارگان ورودی باشه
	BEGIN TRAN
	UPDATE [Auto].[tblReferralRules]
	SET    fldUserId=@fldUserId,flddate=getdate()
	 from   [Auto].[tblReferralRules]  f 
	 outer apply (select o.fldid from com.tblOrganizationalPostsEjraee o inner join 
							com.tblChartOrganEjraee c on c.fldid=o.fldChartOrganId
							where fldOrganId=@fldOrganErjaGirande)post
	outer apply (select c.fldid from com.tblChartOrganEjraee c 
	where c.fldOrganId=@fldOrganErjaGirande )chart
	WHERE  fldPostErjaDahandeId=@fldPostErjaDahandeId and (f.fldPostErjaGirandeId=post.fldid or f.fldChartEjraeeGirandeId=chart.fldid)
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE f
	  from   [Auto].[tblReferralRules]  f 
	 outer apply (select o.fldid from com.tblOrganizationalPostsEjraee o inner join 
							com.tblChartOrganEjraee c on c.fldid=o.fldChartOrganId
							where fldOrganId=@fldOrganErjaGirande)post
	outer apply (select c.fldid from com.tblChartOrganEjraee c 
	where c.fldOrganId=@fldOrganErjaGirande )chart
	WHERE  fldPostErjaDahandeId=@fldPostErjaDahandeId and (f.fldPostErjaGirandeId=post.fldid or f.fldChartEjraeeGirandeId=chart.fldid)
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
