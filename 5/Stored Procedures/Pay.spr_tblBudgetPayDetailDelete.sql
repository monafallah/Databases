SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

        CREATE   PROCEDURE [Pay].[spr_tblBudgetPayDetailDelete]
            @fldHeaderId INT,
            @fldTypeEstekhdamId int,
            @fldTypeBimeId int,
            @fldUserId int

        AS
        BEGIN
            DELETE FROM [Pay].[tblBudgetPayDetail]
            WHERE [fldHeaderId] = @fldHeaderId and fldTypeEstekhdamId=@fldTypeEstekhdamId and fldTypeBimeId=@fldTypeBimeId
            if(@@ERROR<>0)
					rollback
                    else
                    begin
                        	update  [Pay].[tblBudgetPayHeader] set fldUserId=@fldUserId,fldDate=GETDATE()
					            WHERE fldid=@fldHeaderId

					        DELETE FROM [Pay].[tblBudgetPayHeader]
					            WHERE fldid=@fldHeaderId and not exists (select * from pay.[tblBudgetPayDetail] as d where d.[fldHeaderId] = @fldHeaderId)
					            if(@@ERROR<>0)
					            rollback
                    end
        END
        
GO
