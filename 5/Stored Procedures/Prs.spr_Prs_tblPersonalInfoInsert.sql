SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoInsert] 

    @fldEmployeeId int,
    @fldEsargariId int,
    @fldSharhEsargari nvarchar(MAX),
    @fldSh_Personali nvarchar(20),
    @fldOrganPostId int,
    @fldRasteShoghli nvarchar(50),
    @fldReshteShoghli nvarchar(50),
    @fldTarikhEstekhdam char(10),
    @fldTabaghe nvarchar(10),
    @fldSh_MojavezEstekhdam nvarchar(50),
    @fldTarikhMajavezEstekhdam char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldStatusId INT,
    @fldDateTaghirVaziyat NVARCHAR(10),
    @fldNoeEstekhdamId INT,
    @fldTarikh NVARCHAR(10),
	@fldOrganPostEjraeeId int
AS 
	
	BEGIN TRAN
	declare @fldID int 

	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldRasteShoghli=Com.fn_TextNormalize(@fldRasteShoghli)
	SET @fldReshteShoghli=Com.fn_TextNormalize(@fldReshteShoghli)
	SET @fldSharhEsargari=Com.fn_TextNormalize(@fldSharhEsargari)
	DECLARE @flag BIT=0,@IDPersonalStatus INT,@IdHistory int
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[Prs_tblPersonalInfo] 
	INSERT INTO [Prs].[Prs_tblPersonalInfo] ([fldId], [fldEmployeeId], [fldEsargariId], [fldSharhEsargari], [fldSh_Personali], [fldOrganPostId], [fldRasteShoghli], [fldReshteShoghli], [fldTarikhEstekhdam],  [fldTabaghe], [fldSh_MojavezEstekhdam], [fldTarikhMajavezEstekhdam], [fldUserId], [fldDesc], [fldDate],fldOrganPostEjraeeId)
	SELECT @fldId, @fldEmployeeId,@fldEsargariId, @fldSharhEsargari, @fldSh_Personali,@fldOrganPostId, @fldRasteShoghli, @fldReshteShoghli, @fldTarikhEstekhdam, @fldTabaghe, @fldSh_MojavezEstekhdam, @fldTarikhMajavezEstekhdam, @fldUserId, @fldDesc, GETDATE()	,@fldOrganPostEjraeeId
	IF(@@ERROR<>0)
	IF (@flag=0)
	BEGIN
		select @IDPersonalStatus =ISNULL(max(fldId),0)+1 from [Com].[tblPersonalStatus] 
		INSERT INTO Com.tblPersonalStatus( fldId ,fldStatusId ,fldPrsPersonalInfoId ,fldPayPersonalInfoId ,fldDateTaghirVaziyat ,fldUserId ,fldDesc ,fldDate)
		SELECT @IDPersonalStatus,@fldStatusId,@fldID,NULL,@fldTarikhEstekhdam,@fldUserId,@fldDesc,GETDATE()
	if (@@ERROR<>0)
	begin
		ROLLBACK
		SET @flag=1
		
	END
	end
	IF (@flag=0)
	BEGIN
		SELECT @IdHistory =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
		INSERT INTO Prs.tblHistoryNoeEstekhdam( fldId ,fldNoeEstekhdamId ,fldPrsPersonalInfoId ,fldTarikh ,fldUserId ,fldDesc ,fldDate)
		SELECT @IdHistory,@fldNoeEstekhdamId,@fldId,@fldTarikh,@fldUserId,@fldDesc,GETDATE()
	
   	if (@@ERROR<>0)
		ROLLBACK
	declare  @code int,
    @name nvarchar(30) = NULL,
    @family nvarchar(50) = NULL,
    @nafater nvarchar(30) = NULL,
    @shsh nvarchar(15) = NULL,
    @codemeli nvarchar(15) = NULL,
    @tt nvarchar(10) = NULL,
    @enabled bit = NULL,
    @mahaletavalod nvarchar(100) = NULL,
    @msudor nvarchar(100) = NULL,
    @tahol int = NULL,
    @vazife int = NULL
   

	IF exists (select * from com.tblGeneralSetting where fldId=7 and  @flag=0)
		BEGIN
			select @name=e.fldName,@family=fldFamily,@nafater=fldFatherName,@shsh=fldSh_Shenasname,@codemeli=fldCodemeli,@tt=fldTarikhTavalod
			,@enabled=@IDPersonalStatus,@mahaletavalod=c.fldName,@msudor=c2.fldName,@vazife=fldNezamVazifeId
			from com.tblEmployee as e
			inner join com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
			left join com.tblCity as c on c.fldId=fldMahalTavalodId
			left join com.tblCity as c2 on c2.fldId=fldMahalSodoorId
			where e.fldId=@fldEmployeeId

			INSERT INTO hoghugh.[dbo].[personel] ([code], [name], [family], [nafater], [shsh], [codemeli], [tt], [enabled], [mahaletavalod], [msudor])
			SELECT @code, @name, @family, @nafater, @shsh, @codemeli, @tt, @enabled, @mahaletavalod, @msudor
			if (@@ERROR<>0)
				ROLLBACK
		end
END
	COMMIT
GO
