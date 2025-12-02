CREATE TABLE [Com].[tblFormatFile]
(
[fldId] [tinyint] NOT NULL,
[fldFormatName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassvand] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIcon] [varbinary] (max) NULL,
[fldSize] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFormatFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFormatFile_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblFormatFile] ADD CONSTRAINT [PK_tblFormatFile] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblFormatFile] ADD CONSTRAINT [FK_tblFormatFile_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblFormatFile] ADD CONSTRAINT [FK_tblFormatFile_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
