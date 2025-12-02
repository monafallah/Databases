SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Com].[spr_SelectChartEjraee_LastNode](@organId int)
as
begin tran 
select tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName,com.fn_NameChartEjraee(tblChartOrganEjraee.fldid) fldNameFather
FROM        com. tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId 
  where not exists (select * from com.tblChartOrganEjraee c where c.fldpid=tblChartOrganEjraee.fldid)
  and tblChartOrganEjraee.fldOrganId=@organId

  commit

GO
