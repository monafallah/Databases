CREATE TABLE [Trans].[tblEvent]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldTransactionTypeId] [int] NOT NULL,
[fldFormulId] [int] NULL,
[fldFlag] [bit] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEvent_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblEvent] ADD CONSTRAINT [PK_tblEvent] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblEvent] ADD CONSTRAINT [FK_tblEvent_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [dbo].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Trans].[tblEvent] ADD CONSTRAINT [FK_tblEvent_tblTransactionType] FOREIGN KEY ([fldTransactionTypeId]) REFERENCES [Trans].[tblTransactionType] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'رویدادها', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع ترد', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', 'COLUMN', N'fldFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی فرمول', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', 'COLUMN', N'fldFormulId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نوع تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblEvent', 'COLUMN', N'fldTransactionTypeId'
GO
