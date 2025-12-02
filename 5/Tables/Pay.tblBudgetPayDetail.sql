CREATE TABLE [Pay].[tblBudgetPayDetail]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldTypeEstekhdamId] [int] NOT NULL,
[fldTypeBimeId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblBudgetPayDetail] ADD CONSTRAINT [PK_tblBudgetPayDetail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblBudgetPayDetail] ADD CONSTRAINT [FK_tblBudgetPayDetail_tblBudgetPayHeader] FOREIGN KEY ([fldHeaderId]) REFERENCES [Pay].[tblBudgetPayHeader] ([fldId]) ON DELETE CASCADE
GO
ALTER TABLE [Pay].[tblBudgetPayDetail] ADD CONSTRAINT [FK_tblBudgetPayDetail_tblTypeBime] FOREIGN KEY ([fldTypeBimeId]) REFERENCES [Com].[tblTypeBime] ([fldId])
GO
ALTER TABLE [Pay].[tblBudgetPayDetail] ADD CONSTRAINT [FK_tblBudgetPayDetail_tblTypeEstekhdam] FOREIGN KEY ([fldTypeEstekhdamId]) REFERENCES [Com].[tblTypeEstekhdam] ([fldId])
GO
