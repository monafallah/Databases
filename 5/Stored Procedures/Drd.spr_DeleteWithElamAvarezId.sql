SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_DeleteWithElamAvarezId](@id int,@fldUserID int)
as

UPDATE drd.tblParametreSabet_Value
SET fldUserId=@fldUserID,fldDate=GETDATE()
WHERE fldElamAvarezId = @Id

DELETE
	FROM   drd.tblParametreSabet_Value
	WHERE  fldElamAvarezId = @Id
	declare @flag bit=0
if(@@Error<>0)
 begin
	 set @flag=1
	 Rollback
end
if(@flag=0)
 Begin 
 UPDATE [Drd].[tblCodhayeDaramadiElamAvarez]
SET fldUserId=@fldUserID,fldDate=GETDATE()
WHERE fldElamAvarezId = @Id
 
DELETE
	FROM   [Drd].[tblCodhayeDaramadiElamAvarez]
	WHERE  fldElamAvarezId = @Id
if(@@ERROR<>0)
BEGIN
	   Set @flag=1
	   Rollback
END
end
if(@flag=0)
 Begin 
  UPDATE  [Drd].[tblElamAvarez]
SET fldUserId=@fldUserID,fldDate=GETDATE()
WHERE   fldId = @Id
 
DELETE
	FROM   [Drd].[tblElamAvarez]
	WHERE  fldId = @Id
if(@@ERROR<>0)
BEGIN
	   Set @flag=1
	   Rollback
END
end


GO
