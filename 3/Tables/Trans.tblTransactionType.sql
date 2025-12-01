CREATE TABLE [Trans].[tblTransactionType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTransactionGroupId] [int] NOT NULL,
[fldFileId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblTransactionType] ADD CONSTRAINT [PK_tblTransactionType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblTransactionType] ADD CONSTRAINT [FK_tblTransactionType_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [dbo].[tblFile] ([fldId])
GO
ALTER TABLE [Trans].[tblTransactionType] ADD CONSTRAINT [FK_tblTransactionType_tblTransactionGroup] FOREIGN KEY ([fldTransactionGroupId]) REFERENCES [Trans].[tblTransactionGroup] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionType', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionType', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionType', 'COLUMN', N'fldName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی گروه تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionType', 'COLUMN', N'fldTransactionGroupId'
GO
