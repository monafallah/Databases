SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblElamAvarez_ModuleOrganInsert] 
  
    @fldElamAvarezId int,
    @fldCodeDaramdElamAvarezId int,
    @Id int,

    @fldUserId int,
   
    @fldIP varchar(16),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,    @fldModulOrganId int

	select @fldModulOrganId=fldid from com.tblModule_Organ m 
	cross apply (select v.fldOrganId from Weigh.tblVazn_Baskool v
					where fldid=@Id)baskool
	where fldModuleId=16 and baskool.fldOrganId=m.fldOrganId/*ماژول باسکول*/


	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblElamAvarez_ModuleOrgan] 

	INSERT INTO [Weigh].[tblElamAvarez_ModuleOrgan] ([fldId], [fldElamAvarezId], [fldCodeDaramdElamAvarezId], [Id], [fldModulOrganId], [fldUserId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldElamAvarezId, @fldCodeDaramdElamAvarezId, @Id, @fldModulOrganId, @fldUserId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
