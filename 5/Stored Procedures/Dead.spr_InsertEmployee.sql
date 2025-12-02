SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_InsertEmployee]
@fldEmployeeId int out,
@fldCodeMeli nvarchar(10),
@fldCodeMoshakhase nvarchar(20),
@fldName nvarchar(100),
@fldFamily nvarchar(150),
@fldSh_Sh nvarchar(10),
@fldFatherName nvarchar(100),
@fldUserId int,
@fldDesc nvarchar(100),
@fldIP nvarchar(15)
as 
begin tran
declare  @iddetail int
set @fldName=com.fn_TextNormalize(@fldName)
set @fldFamily=com.fn_TextNormalize(@fldFamily)
set @fldFatherName=com.fn_TextNormalize(@fldFatherName)
set @fldDesc=com.fn_TextNormalize(@fldDesc)

if (@fldCodeMeli<>'' and @fldCodeMeli is not null)
select @fldEmployeeId=fldid from com.tblEmployee where fldCodemeli=@fldCodeMeli 

else if (@fldCodeMoshakhase<>''and @fldCodeMoshakhase is not null)

select @fldEmployeeId=fldid from com.tblEmployee where  fldCodeMoshakhase=@fldCodeMoshakhase

if (@fldEmployeeId  is null)
begin
	select @fldEmployeeId=isnull(max(fldid),0)+1 from com.tblEmployee 
	insert into com.tblEmployee(fldid,fldName,fldFamily,fldCodemeli,fldStatus,fldCodeMoshakhase,fldTypeShakhs,fldUserid,fldDesc,fldDate)
	select @fldEmployeeId,@fldName,@fldFamily,@fldCodeMeli,1,@fldCodeMoshakhase,0,@fldUserId,@fldDesc,getdate()
	if (@@error<>0)
		rollback
	else
	begin
	select @iddetail=isnull(max(fldid),0)+1 from com.tblEmployee_Detail 
	insert into com.tblEmployee_Detail(fldid,fldEmployeeId,fldFatherName,fldUserId,flddate,fldDesc,fldSh_Shenasname) 
	select @iddetail,@fldEmployeeId,@fldFatherName,@fldUserId,getdate(),@fldDesc,@fldSh_Sh
	if (@@error<>0)
		rollback
	end

end
else 
begin
		update com.tblEmployee 
		set fldName=@fldName,fldFamily=@fldFamily,fldCodemeli=@fldCodeMeli,fldCodeMoshakhase=@fldCodeMoshakhase
		,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=getdate()
		where fldid=@fldEmployeeId
		if (@@error<>0)
			rollback
		else
		begin
			if exists (select * from com.tblEmployee_Detail where fldEmployeeId=@fldEmployeeId)
			begin
				update com.tblEmployee_Detail
				set fldFatherName=@fldFatherName,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=getdate(),fldSh_Shenasname=@fldSh_Sh
				where fldEmployeeId=@fldEmployeeId
				if (@@error<>0)
					rollback
			end

			else 
			begin
				select @iddetail=isnull(max(fldid),0)+1 from com.tblEmployee_Detail 
				insert into com.tblEmployee_Detail(fldid,fldEmployeeId,fldFatherName,fldUserId,flddate,fldDesc,fldSh_Shenasname) 
				select @iddetail,@fldEmployeeId,@fldFatherName,@fldUserId,getdate(),@fldDesc,@fldSh_Sh
				if (@@error<>0)
					rollback 
			end
		end
end
commit tran
GO
