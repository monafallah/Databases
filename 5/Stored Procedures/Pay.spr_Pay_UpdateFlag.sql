SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_UpdateFlag](@fieldName NVARCHAR(50),@type tinyint,@Sal SMALLINT,@mah TINYINT,@nobat TINYINT,@MarhalePardakht tinyint,@organId INT,@userId int,@ip varchar(15),@CalcType tinyint)
AS
--type=1 بستن حقوق
--type=2 دیسکت بیمه
--type=3 کارکرد ماهانه
--type=4 دیسکت دارایی
--type=5 دیسکت بانک
begin try
begin tran

DECLARE @r NVARCHAR(6)='',@flag BIT=0,@idlog int,@IdError int
IF(@fieldName='KarKardMahane')
begin

	if(@type=5)--دیسکت بانک
	begin
		
		UPDATE Pay.tblMohasebat
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		and fldCalcType=1
		if(@@ROWCOUNT>0)
			set @flag=1
	end
	if(@type=4)--دیسکت دارایی
	begin
		
		UPDATE Pay.tblMohasebat
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		and fldCalcType=1
		if(@@ROWCOUNT>0)
			set @flag=1
	end
	if(@type=3  or @type=2)--کارکرد ماهانه  و دیسکت بیمه
	begin
		
		UPDATE Pay.tblKarKardeMahane
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMah=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblMohasebat
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		if(@@ROWCOUNT>0)
			set @flag=1
		
		UPDATE Pay.tblMamuriyat
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblMohasebat_Mamuriyat
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblEtelaatEydi
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND  fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblMohasebat_Eydi
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblEzafeKari_TatilKari
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		

		UPDATE Pay.tblMohasebatEzafeKari_TatilKari
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		
		UPDATE Pay.tblMorakhasi
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblMohasebat_Morakhasi
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

		UPDATE Pay.tblSayerPardakhts
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		and fldMarhalePardakht=@MarhalePardakht

		UPDATE Pay.tblKomakGheyerNaghdi
		SET fldflag=1,fldUserId=@userId,fldDate=getdate()
		WHERE fldYear=@Sal AND fldMonth=@mah  AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	end
	if(@type=1)--بستن حقوق
	begin
		if(@CalcType=2)
		begin
			UPDATE Pay.tblKarKardeMahane
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMah=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
			
			UPDATE Pay.tblMohasebat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
			
			if(@@ROWCOUNT>0)
				set @flag=1

			UPDATE Pay.tblMamuriyat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Mamuriyat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblEtelaatEydi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND  fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Eydi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblEzafeKari_TatilKari
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		

			UPDATE Pay.tblMohasebatEzafeKari_TatilKari
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		
			UPDATE Pay.tblMorakhasi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Morakhasi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblSayerPardakhts
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
			and fldMarhalePardakht=@MarhalePardakht

			UPDATE Pay.tblKomakGheyerNaghdi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah  AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
				
		end
		else
		begin
			UPDATE Pay.tblMohasebat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
			and fldCalcType=@CalcType
			if(@@ROWCOUNT>0)
				set @flag=1
		end
	end
	if(@flag=1)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,1,@nobat
	end
END



IF(@fieldName='Mohasebat_Sal')
BEGIN
	SET @r=CAST(@Sal AS NVARCHAR(4))+CAST(@mah AS NVARCHAR(2))
	UPDATE Pay.tblMohasebat
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0
	AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	if(@@ROWCOUNT>0)
		set @flag=1
	UPDATE Pay.tblKarKardeMahane
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMah AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0
	AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	UPDATE Pay.tblMamuriyat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Mamuriyat
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblEtelaatEydi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE fldYear=@Sal  AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Eydi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblEzafeKari_TatilKari
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		

			UPDATE Pay.tblMohasebatEzafeKari_TatilKari
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
		
			UPDATE Pay.tblMorakhasi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblMohasebat_Morakhasi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

			UPDATE Pay.tblSayerPardakhts
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
			and fldMarhalePardakht=@MarhalePardakht

			UPDATE Pay.tblKomakGheyerNaghdi
			SET fldflag=1,fldUserId=@userId,fldDate=getdate()
			WHERE CAST(CAST(fldYear AS NVARCHAR(4))+cast(fldMonth AS NVARCHAR(2)) AS BIGINT)<CAST(@r AS BIGINT) and fldFlag=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
				
	if(@flag=1)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,1,@nobat
	end
END

IF(@fieldName='Eydi')
begin
UPDATE Pay.tblEtelaatEydi
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND  fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	UPDATE Pay.tblMohasebat_Eydi
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,4,@nobat
	end
END
IF(@fieldName='Mamuriyat')
begin
UPDATE Pay.tblMamuriyat
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	UPDATE Pay.tblMohasebat_Mamuriyat
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,5,@nobat
	end
END
IF(@fieldName='EzafeKari')
begin
UPDATE Pay.tblEzafeKari_TatilKari
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
and fldType=1

	UPDATE Pay.tblMohasebatEzafeKari_TatilKari
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	and fldType=1
	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,2,@nobat
	end
END
IF(@fieldName='TatilKari')
begin
UPDATE Pay.tblEzafeKari_TatilKari
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
and fldType=2

	UPDATE Pay.tblMohasebatEzafeKari_TatilKari
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	and fldType=2
	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,3,@nobat
	end
END
IF(@fieldName='Morakhasi')
begin
UPDATE Pay.tblMorakhasi
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	UPDATE Pay.tblMohasebat_Morakhasi
	SET fldflag=1,fldUserId=@userId,fldDate=getdate()
	WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId

	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,6,@nobat
	end
END
IF(@fieldName='SayerPardakht')
begin
UPDATE Pay.tblSayerPardakhts
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@nobat AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
and fldMarhalePardakht=@MarhalePardakht
	if(@@ROWCOUNT>0)
		begin
			select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
			insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
			select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,7,@nobat
		end
END

IF(@fieldName='KomakGheyerNaghdi_Mostamer')
begin
UPDATE Pay.tblKomakGheyerNaghdi
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNoeMostamer=1 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
	if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,8,@nobat
	end
END
IF(@fieldName='KomakGheyerNaghdi_GheyerMostamer')
begin
UPDATE Pay.tblKomakGheyerNaghdi
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNoeMostamer=0 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@organId
if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,9,@nobat
	end
END
IF(@fieldName='OnAccount')
begin
UPDATE Pay.tblOnAccount
SET fldflag=1,fldUserId=@userId,fldDate=getdate()
WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@nobat AND fldOrganId=@organId and fldghatei=1 and fldFlag=0

if(@@ROWCOUNT>0)
	begin
		select @idlog=isnull(max(fldid),0)+1 from [Pay].[tblLogBastanHoghugh]
		insert into  [Pay].[tblLogBastanHoghugh](fldid,fldYear,fldMonth,fldOrganId,fldType,fldDate,fldIp,fldUserId,fldTypePardakht,fldNobatPardkht)
		select @idlog,@Sal,@mah,@organId,@type,getdate(),@ip,@userId,10,@nobat
	end
END
commit
end try

begin catch

	rollback
	select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@ip,@userId,'Pay_UpdateFlag',getdate() from com.tblUser where fldid=@userId
end catch
GO
