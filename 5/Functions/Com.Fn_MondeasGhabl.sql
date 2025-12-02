SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[Fn_MondeasGhabl]( @persoanlId INT,@Monde INT,@ParamId INT,@Year SMALLINT,@month TINYINT,@Nobat TINYINt)
returns bigint
as
begin
--DECLARE @persoanlId INT=1 ,@Monde INT=20000000,@ParamId INT=92,@Year SMALLINT=1397,@month TINYINT=7,@Nobat TINYINT=1,@t BIGINT
declare @t BIGINT,@r bigint=0

SET @t=CASE WHEN LEN(@month )=1 THEN CAST(@Year AS NVARCHAR(5))+'0'+CAST(@month AS NVARCHAR(2))ELSE  CAST(@Year AS NVARCHAR(5))+CAST(@month AS NVARCHAR(2)) end
SELECT distinct @r= fldMondeGHabl-sum([tblMohasebat_kosorat/MotalebatParam].fldMablagh) over (partition by fldParametrId,fldMondeGHabl)
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId
                      WHERE tblMohasebat.fldPersonalId=@persoanlId AND fldKosoratId IS NOT NULL
					  AND fldParametrId=@ParamId AND fldMondeGHabl=@Monde AND 
					 cast( (CASE WHEN LEN(fldMonth )=1 THEN CAST(fldYear AS NVARCHAR(5))+'0'+CAST(fldMonth AS NVARCHAR(2))ELSE  CAST(fldYear AS NVARCHAR(5))+CAST(fldMonth AS NVARCHAR(2)) END)as bigint)<=@t
return @r
end
GO
