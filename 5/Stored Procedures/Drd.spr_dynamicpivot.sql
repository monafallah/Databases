SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_dynamicpivot]
@ElamAvarezId INT
AS
BEGIN TRAN
DECLARE @AVAIABLE_TO_PIVOT NVARCHAR(MAX),@cols AS NVARCHAR(MAX),
@query  AS NVARCHAR(MAX)

SELECT @cols = STUFF((SELECT   ',' +  Drd.tblParametreSabet.fldNameParametreEn
FROM         Drd.tblParametreSabet INNER JOIN
                         Drd.tblParametreSabet_Value ON Drd.tblParametreSabet.fldId = Drd.tblParametreSabet_Value.fldParametreSabetId
						WHERE fldElamAvarezId=@ElamAvarezId
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

SELECT @query = 
'SELECT * FROM
(SELECT   Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet_Value.fldValue
FROM         Drd.tblParametreSabet INNER JOIN
                         Drd.tblParametreSabet_Value ON Drd.tblParametreSabet.fldId = Drd.tblParametreSabet_Value.fldParametreSabetId
						WHERE fldElamAvarezId=27)X
PIVOT 
(
    min(fldValue)
    for [fldNameParametreEn] in (' + @cols + ')
) P'
declare @TAB AS TABLE(COL NVARCHAR(MAX) )

--INSERT INTO @TAB 
--EXEC SP_EXECUTESQL @cols,@query
--INSERT INTO @TAB 
EXECUTE(@query)
COMMIT TRAN

GO
