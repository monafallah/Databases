SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArze_DetailInsert] 
   
    @fldHeaderId int,
    @fldParametrSabetCodeDaramd int,
    @fldValue nvarchar(200),
	@fldFlag bit,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  
    @fldIP varchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldValue=com.fn_TextNormalize(@fldValue)

	declare @sh_CodeDaramadid int
	declare @fldID int 
	/*پارامتر های ثابت یه کد درامد اینزرت میشد */

	select @sh_CodeDaramadid=fldShomareHesabCodeDaramadId from [Weigh].tblArze
	where fldid=@fldHeaderId 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblArze_Detail] 
	
	INSERT INTO [Weigh].[tblArze_Detail] ([fldId], [fldHeaderId], [fldParametrSabetCodeDaramd], [fldValue], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldFlag)
	
	select row_number()over (order by p.fldid )+@fldid,@fldHeaderId,p.fldid,n.fldValue,@fldUserId,@fldOrganId,@fldDesc,getdate(),@fldIP,0
	 from drd.tblParametreSabet p
	 cross apply (select top(1) n.fldValue from  drd.tblParametreSabet_Nerkh n
					 where p.fldid=n.fldParametreSabetId and com.ShamsiToMiladi(fldTarikhFaalSazi)<=getdate()
					order by fldTarikhFaalSazi desc)n
	--inner join drd.tblParametreSabet p on p.fldid=n.fldParametreSabetId
	where fldShomareHesabCodeDaramadId=@sh_CodeDaramadid 
	and fldTypeParametr=0 and not exists (select * from  [Weigh].[tblArze_Detail] a
	where fldHeaderId=@fldHeaderId and a.fldParametrSabetCodeDaramd=p.fldid and fldOrganId=@fldOrganId)


	if (@@ERROR<>0)
		
		rollback
--------------------------------------------------

	else
	begin

	
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblArze_Detail] 

	INSERT INTO [Weigh].[tblArze_Detail] ([fldId], [fldHeaderId], [fldParametrSabetCodeDaramd], [fldValue], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldFlag)
	SELECT @fldId, @fldHeaderId, @fldParametrSabetCodeDaramd, @fldValue, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP,@fldFlag
	if(@@Error<>0)
        rollback   
	end	    
	COMMIT
GO
