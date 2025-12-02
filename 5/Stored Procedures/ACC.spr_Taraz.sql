SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--USE [RasaNewFMS]
--GO
--/****** Object:  StoredProcedure [ACC].[spr_Taraz]    Script Date: 8/15/2023 10:50:00 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE proc [ACC].[spr_Taraz]
  @aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azLevel int,@tanLevel int,@azsanad int,@tasanad int,@StartNodeID int,@sanadtype tinyint
 as
 begin
 --select @aztarikh='1402/01/01',@tatarikh='1402/05/31',@salmaliID=5,@organid=1,
--@StartNodeID=0,@azLevel=1,@tanLevel=6,@sanadtype=2

declare @t table(fldHid hierarchyid,fldcode varchar(100),fldLevelId int,fldTitle nvarchar(300),fldid int, bed_g bigint, bes_g bigint, bed_m bigint, bes_m bigint,bed bigint,bes bigint,mbed bigint,mbes bigint, fldCaseName nvarchar(300),fldflag bit,fldCaseTypeId int)
insert into @t
exec [ACC].[spr_Taraz_main]  @aztarikh,@tatarikh, @salmaliID ,@organid ,
 @azLevel ,@tanLevel ,@azsanad ,@tasanad,@StartNodeID,@sanadtype
 select fldcode,fldLevelId,fldTitle,fldid, bed_g, bes_g, bed_m, bes_m,bed,bes,mbed,mbes, fldCaseName,fldflag from @t
end
GO
