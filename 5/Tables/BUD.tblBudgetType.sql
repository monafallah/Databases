CREATE TABLE [BUD].[tblBudgetType]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudgetType] ADD CONSTRAINT [PK_tblBudgetType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudgetType] ADD CONSTRAINT [IX_tblBudgetType] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
