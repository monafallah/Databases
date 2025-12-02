SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPersonalStatusInsert] 
 
    @fldStatusId int,
    @fldPrsPersonalInfoId int,
    @fldPayPersonalInfoId int,
    @fldDateTaghirVaziyat char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@codemeli varchar(10)='',@status bit=1,@organId varchar(10)
	if(@fldStatusId>1)
	set @status=0

	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblPersonalStatus] 
	INSERT INTO  [Com].[tblPersonalStatus] ([fldId], [fldStatusId], [fldPrsPersonalInfoId], [fldPayPersonalInfoId], [fldDateTaghirVaziyat], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldStatusId, @fldPrsPersonalInfoId, @fldPayPersonalInfoId, @fldDateTaghirVaziyat, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
		else 	IF exists (select * from com.tblGeneralSetting where fldId=7 and  @fldPrsPersonalInfoId is not null)	
		begin
			select @codemeli=fldCodemeli from prs.Prs_tblPersonalInfo as p
			inner join com.tblEmployee as e on e.fldId=p.fldEmployeeId
			where p.fldId=@fldPrsPersonalInfoId

				select @OrganId= tblChartOrgan.fldOrganId from prs.Prs_tblPersonalInfo inner join
	 Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId 
					  where Prs_tblPersonalInfo.fldId=@fldPrsPersonalInfoId
declare @a varchar(50)='',@query nvarchar(max)='',@code varchar(50)='',@date varchar(50)=CONVERT(varchar(20), getdate(), 20)
		declare @setting int=0
			select @setting=fldvalue from com.tblGeneralSetting where fldId=8

			select @a=fldDBName from Auto_Hog.dbo.tblSetting where fldOrganId=@OrganId
			if(@setting=1)
		set @query='UPDATE   [PAYARCHIVE].'+@a+'.[dbo].[personel] 
		SET    [enabled] = '+case when  @status=0 then '0' else '1' end+
		+' WHERE  [codemeli] = '''+  @codemeli+''''
	ELSE 
		set @query='UPDATE  '+@a+'.[dbo].[personel] 
		SET    [enabled] = '+case when  @status=0 then '0' else '1' end+
		+' WHERE  [codemeli] = '''+  @codemeli+''''
		declare @ID int 
		execute (@query)
		IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			END	
			

		end


	COMMIT
GO
