CREATE TABLE [Trans].[tblSubTransactionTables]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldSubTransactionId] [int] NOT NULL,
[fldNameTablesId] [int] NOT NULL,
[fldRowId] [varbinary] (8) NULL,
[fldFlag] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransactionTables] ADD CONSTRAINT [PK_tblSubTransactionTables] PRIMARY KEY NONCLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblSubTransactionTables_2] ON [Trans].[tblSubTransactionTables] ([fldNameTablesId]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_tblSubTransactionTables_3] ON [Trans].[tblSubTransactionTables] ([fldRowId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblSubTransactionTables] ON [Trans].[tblSubTransactionTables] ([fldSubTransactionId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransactionTables] ADD CONSTRAINT [FK_tblSubTransactionTables_tblNameTables] FOREIGN KEY ([fldNameTablesId]) REFERENCES [Trans].[tblNameTables] ([fldId])
GO
ALTER TABLE [Trans].[tblSubTransactionTables] ADD CONSTRAINT [FK_tblSubTransactionTables_tblSubTransaction] FOREIGN KEY ([fldSubTransactionId]) REFERENCES [Trans].[tblSubTransaction] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ریز تراکنش جدولها', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'موفق/ناموفق', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', 'COLUMN', N'fldFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نام جدول', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', 'COLUMN', N'fldNameTablesId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی رکورد', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', 'COLUMN', N'fldRowId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ریز تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionTables', 'COLUMN', N'fldSubTransactionId'
GO
