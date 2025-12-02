SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[prs_InsertCheckIntoSanad](@idcheck int ,@fldUserId int,@tarikh varchar(10))
as 
begin try
begin tran
declare @sal smallint,@salmaliid int,@fldip varchar(15)='',@IdError int ,@idshobe int,@fldOrganId int,@fldTypeSanad tinyint,@fldDesc nvarchar(max)=''
select @fldOrganId=fldOrganId,@fldTypeSanad=fldTypeSanad,@fldDesc=fldDesc from drd.tblCheck where fldid=@idcheck

set @sal=substring(dbo.Fn_AssembelyMiladiToShamsi(getdate()),1,4)
	select @salmaliid=fldid from acc.tblFiscalYear where fldOrganId=@fldOrganId and fldYear=@sal
	
	select top(1)@fldip=fldIP from  com.tblInputInfo where fldUserID=@fldUserId
	order by fldid desc

if exists (	select * from com.tblModule_Organ where fldOrganId=@fldOrganId and fldModuleId=10) and @fldTypeSanad=0

	exec [ACC].[spr_DocumentInsert_Daramadcheck] @salmaliid,@idcheck,@fldOrganId,@fldDesc,@fldip,@fldUserId,10,12,@tarikh

select 0 as ErrorCode,'' as ErrorMsg

	COMMIT
end try
begin catch

rollback

select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'spr_DocumentInsert_DaramadCheck',getdate() from com.tblUser where fldid=@fldUserId
	select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage

end catch 
GO
