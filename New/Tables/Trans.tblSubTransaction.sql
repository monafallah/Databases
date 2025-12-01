CREATE TABLE [Trans].[tblSubTransaction]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldInputId] [int] NOT NULL,
[fldTransactiontTypeId] [int] NOT NULL,
[fldStatus] [bit] NULL,
[fldTarikh] [int] NOT NULL,
[fldTime] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransaction] ADD CONSTRAINT [PK_tblSubTransaction_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblSubTransaction] ON [Trans].[tblSubTransaction] ([fldInputId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransaction] ADD CONSTRAINT [FK_tblSubTransaction_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [Trans].[tblSubTransaction] ADD CONSTRAINT [FK_tblSubTransaction_tblTransactionType] FOREIGN KEY ([fldTransactiontTypeId]) REFERENCES [Trans].[tblTransactionType] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ریز تراکنش ها', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ورود و خروج', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldInputId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'وضعیت', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldStatus'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldTarikh'
GO
EXEC sp_addextendedproperty N'MS_Description', N'زمان', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldTime'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی نوع تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransaction', 'COLUMN', N'fldTransactiontTypeId'
GO
