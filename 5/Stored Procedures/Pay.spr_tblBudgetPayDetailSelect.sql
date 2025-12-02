SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

    CREATE   PROCEDURE [Pay].[spr_tblBudgetPayDetailSelect]
    @fieldname nvarchar(50),
    @Value nvarchar(50),
    @h int
    AS
    BEGIN
        if (@h=0) set @h=2147483647
        SET @Value=Com.fn_TextNormalize(@value)
        if (@fieldname=N'fldId')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where p.fldId=@Value

    if (@fieldname=N'fldHeaderId')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where p.fldHeaderId=@Value

   if (@fieldname=N'fldTypeEstekhdamId')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where p.fldTypeEstekhdamId=@Value

  if (@fieldname=N'fldTypeBimeId')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where p.fldTypeBimeId=@Value

  if (@fieldname=N'fldTitleEstekhdam')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where e.fldTitle like @Value
  
  if (@fieldname=N'fldTitleBime')
             SELECT        p.fldId, p.fldHeaderId, p.fldTypeEstekhdamId, p.fldTypeBimeId, e.fldTitle as fldTitleEstekhdam, t.fldTitle AS fldTitleBime
            FROM            Pay.tblBudgetPayDetail AS p INNER JOIN
                                 com.tblTypeEstekhdam AS e ON e.fldId = p.fldTypeEstekhdamId INNER JOIN
                                 com.tblTypeBime AS t ON t.fldId = p.fldTypeBimeId
                                 where t.fldTitle like @Value


    END

    
GO
