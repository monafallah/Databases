CREATE TABLE [Dead].[tblGhete]
(
[fldId] [int] NOT NULL,
[fldVadiSalamId] [int] NOT NULL,
[fldNameGhete] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGhete_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGhete_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhete] ADD CONSTRAINT [PK_tblGhete] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhete] ADD CONSTRAINT [IX_tblGhete] UNIQUE NONCLUSTERED ([fldNameGhete], [fldVadiSalamId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhete] ADD CONSTRAINT [FK_tblGhete_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblGhete] ADD CONSTRAINT [FK_tblGhete_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Dead].[tblGhete] ADD CONSTRAINT [FK_tblGhete_tblVadiSalam] FOREIGN KEY ([fldVadiSalamId]) REFERENCES [Dead].[tblVadiSalam] ([fldId])
GO
