SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

    CREATE   PROCEDURE  [Pay].[spr_tblBudgetPayHeaderInsert]
         @fldFiscalYearId int, 
         @fldItemsHoghughiId int, 
         @fldParametrId int, 
         @fldkosuratBudgetPayId int,
         @fldBudgetCode int, 
         @fldUserId int, 
         @fldIP varchar(15),  
         @fldDesc nvarchar(300),
         @fldTypeEstekhdamId varchar(max)
    AS
    BEGIN

        declare @fldId int=0
        set @fldId=isnull( (select max(fldId)+1 from [Pay].[tblBudgetPayHeader]),1)

        INSERT INTO [Pay].[tblBudgetPayHeader] (fldId, fldFiscalYearId, fldItemsHoghughiId, fldParametrId,fldkosuratBudgetPayId, fldBudgetCode, fldUserId, fldIP, fldDate, fldDesc)
        VALUES (@fldId, @fldFiscalYearId, @fldItemsHoghughiId, @fldParametrId,@fldkosuratBudgetPayId, @fldBudgetCode, @fldUserId, @fldIP, GETDATE(), @fldDesc)
        if(@@ERROR<>0)
            rollback
        else
        BEGIN
            declare @fldDetailId int=0
            set @fldDetailId=isnull( (select max(fldId) from [Pay].[tblBudgetPayDetail]),0)
           
                INSERT INTO [Pay].[tblBudgetPayDetail] (fldId, fldHeaderId, fldTypeEstekhdamId, fldTypeBimeId)
                select @fldDetailId+ROW_NUMBER() over (order by t.id ),@fldId,  estekhdam, bime 
                 from(
                select t.Item as estekhdam,lead(t.Item) over (order by t.id) as bime,id from(
	                select t2.Item ,ROW_NUMBER() over (order by (select 1)) as id from com.Split(@fldTypeEstekhdamId,';') as t
	                cross apply (select * from com.Split(t.Item,',')) t2
	                where t.Item<>'' and t2.Item<>''
                )t)t
                where id %2 >0
			    if(@@ERROR<>0)
                rollback
           
        END
    END
    
GO
