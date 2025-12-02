SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MandeVam](@Year SMALLINT,@Month TINYINT,@PersonalId int)
RETURNS INT
BEGIN
DECLARE @GhestVam INT=0,@MandeVam INT=0,@VamId INT,@sal NVARCHAR(6)=''--,@mah NVARCHAR(2)=''
SELECT    @GhestVam=Pay.tblMohasebat.fldGhestVam,@VamId=fldVamId 
FROM         Pay.tblVam INNER JOIN
                      prs.Prs_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblMohasebat ON Prs_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblVam.fldId = Pay.tblMohasebat_PersonalInfo.fldVamId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE     (Pay.tblMohasebat.fldYear = @Year) AND (Pay.tblMohasebat.fldMonth = @Month) AND (Pay.tblMohasebat.fldGhestVam <> 0) and (Pay.tblMohasebat.fldPersonalId=@PersonalId)

IF (@GhestVam<>0)
BEGIN
SET @sal=CAST(@Year AS NVARCHAR(4))+cast(@Month AS NVARCHAR(2))
SELECT     @MandeVam=Pay.tblVam.fldMandeVam- SUM(Pay.tblMohasebat.fldGhestVam)
FROM         Pay.tblVam INNER JOIN
                      prs.Prs_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblMohasebat ON Prs_tblPersonalInfo.fldId = Pay.tblMohasebat.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblVam.fldId = Pay.tblMohasebat_PersonalInfo.fldVamId AND 
                      Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE    CAST( CAST(Pay.tblMohasebat.fldYear AS NVARCHAR(4))+(CAST(Pay.tblMohasebat.fldMonth AS NVARCHAR(2))) AS BIGINT)<=CAST(@sal AS BIGINT) and (Pay.tblMohasebat.fldPersonalId=@PersonalId)AND fldVamId=@VamId
GROUP BY Pay.tblVam.fldMandeVam

END 
RETURN @MandeVam
END
GO
