SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [BUD].[Spr_TafrighFinal2]
@aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azsanad int,@tasanad int,@sanadtype tinyint
as
exec [BUD].[Spr_TafrighFinal]   @aztarikh,@tatarikh,@salmaliID,@organid,@azsanad,@tasanad,@sanadtype
GO
