CREATE TABLE [Dead].[tblRadif]
(
[fldId] [int] NOT NULL,
[fldGheteId] [int] NOT NULL,
[fldNameRadif] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblRadif_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblRadif_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblRadif] ADD CONSTRAINT [PK_tblRadif] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblRadif] ADD CONSTRAINT [IX_tblRadif] UNIQUE NONCLUSTERED ([fldGheteId], [fldNameRadif]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblRadif] ADD CONSTRAINT [FK_tblRadif_tblGhete] FOREIGN KEY ([fldGheteId]) REFERENCES [Dead].[tblGhete] ([fldId])
GO
ALTER TABLE [Dead].[tblRadif] ADD CONSTRAINT [FK_tblRadif_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblRadif] ADD CONSTRAINT [FK_tblRadif_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
