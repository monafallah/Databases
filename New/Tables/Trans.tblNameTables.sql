CREATE TABLE [Trans].[tblNameTables]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldEnNameTables] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSystemIdTables] [int] NOT NULL,
[fldFaName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblNameTables] ADD CONSTRAINT [PK_tblNameAllTable] PRIMARY KEY NONCLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Trans].[tblNameTables] ADD CONSTRAINT [IX_tblNameTables] UNIQUE CLUSTERED ([fldEnNameTables]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام جداول', 'SCHEMA', N'Trans', 'TABLE', N'tblNameTables', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام انگلیسی جدول', 'SCHEMA', N'Trans', 'TABLE', N'tblNameTables', 'COLUMN', N'fldEnNameTables'
GO
EXEC sp_addextendedproperty N'MS_Description', N'اسم فارسی جدول', 'SCHEMA', N'Trans', 'TABLE', N'tblNameTables', 'COLUMN', N'fldFaName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'آیدی', 'SCHEMA', N'Trans', 'TABLE', N'tblNameTables', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ایدی سیستمی جدول', 'SCHEMA', N'Trans', 'TABLE', N'tblNameTables', 'COLUMN', N'fldSystemIdTables'
GO
