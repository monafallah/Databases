SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[sp_tblLetterStatusIdUpdate](@LetterId BIGINT,@LetterStatus int)
AS
UPDATE tblLetter SET fldLetterStatusID=@LetterStatus WHERE fldID=@LetterId
GO
