SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_UpdatePID_kala]
(@Child int ,@Parent INT,@fldUserId int)
AS 
UPDATE Str.tblKalaTree SET fldPID=@parent,fldUserId=@fldUserId,fldDate=GETDATE() WHERE fldID=@child

GO
