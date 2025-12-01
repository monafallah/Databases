CREATE TABLE [dbo].[tblPageHtml]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMasir] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMohtavaHtml] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPageHtml] ADD CONSTRAINT [PK_tblPageHtml] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPageHtml] ADD CONSTRAINT [IX_tblPageHtml] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'جدول صفحه HTML', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ای دی ', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون مسیر محتوا', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', 'COLUMN', N'fldMasir'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون محتوا HTML', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', 'COLUMN', N'fldMohtavaHtml'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون عنوان ', 'SCHEMA', N'dbo', 'TABLE', N'tblPageHtml', 'COLUMN', N'fldTitle'
GO
