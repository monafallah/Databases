SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

        CREATE   PROCEDURE [Pay].[spr_tblBudgetPayDetailUpdate]
            @fldId int, @fldHeaderId int, @fldTypeEstekhdamId int, @fldTypeBimeId int
        AS
        BEGIN
            UPDATE [Pay].[tblBudgetPayDetail]
            SET [fldId] = @fldId, [fldHeaderId] = @fldHeaderId, [fldTypeEstekhdamId] = @fldTypeEstekhdamId, [fldTypeBimeId] = @fldTypeBimeId
            WHERE [fldId] = @fldId
        END
        
GO
