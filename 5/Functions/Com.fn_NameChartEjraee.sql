SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fn_NameChartEjraee](@idchart int)
RETURNS nvarchar(800)
AS
BEGIN
declare @name nvarchar(800)=''
;WITH temp AS (
select fldid,fldOrganId,fldTitle,fldPId,fldTitle pidname from com.tblChartOrganEjraee c1
where fldid=@idchart --where not exists (select * from com.tblChartOrganEjraee c where c.fldpid=c1.fldid)
UNION ALL
SELECT       c.fldid, c.fldOrganId,c.fldTitle,c.fldPId,t.fldTitle pidname
FROM           temp AS t INNER JOIN
                         Com.tblChartOrganEjraee AS c ON t.fldpid = c.fldid
						
          )  
		  select @name=stuff((select '_'+fldTitle from temp c1 FOR XML PATH('')),1,1,'')
		return @name 
		end
		  

		  




GO
