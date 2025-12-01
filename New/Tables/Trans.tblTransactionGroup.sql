CREATE TABLE [Trans].[tblTransactionGroup]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblTransactionGroup] ADD CONSTRAINT [PK_tblTransactionGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblTransactionGroup] ADD CONSTRAINT [IX_tblTransactionGroup] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'گروه تراکنش', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionGroup', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionGroup', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام گروه', 'SCHEMA', N'Trans', 'TABLE', N'tblTransactionGroup', 'COLUMN', N'fldName'
GO
