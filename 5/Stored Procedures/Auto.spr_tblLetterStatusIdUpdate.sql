SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterStatusIdUpdate](@LetterId BIGINT,@LetterStatus int,@fldUserId int)
AS
begin tran
declare @id bigint =0
select @id=isnull( max(fldid),0)+1 from auto.tblVazieyat_Letter
insert into  auto.tblVazieyat_Letter(fldid,fldletterid,fldStatusId,fldTarikh,fldDate,fldUserId)
select @id ,@LetterId,@LetterStatus,(select fldTarikh from com.tblDateDim where flddate=cast(getdate() as date)),getdate(),@fldUserId
if (@@ERROR<>0)
 rollback

else
begin
UPDATE tblLetter SET fldLetterStatusID=@LetterStatus 
WHERE fldID=@LetterId
if (@@ERROR<>0)
 rollback
end


commit
GO
