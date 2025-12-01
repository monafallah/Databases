CREATE TABLE [Trans].[tblEventType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblEventType] ADD CONSTRAINT [PK_tblEventType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع رویداد', 'SCHEMA', N'Trans', 'TABLE', N'tblEventType', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblEventType', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام ', 'SCHEMA', N'Trans', 'TABLE', N'tblEventType', 'COLUMN', N'fldName'
GO
