SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

        CREATE   PROCEDURE [Pay].[spr_tblBudgetPayHeaderDelete]
           @FieldName varchar(50), @fldItemsHoghughiId INT,@fldFiscalYearId int, @fldUserId int
        AS
        BEGIN
			
			if(@FieldName='ItemsHoghughiId')
			begin
				DELETE FROM [Pay].[tblBudgetPayDetail]
				WHERE fldHeaderId in(select fldId from tblBudgetPayHeader where fldItemsHoghughiId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId)
				if(@@ERROR<>0)
					rollback
				else
				begin
					update  [Pay].[tblBudgetPayHeader] set fldUserId=@fldUserId,fldDate=GETDATE()
					WHERE fldItemsHoghughiId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId

					DELETE FROM [Pay].[tblBudgetPayHeader]
					WHERE fldItemsHoghughiId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId
					if(@@ERROR<>0)
					rollback
				end
			end
			else if(@FieldName='ParametrId')
			begin
				DELETE FROM [Pay].[tblBudgetPayDetail]
				WHERE fldHeaderId in(select fldId from tblBudgetPayHeader where fldParametrId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId)
				if(@@ERROR<>0)
					rollback
				else
				begin
					update  [Pay].[tblBudgetPayHeader] set fldUserId=@fldUserId,fldDate=GETDATE()
					WHERE fldParametrId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId

					DELETE FROM [Pay].[tblBudgetPayHeader]
					WHERE fldParametrId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId
					if(@@ERROR<>0)
					rollback
				end
			end
            else if(@FieldName='kosuratBudgetPayId')
			begin
				DELETE FROM [Pay].[tblBudgetPayDetail]
				WHERE fldHeaderId in(select fldId from tblBudgetPayHeader where fldkosuratBudgetPayId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId)
				if(@@ERROR<>0)
					rollback
				else
				begin
					update  [Pay].[tblBudgetPayHeader] set fldUserId=@fldUserId,fldDate=GETDATE()
					WHERE fldkosuratBudgetPayId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId

					DELETE FROM [Pay].[tblBudgetPayHeader]
					WHERE fldkosuratBudgetPayId=@fldItemsHoghughiId
				and fldFiscalYearId=@fldFiscalYearId
					if(@@ERROR<>0)
					rollback
				end
			end
        END
        
GO
