SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

        CREATE   PROCEDURE [Pay].[spr_tblBudgetPayHeaderUpdate]
            @fldId int, 
            @fldFiscalYearId int, 
            @fldItemsHoghughiId int, 
            @fldParametrId int, 
            @fldkosuratBudgetPayId int,
            @fldBudgetCode int, 
            @fldUserId int, 
            @fldIP varchar(15), 
            @fldDesc nvarchar(300),
            @fldTypeEstekhdamId varchar(500)
        AS
        BEGIN
            UPDATE [Pay].[tblBudgetPayHeader]
            SET [fldId] = @fldId, [fldFiscalYearId] = @fldFiscalYearId, [fldItemsHoghughiId] = @fldItemsHoghughiId, [fldParametrId] = @fldParametrId
            ,fldkosuratBudgetPayId=@fldkosuratBudgetPayId
            , [fldBudgetCode] = @fldBudgetCode, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
            WHERE fldId = @fldId
              if(@@ERROR<>0)
            rollback
        else
        BEGIN
            delete [Pay].[tblBudgetPayDetail] where fldHeaderId=@fldId
           declare @fldDetailId int=0
            set @fldDetailId=isnull( (select max(fldId) from [Pay].[tblBudgetPayDetail]),0)
            
                INSERT INTO [Pay].[tblBudgetPayDetail] (fldId, fldHeaderId, fldTypeEstekhdamId, fldTypeBimeId)
                select @fldDetailId+ROW_NUMBER() over (order by t.id ),@fldId,  estekhdam, bime 
                 from(
                select t.value as estekhdam,lead(t.value) over (order by t.id) as bime,id from(
	                select t2.value ,ROW_NUMBER() over (order by (select 1)) as id from string_split(@fldTypeEstekhdamId,';') as t
	                cross apply (select * from string_split(t.value,',')) t2
	                where t.value<>'' and t2.value<>''
                )t)t
                where id %2 >0
			    if(@@ERROR<>0)
                rollback
            

        END
        END
        
GO
