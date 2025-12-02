CREATE TABLE [BUD].[tblBudgetSanavati]
(
[fldId] [int] NOT NULL,
[fldFiscalId] [int] NOT NULL,
[fldBudgetTypeId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBudgetSanavati_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblBudgetSanavati_fldUserId] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudgetSanavati] ADD CONSTRAINT [PK_tblBudgetSanavati] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudgetSanavati] ADD CONSTRAINT [FK_tblBudgetSanavati_tblBudgetSanavati] FOREIGN KEY ([fldId]) REFERENCES [BUD].[tblBudgetSanavati] ([fldId])
GO
ALTER TABLE [BUD].[tblBudgetSanavati] ADD CONSTRAINT [FK_tblBudgetSanavati_tblFiscalYear] FOREIGN KEY ([fldFiscalId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [BUD].[tblBudgetSanavati] ADD CONSTRAINT [FK_tblBudgetSanavati_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
