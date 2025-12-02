SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblVazn_BaskoolUpdate] 
    @fldId int,
    @fldPluqeId int,
    @fldRananadeId int,
    @fldNoeMasrafId tinyint = NULL,
    @fldAshkhasId int = NULL,
    @fldChartOrganEjraeeId int = NULL,
    @fldLoadingPlaceId int = NULL,
  
    @fldKalaId int = NULL,
    @fldVaznKol decimal(15,3) = NULL,
  
    @fldRemittanceId int = NULL,
    
    @fldBaskoolId int = NULL,
	@fldIsPor bit,
	@fldTypeKhodroId int ,
	@fldTedad int,
	@fldTypeMohasebe bit ,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
 
    @fldIP varchar(16)
AS 

	BEGIN TRAN
		declare  @fldVaznKhals decimal(15,3) = 0,@maxDate datetime,@v_kol decimal(15,3),@Tarikh_VaznKhali nvarchar(20)=''
		declare @TarikhOld varchar(20)='',@id_ int=0,@VaznKhals_kh decimal(15,3) = 0
if (@fldTypeMohasebe=0)
begin		
	if (@fldIsPor=0)
		begin

				select @TarikhOld=fldTarikhVaznKhali from [Weigh].[tblVazn_Baskool]  where fldid=@fldId

				update  [Weigh].[tblVazn_Baskool]
				set fldVaznKhals=fldVaznKol-@fldVaznKol--,fldTarikhVaznKhali=cast(cast(getdate()as time(0))as varchar(5))+' '+ com.MiladiTOShamsi(getdate())
				where fldIsPor=1 and fldPluqeId=@fldPluqeId and fldBaskoolId=@fldBaskoolId and fldisprint=0 and fldTarikhVaznKhali=@TarikhOld and fldOrganId=@fldOrganId
				and fldEbtal=0 and fldNoeMasrafId<>1
				if (@@error<>0)
					rollback 
				
				select @id_=max(fldid) from [Weigh].[tblVazn_Baskool] 
				where fldPluqeId=@fldPluqeId and fldIsPor=1	and fldBaskoolId=@fldBaskoolId 
				and fldOrganId=@fldOrganId and fldNoeMasrafId=1 and fldEbtal=0 and fldisprint=0

				update [Weigh].[tblVazn_Baskool]
				set fldVaznKhals=fldVaznKol-@fldVaznKol
				where fldid=@id_
				if(@@error<>0)
					rollback

					set @fldVaznKhals=0
					--set @Tarikh_VaznKhali=cast(cast(getdate()as time(0))as varchar(5))+' '+ com.MiladiTOShamsi(getdate())
				
			end
		
	else
	begin
		if (@fldNoeMasrafId=1)
			begin
				select @id_= min(fldid) from [Weigh].[tblVazn_Baskool] 
				where fldPluqeId=@fldPluqeId and fldIsPor=1	and fldBaskoolId=@fldBaskoolId 
				and fldOrganId=@fldOrganId and fldNoeMasrafId=1 and fldEbtal=0 and fldId>@fldId
				
				if (@id_ is not null and @id_ <>0)
					select @v_kol=fldVaznKol from [tblVazn_Baskool]
					cross apply (
					select min(fldid)minid from [Weigh].[tblVazn_Baskool] 
					where fldPluqeId=@fldPluqeId and fldIsPor=0	and fldBaskoolId=@fldBaskoolId 
					and fldOrganId=@fldOrganId  and fldEbtal=0 and fldId>@fldId
					)vkhali
					where fldid between minid and @id_

				else 
				
					select @v_kol=fldVaznKol from [tblVazn_Baskool]
					cross apply (
					select min(fldid)minid from [Weigh].[tblVazn_Baskool] 
					where fldPluqeId=@fldPluqeId and fldIsPor=0	and fldBaskoolId=@fldBaskoolId 
					and fldOrganId=@fldOrganId and fldEbtal=0 and fldId>@fldId
					)vkhali
					where fldid = minid 

				if (@v_kol<>0 and @v_kol is not null)
				set @fldVaznKhals=@fldVaznKol-@v_kol
			
			end	
		else
		begin	 
			select @maxDate=max(fldDateTazin) from [Weigh].[tblVazn_Baskool]  where fldPluqeId=@fldPluqeId and fldIsPor=0 and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId and fldEbtal=0
			select @v_kol= fldVaznKol,@Tarikh_VaznKhali=fldTarikhVaznKhali from [Weigh].[tblVazn_Baskool]  where fldPluqeId=@fldPluqeId and fldDateTazin=@maxDate  and fldBaskoolId=@fldBaskoolId and fldIsPor=0  and fldOrganId=@fldOrganId
			and fldEbtal=0
			if (@v_kol=0)
			begin	
				set @fldVaznKhals=0
				--set @Tarikh_VaznKhali=''
			end			
			else 

				set @fldVaznKhals=@fldVaznKol-@v_kol
		end
	end
end
else if (@fldTypeMohasebe=1)
begin

			select @maxDate=max(fldDateTazin) from [Weigh].[tblVazn_Baskool]  where fldPluqeId=@fldPluqeId and fldIsPor=1 and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId and fldEbtal=0
			select @v_kol= fldVaznKol,@Tarikh_VaznKhali=cast(cast(fldDateTazin as time (0)) as varchar(8))+' '+dbo.Fn_AssembelyMiladiToShamsi( fldDateTazin) from [Weigh].[tblVazn_Baskool]  
			where fldPluqeId=@fldPluqeId and fldDateTazin=@maxDate  and fldBaskoolId=@fldBaskoolId and fldIsPor=1  and fldOrganId=@fldOrganId
			and fldEbtal=0
			if (@v_kol=0)
			begin	
				set @fldVaznKhals=0
				--set @Tarikh_VaznKhali=''
			end			
			else 

				set @fldVaznKhals=@fldVaznKol-@v_kol
		

end	

	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Weigh].[tblVazn_Baskool]
	SET    [fldRananadeId] = @fldRananadeId, [fldNoeMasrafId] = @fldNoeMasrafId, [fldAshkhasId] = @fldAshkhasId
	, [fldChartOrganEjraeeId] = @fldChartOrganEjraeeId, [fldLoadingPlaceId] = @fldLoadingPlaceId, --[fldDateTazin] = getdate(), 
	[fldKalaId] = @fldKalaId, [fldVaznKol] = @fldVaznKol, [fldVaznKhals] =isnull( @fldVaznKhals,0.0) , 
	[fldRemittanceId] = @fldRemittanceId, /*[fldTarikhVaznKhali] = @Tarikh_VaznKhali, */[fldBaskoolId] = @fldBaskoolId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	,fldTypeKhodroId=@fldTypeKhodroId,@fldIspor=@fldIsPor,fldTedad=@fldTedad,fldTypeMohasebe=@fldTypeMohasebe
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
