CREATE TABLE [Dead].[tblMotevaffa]
(
[fldId] [int] NOT NULL,
[fldCauseOfDeathId] [int] NULL,
[fldGhabreAmanatId] [int] NOT NULL,
[fldTarikhFot] [int] NULL,
[fldTarikhDafn] [int] NULL,
[fldMahalFotId] [int] NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMotevaffa_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMotevaffa_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [PK_tblMotevaffa] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [IX_tblMotevaffa] UNIQUE NONCLUSTERED ([fldGhabreAmanatId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [FK_tblMotevaffa_tblCauseOfDeath] FOREIGN KEY ([fldCauseOfDeathId]) REFERENCES [Dead].[tblCauseOfDeath] ([fldId])
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [FK_tblMotevaffa_tblGhabreAmanat] FOREIGN KEY ([fldGhabreAmanatId]) REFERENCES [Dead].[tblGhabreAmanat] ([fldId])
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [FK_tblMotevaffa_tblMahalFot] FOREIGN KEY ([fldMahalFotId]) REFERENCES [Dead].[tblMahalFot] ([fldId])
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [FK_tblMotevaffa_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblMotevaffa] ADD CONSTRAINT [FK_tblMotevaffa_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
