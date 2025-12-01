CREATE TABLE [Trans].[tblSubTransactionParametrs]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldSubTransactionId] [int] NOT NULL,
[fldJsonParametr] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransactionParametrs] ADD CONSTRAINT [PK_tblSubTransactionParametrs] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblSubTransactionParametrs] ADD CONSTRAINT [FK_tblSubTransactionParametrs_tblSubTransaction] FOREIGN KEY ([fldSubTransactionId]) REFERENCES [Trans].[tblSubTransaction] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ریز تراکنش پارامترها', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionParametrs', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی ', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionParametrs', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'پارامترهای ورودی', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionParametrs', 'COLUMN', N'fldJsonParametr'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ریز تراکنش آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblSubTransactionParametrs', 'COLUMN', N'fldSubTransactionId'
GO
