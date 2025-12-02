CREATE TABLE [Arch].[tblFormatFile]
(
[fldId] [int] NOT NULL,
[fldFormatName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassvand] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIcon] [varbinary] (max) NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFile_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFormatFile] ADD CONSTRAINT [PK_tblFile_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFormatFile] ADD CONSTRAINT [IX_tblFormatFile] UNIQUE NONCLUSTERED ([fldFormatName]) ON [PRIMARY]
GO
ALTER TABLE [Arch].[tblFormatFile] ADD CONSTRAINT [IX_tblFormatFile_1] UNIQUE NONCLUSTERED ([fldPassvand]) ON [PRIMARY]
GO
