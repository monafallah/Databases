SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[Fn_LimitationUser] (@UserId int)
returns nvarchar(500)
begin
	declare @Lim nvarchar(500)=''
	select @Lim=@Lim+fldRoozHafte+N' '+FORMAT(fldAzSaat ,'####/##/##')+N'-'+FORMAT(fldTaSaat,'####/##/##')+N'، ' from tblLimitationTime where fldUserLimId=@UserId
	select @Lim=@Lim+fldIPValid+N'، ' from tblLimitationIP where fldUserLimId=@UserId
	select @Lim=@Lim+fldMacValid+N'، ' from tblLimitationMacAddress where fldUserLimId=@UserId
	--SET @Lim=''
	RETURN @Lim
end
GO
