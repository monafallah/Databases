SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Com].[spr_UpdateOrder]
@fieldName nvarchar(50),
@Id int ,
@orderId int
as 
begin tran
if (@fieldName='TypeKhodro')
	update tblTypeKhodro
	set fldorder=@orderId
	where fldid=@Id


commit 
GO
