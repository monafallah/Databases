SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_ChangeLetter]
--WITH ENCRYPTION
AS 

EXEC sp_rename 'drd.tblElamAvarez' ,'tblLetter'
EXEC sp_rename 'drd.spr_tblElamAvarezDelete','spr_tblLetterDelete'
EXEC sp_rename 'drd.spr_tblElamAvarezInsert','spr_tblLetterInsert'
EXEC sp_rename 'drd.spr_tblElamAvarezSelect','spr_tblLetterSelect'
EXEC sp_rename 'drd.spr_tblElamAvarezUpdate','spr_tblLetterUpdate'

SELECT 1 AS flag
GO
