SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[fn_IdReplyTaghsit](@idElamAvarez int)
returns int
as
begin
DECLARE @id INT,@ReplyId int

  SELECT TOP(1) @id=fldid  
  FROM Drd.tblRequestTaghsit_Takhfif WHERE   fldElamAvarezId=@idElamAvarez AND fldRequestType=1 ORDER BY tblRequestTaghsit_Takhfif.fldId DESC 
  
  IF  (EXISTS(SELECT * FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId NOT IN ( @id) )AND EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@id AND  fldTypeRequest=1 AND fldTypeMojavez=1  ) )
  BEGIN
		SELECT     @ReplyId=Drd.tblReplyTaghsit.fldId
FROM         Drd.tblReplyTaghsit INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId
                      WHERE fldRequestId=@id
  END
  ELSE 
 set  @ReplyId=0

 return @replyId
 end
GO
