CREATE TABLE [Prs].[tblPersonalSign]
(
[fldId] [int] NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSignerPersonal_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSignerPersonal_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCommitionId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblPersonalSign] ADD CONSTRAINT [PK_tblPersonalSign] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Prs].[tblPersonalSign] ADD CONSTRAINT [FK_tblPersonalSign_tblCommision] FOREIGN KEY ([fldCommitionId]) REFERENCES [Auto].[tblCommision] ([fldID])
GO
ALTER TABLE [Prs].[tblPersonalSign] ADD CONSTRAINT [FK_tblSignerPersonal_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Prs].[tblPersonalSign] ADD CONSTRAINT [FK_tblSignerPersonal_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
