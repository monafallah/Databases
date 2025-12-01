CREATE TABLE [dbo].[tblFormatFileHistory]
(
[fldId] [int] NOT NULL,
[fldFormatName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassvand] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIcon] [varbinary] (max) NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIconName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] NOT NULL,
[EndTime] [datetime2] NOT NULL,
[fldSize] [int] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_tblFormatFileHistory] ON [dbo].[tblFormatFileHistory] ([EndTime], [StartTime]) ON [PRIMARY]
GO
CREATE TABLE [dbo].[tblFormatFile]
(
[fldId] [int] NOT NULL,
[fldFormatName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassvand] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIcon] [varbinary] (max) NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFormatFile_fldDesc] DEFAULT (''),
[fldIconName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFormatFile_fldIconName] DEFAULT (''),
[fldInputId] [int] NOT NULL,
[fldTimeStamp] [timestamp] NOT NULL,
[StartTime] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL CONSTRAINT [DF__tblFormat__Start__479C827A] DEFAULT (getutcdate()),
[EndTime] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL CONSTRAINT [DF__tblFormat__EndTi__4890A6B3] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')),
[fldSize] [int] NULL,
PERIOD FOR SYSTEM_TIME (StartTime, EndTime),
CONSTRAINT [PK_tblFormatFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[tblFormatFileHistory])
)
GO
ALTER TABLE [dbo].[tblFormatFile] ADD CONSTRAINT [FK_tblFormatFile_tblInputInfo] FOREIGN KEY ([fldInputId]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'فرمت فایل', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', NULL, NULL
GO
EXEC sp_addextendedproperty N'PersianName', N'فرمت فایل ', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون نام فرمت ', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldFormatName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آیکن ', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldIcon'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نام ایکون', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldIconName'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ای دی ', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون پسوند ', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldPassvand'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فیلد مربوط یه ویرایش', 'SCHEMA', N'dbo', 'TABLE', N'tblFormatFile', 'COLUMN', N'fldTimeStamp'
GO
