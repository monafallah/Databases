SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE function [Drd].[fn_MablaghCode](@Id int)
returns bigint
as
begin
declare @mablagh bigint
SELECT       @mablagh=isnull(sum(fldTakhfifAsliValue*fldTedad+  fldTakhfifAvarezValue +fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue ),sum(fldAsliValue*fldtedad+ fldAvarezValue+ fldMaliyatValue+fldAmuzeshParvareshValue ) )
 
FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId


 --   @mablagh=isnull(sum(fldTakhfifAsliValue*fldTedad+  fldTakhfifAvarezValue +fldTakhfifMaliyatValue ),sum(fldAsliValue*fldtedad+ fldAvarezValue+ fldMaliyatValue ) )
where fldShomareHesabCodeDaramadId=@Id
return @mablagh
end
GO
