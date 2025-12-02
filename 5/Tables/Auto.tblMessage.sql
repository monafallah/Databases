CREATE TABLE [Auto].[tblMessage]
(
[fldId] [int] NOT NULL,
[fldCommisionId] [int] NOT NULL,
[fldTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMatn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMessage_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMessage_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhShamsi] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMessage] ADD CONSTRAINT [PK_tblMessage] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblMessage] ADD CONSTRAINT [FK_tblMessage_tblCommision] FOREIGN KEY ([fldCommisionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Auto].[tblMessage] ADD CONSTRAINT [FK_tblMessage_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblMessage] ADD CONSTRAINT [FK_tblMessage_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
