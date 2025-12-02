SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[fn_IdReplyTaghsit](@value INT)
RETURNS INT
AS
BEGIN
DECLARE @id INT
SELECT    @id= Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId
FROM         Drd.tblReplyTaghsit INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
                      WHERE tblReplyTaghsit.fldId=@value
RETURN @id
end
GO
