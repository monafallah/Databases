SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [Prs].[spr_RptAfradTahtePoosheshForBimeTakmili]( @Year smallint,@CostCenterId int,@ChartOrganId int,@OrganId INT)
as
--declare @Year smallint=1402,@CostCenterId int=0,@ChartOrganId int=0,@OrganId INT=1

select * from (
SELECT     @Year as fldYear,  Pay_tblPersonalInfo.fldPrs_PersonalInfoId as fldPersonalId,e.fldFamily+'_'+e.fldName as fldNamePersonel,e.fldFamily+'_'+e.fldName as fldName,e.fldCodemeli as fldCodeMeli,
                      d.fldTarikhTavalod as fldBirthDate,d.fldFatherName, N'عادی'AS fldStatusName, N'بله'  AS fldMashmulName, 
                      N'سرپرست'  AS fldNameNesbat,d.fldTarikhTavalod
					  ,isnull((select stuff((select ','+fldTarikhEzdevaj from prs.tblAfradTahtePooshesh as a where a.fldPersonalId=Prs_tblPersonalInfo.fldId and a.fldNesbatShakhs=2 for xml path('')),1,1,'')),'') as fldTarikhEzdevaj
					  ,0 as fldNesbat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId INNER JOIN
						 COM.tblEmployee AS E ON E.fldId=Prs_tblPersonalInfo.fldEmployeeId inner join
						 com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
                      WHERE Com.fn_OrganId( Prs.Prs_tblPersonalInfo.fldId) =@OrganId  
					  and (@CostCenterId=0 or  fldCostCenterId=@CostCenterId)
					  and (@ChartOrganId=0 or  fldChartOrganId=@ChartOrganId)
					    AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
					
union all
SELECT     @Year as fldYear , Prs.tblAfradTahtePooshesh.fldPersonalId,e.fldFamily+'_'+e.fldName as fldNamePersonel,  Prs.tblAfradTahtePooshesh.fldFamily+'_'+Prs.tblAfradTahtePooshesh.fldName collate Persian_100_CI_AI, Prs.tblAfradTahtePooshesh.fldCodeMeli  collate Persian_100_CI_AI,
                      Prs.tblAfradTahtePooshesh.fldBirthDate, Prs.tblAfradTahtePooshesh.fldFatherName  collate Persian_100_CI_AI
					  , CASE WHEN (tblAfradTahtePooshesh.fldStatus = 1) 
                      THEN N'عادی' WHEN (tblAfradTahtePooshesh.fldStatus = 2) THEN N'محصل' WHEN (tblAfradTahtePooshesh.fldStatus = 3) THEN N'بیمار' END AS fldStatusName, CASE WHEN (fldMashmul = 1) 
                      THEN N'بله' ELSE N'خیر' END AS fldMashmulName, 
                      CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
                       AS fldNameNesbat,fldBirthDate,isnull(fldTarikhEzdevaj,'') as fldTarikhEzdevaj,fldNesbatShakhs
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.tblAfradTahtePooshesh INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Prs.tblAfradTahtePooshesh.fldPersonalId = Prs.Prs_tblPersonalInfo.fldId ON 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId INNER JOIN
						 COM.tblEmployee AS E ON E.fldId=Prs_tblPersonalInfo.fldEmployeeId
                      WHERE Com.fn_OrganId(tblAfradTahtePooshesh.fldPersonalId) =@OrganId 
					  and (@CostCenterId=0 or  fldCostCenterId=@CostCenterId)
					  and (@ChartOrganId=0 or  fldChartOrganId=@ChartOrganId)
					    AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1)t
						--where fldPersonalId=37
					  order by fldNesbat,fldNamePersonel,fldName,fldPersonalId


					 
GO
