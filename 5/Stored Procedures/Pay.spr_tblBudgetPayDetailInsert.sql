SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

    CREATE   PROCEDURE  [Pay].[spr_tblBudgetPayDetailInsert]
         @fldHeaderId int, @fldTypeEstekhdamId varchar(max), @fldUserId int
    AS
    BEGIN
        update  [Pay].[tblBudgetPayHeader] set fldUserId=@fldUserId,fldDate=GETDATE()
				WHERE fldid=@fldHeaderId

        declare @fldId int
        set @fldId=isnull( (select max(fldId) from [Pay].[tblBudgetPayDetail]),0)
           
                INSERT INTO [Pay].[tblBudgetPayDetail] (fldId, fldHeaderId, fldTypeEstekhdamId, fldTypeBimeId)
                select @fldId+ROW_NUMBER() over (order by t.id ),@fldId,  estekhdam, bime 
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
    
GO
