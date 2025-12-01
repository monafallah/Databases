CREATE TABLE [Trans].[tblEventTables]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldNameTablesId] [int] NOT NULL,
[fldEventTypeId] [int] NOT NULL,
[fldFormulId] [int] NULL,
[fldFlag] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblEventTables] ADD CONSTRAINT [PK_tblEventTables] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblEventTables] ADD CONSTRAINT [FK_tblEventTables_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [dbo].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Trans].[tblEventTables] ADD CONSTRAINT [FK_tblEventTables_tblEventType] FOREIGN KEY ([fldEventTypeId]) REFERENCES [Trans].[tblEventType] ([fldId])
GO
ALTER TABLE [Trans].[tblEventTables] ADD CONSTRAINT [FK_tblEventTables_tblNameTables] FOREIGN KEY ([fldNameTablesId]) REFERENCES [Trans].[tblNameTables] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'رویدادهای جداول', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نوع رویداد', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', 'COLUMN', N'fldEventTypeId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع ', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', 'COLUMN', N'fldFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی فرمول', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', 'COLUMN', N'fldFormulId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نام جداول', 'SCHEMA', N'Trans', 'TABLE', N'tblEventTables', 'COLUMN', N'fldNameTablesId'
GO
