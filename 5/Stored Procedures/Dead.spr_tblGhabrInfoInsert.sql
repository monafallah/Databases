SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGhabrInfoInsert] 
   
    @fldName nvarchar(100),
    @fldFamily nvarchar(150),
    @fldNameFather nvarchar(100),
    @fldBDate varchar(10),
    @fldDeathDate varchar(10),
	@fldStatus tinyint,
	@fldTabaghe tinyint,
	@fldObjectId int,
	@fldGheteId int,
	@fldMeliCode nvarchar(15),
    @fldUserId int,
	@fldIP nvarchar(15),
    @fldOrganId int
AS 
	 
begin try
	BEGIN TRAN
declare @fldid int,@IdNextRecord int=0,@errorId int,@tabaghe tinyint,@stname nvarchar(50)='',@idamanat int
set @fldName=com.fn_TextNormalize(@fldName)
set @fldFamily=com.fn_TextNormalize(@fldFamily)
set @fldNameFather=com.fn_TextNormalize(@fldNameFather)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Dead].[tblGhabrInfo] 
	INSERT INTO [Dead].[tblGhabrInfo] ([fldId], [fldName], [fldFamily], [fldNameFather], [fldBDate], [fldDeathDate],fldObjectId, [fldUserId], [fldOrganId], [fldDate],fldStatus,fldTabaghe,fldGheteId,fldMeliCode )
	SELECT @fldId, @fldName, @fldFamily, @fldNameFather, @fldBDate, @fldDeathDate,@fldObjectId ,@fldUserId, @fldOrganId, getdate(),@fldStatus,@fldTabaghe,@fldGheteId ,@fldMeliCode

	if @fldStatus=3/*چون کد ملی و نام پدر نداریم نمیتونیم اسم هارو در جدول ایمپولی ذخیره کنیم */
	begin 
	select @idamanat =ISNULL(max(fldId),0)+1 from [Dead].[tblGhabreAmanat] 

	INSERT INTO [Dead].[tblGhabreAmanat] ([fldId], [fldShomareId], [fldShomareTabaghe], [fldEmployeeId], [fldOrganId], [fldTarikhRezerv], [fldUserId], [fldDesc], [fldDate], [fldIP],fldGhabrInfoId)
	SELECT @idamanat, NULL, @fldTabaghe, NULL, @fldOrganId, NULL, @fldUserId, '', GETDATE(), @fldIP,@fldId
	end




		
	select top(1) @IdNextRecord=fldid from Dead.tblGhabrInfo where fldObjectId>@fldObjectId and  fldName=''
	select @IdNextRecord as IdNextRecord



	select @tabaghe=count(*) from dead.tblGhabrInfo where fldObjectId=@fldObjectId
	
	if @tabaghe>1
	select @fldname=substring(case when @fldname=N'' then N'_'else @fldname end + N'|'+case when fldname=N'' then N'_' else fldname end,1,50)
	,@fldFamily=substring(case when @fldFamily=N'' then N'_' else @fldFamily end +N'|' +case when fldFamily=N'' then N'_' else fldFamily end,1,50) ,
	@fldNameFather=substring(case when @fldNameFather=N'' then N'_'else @fldNameFather end + N'|'+case when fldNameFather=N'' then N'_' else fldNameFather end ,1,50),
	@fldDeathDate=substring(case when @fldDeathDate=N'' then N'_'else @fldDeathDate end + N'|'+case when fldDeathDate=N'' then N'_' else fldDeathDate end ,1,50),
	@fldBDate=substring(case when @fldBDate=N'' then N'_'else @fldBDate end + N'|'+case when fldBDate=N'' then N'_' else fldBDate end ,1,50)

	from  dead.tblGhabrInfo where fldObjectId=@fldObjectId
	
	/*
	if exists (select * from dead.tblGhabrInfo
	where fldObjectId=@fldObjectId and fldStatus=3)
	begin 
	
	update AramDB.dbo.RECATANGLE_8
	set fldstatus=N'امانت',fldTabaghe=@tabaghe,fldName=@fldName,fldFamily=@fldFamily,fldNameFather=@fldNameFather,fldBDate=@fldBDate,fldDeathDate=@fldDeathDate,fldghete=@fldGheteId
	where OBJECTID=@fldObjectId
	

	end
	else if exists (select * from dead.tblGhabrInfo
	where fldObjectId=@fldObjectId and fldStatus=1)
	begin
		update AramDB.dbo.RECATANGLE_8
		set fldstatus=N'خالی',fldTabaghe=@tabaghe,fldName=@fldName,fldFamily=@fldFamily,fldNameFather=@fldNameFather,fldBDate=@fldBDate,fldDeathDate=@fldDeathDate,fldghete=@fldGheteId
		where OBJECTID=@fldObjectId
	end
	else 
	begin
		update AramDB.dbo.RECATANGLE_8
		set fldstatus=N'پر',fldTabaghe=@tabaghe,fldName=@fldName,fldFamily=@fldFamily,fldNameFather=@fldNameFather,fldBDate=@fldBDate,fldDeathDate=@fldDeathDate,fldghete=@fldGheteId
		where OBJECTID=@fldObjectId

	end
	*/
	COMMIT

	end try

	begin catch
	rollback
	select @errorId=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @errorId,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),'::1',@fldUserId,'ghabrinfoInsert',getdate() from com.tblUser where fldid=@fldUserId
	select 0 IdNextRecord			
               
	end catch
GO
