SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE function [dbo].[Fn_LimitationType_User] (@UserId int)
returns nvarchar(500)
begin
	declare @Lim nvarchar(500)=''
	select top(1) @Lim=@Lim+N'محدودیت زمانی، ' from tblLimitationTime where fldUserLimId=@UserId
	select  top(1) @Lim=@Lim+N'محدودیت IP، ' from tblLimitationIP where fldUserLimId=@UserId
	select  top(1) @Lim=@Lim+N'محدودیت سخت افزاری،' from tblLimitationMacAddress where fldUserLimId=@UserId

	--if(len(@lim)=1)
	set @Lim=''
	return  @Lim
end
GO
