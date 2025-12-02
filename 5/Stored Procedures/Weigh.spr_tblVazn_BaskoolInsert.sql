SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblVazn_BaskoolInsert] 
     @fldID int out,
   @Haraf nvarchar(1),
    @Plaque1 varchar(2),
	@Plaque2 varchar(3),
	@serial tinyint,
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
	@fldTypeKhodroId int,
	@fldTedad int,
	@fldTypeMohasebe bit ,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  
    @fldIP varchar(16)
AS 

	
	BEGIN TRAN
	
	declare @fldPluqeId int,@fldPlaque nvarchar(13),@flag bit=0,  @fldVaznKhals decimal(15,3) = 0,@maxDate datetime,@v_kol decimal(15,3)=0
	,@Tarikh_VaznKhali nvarchar(20)='',@id_ int
	


	set @fldPlaque='-'+@Plaque2+@Haraf+@Plaque1 

	if not exists(select * from [Com].[tblPlaque] where fldSerialPlaque=@serial and fldPlaque=@fldPlaque)
	begin
		select @fldPluqeId =ISNULL(max(fldId),0)+1 from [Com].[tblPlaque] 

		INSERT INTO [Com].[tblPlaque] ([fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP])
		SELECT @fldPluqeId,@serial, @fldPlaque, 1, @fldDesc, getdate(), @fldIP
		if(@@Error<>0)
		begin
			rollback 
			set @flag=1
		end	  
	end	
select @fldPluqeId=fldid from [Com].[tblPlaque] where fldSerialPlaque=@serial and fldPlaque=@fldPlaque 

if (@fldTypeMohasebe=0)
begin
	if (@flag=0) 
	begin 
		 
		if (@fldIsPor=0)
		begin
			
				if exists (select * from [Weigh].[tblVazn_Baskool] where fldPluqeId=@fldPluqeId and fldIsPor=1
							and (fldVaznKhals=0 or fldVaznKhals is null or fldVaznKol=fldVaznKhals) and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId 
							and fldEbtal=0)

					begin

						set @Tarikh_VaznKhali=cast(cast(getdate()as time(0))as varchar(8))+' '+ dbo.Fn_AssembelyMiladiToShamsi(getdate())
				
						update [Weigh].[tblVazn_Baskool]
						set fldVaznKhals=fldVaznKol-@fldVaznKol,fldTarikhVaznKhali=@Tarikh_VaznKhali
						where fldPluqeId=@fldPluqeId and fldIsPor=1 and   (fldVaznKhals=0 or fldVaznKhals is null)and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId
						and fldEbtal=0 and fldNoeMasrafId<>1
						if(@@error<>0)
							rollback
 
						select @id_=max(fldid) from [Weigh].[tblVazn_Baskool] 
						where fldPluqeId=@fldPluqeId and fldIsPor=1	and fldBaskoolId=@fldBaskoolId 
						and fldOrganId=@fldOrganId and fldNoeMasrafId=1 and fldEbtal=0

						update [Weigh].[tblVazn_Baskool]
						set fldVaznKhals=fldVaznKol-@fldVaznKol,fldTarikhVaznKhali=@Tarikh_VaznKhali
						where fldid=@id_
						if(@@error<>0)
							rollback
						 
						
						set @fldVaznKhals=0

					end
				else
					begin
						set @fldVaznKhals=0
						set @Tarikh_VaznKhali=cast(cast(getdate()as time(0))as varchar(8))+' '+ dbo.Fn_AssembelyMiladiToShamsi(getdate())
					end
			end	
		
	 else
		begin	 
			if (@fldNoeMasrafId=1)
				 
					set @fldVaznKhals=@fldVaznKol
				 
			else
				begin
					select @maxDate=max(fldDateTazin) from [Weigh].[tblVazn_Baskool]  where fldPluqeId=@fldPluqeId and fldIsPor=0 and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId and fldEbtal=0
					select @v_kol= fldVaznKol,@Tarikh_VaznKhali=fldTarikhVaznKhali from [Weigh].[tblVazn_Baskool] 
					 where fldPluqeId=@fldPluqeId and fldDateTazin=@maxDate  and fldBaskoolId=@fldBaskoolId and fldIsPor=0 and fldOrganId=@fldOrganId and fldEbtal=0
					if (@v_kol=0)
						begin	
							set @fldVaznKhals=0
							set @Tarikh_VaznKhali=''
						end			
					else 

						set @fldVaznKhals=@fldVaznKol-@v_kol
			 end
		end
	end
end	
  
else if (@fldTypeMohasebe=1)
 begin	 
			
			select @maxDate=max(fldDateTazin) from [Weigh].[tblVazn_Baskool]  where fldPluqeId=@fldPluqeId and fldIsPor=1 and fldBaskoolId=@fldBaskoolId and fldOrganId=@fldOrganId and fldEbtal=0
			select @v_kol= fldVaznKol,@Tarikh_VaznKhali=cast(cast(fldDateTazin as time (0)) as varchar(8))+' '+dbo.Fn_AssembelyMiladiToShamsi( fldDateTazin) from [Weigh].[tblVazn_Baskool] 
			 where fldPluqeId=@fldPluqeId and fldDateTazin=@maxDate  and fldBaskoolId=@fldBaskoolId and fldIsPor=1 and fldOrganId=@fldOrganId and fldEbtal=0
			if (@v_kol=0)
			begin	
				set @fldVaznKhals=0
				set @Tarikh_VaznKhali=''
			end			
			else 
			
				set @fldVaznKhals=@fldVaznKol-@v_kol

	
end
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblVazn_Baskool] 

	INSERT INTO [Weigh].[tblVazn_Baskool] ([fldId], [fldPluqeId], [fldRananadeId], [fldNoeMasrafId], [fldAshkhasId], [fldChartOrganEjraeeId], [fldLoadingPlaceId], [fldDateTazin], [fldKalaId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali], [fldBaskoolId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP],fldIspor,fldTypeKhodroId,fldTedad,fldtypeMohasebe)
	SELECT @fldId, @fldPluqeId, @fldRananadeId, @fldNoeMasrafId, @fldAshkhasId, @fldChartOrganEjraeeId, @fldLoadingPlaceId, getdate(), @fldKalaId, @fldVaznKol,isnull( @fldVaznKhals,0.0), @fldRemittanceId, @Tarikh_VaznKhali, @fldBaskoolId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP,@fldIsPor,@fldTypeKhodroId,@fldTedad,@fldTypeMohasebe
	if(@@Error<>0)
        rollback  
		   
	COMMIT
GO
