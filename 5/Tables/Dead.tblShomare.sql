CREATE TABLE [Dead].[tblShomare]
(
[fldId] [int] NOT NULL,
[fldRadifId] [int] NOT NULL,
[fldShomare] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTedadTabaghat] [tinyint] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIp] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblShomare_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblShomare_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblShomare] ADD CONSTRAINT [PK_tblShomare] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblShomare] ADD CONSTRAINT [IX_tblShomare] UNIQUE NONCLUSTERED ([fldShomare], [fldRadifId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblShomare] ADD CONSTRAINT [FK_tblShomare_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblShomare] ADD CONSTRAINT [FK_tblShomare_tblRadif] FOREIGN KEY ([fldRadifId]) REFERENCES [Dead].[tblRadif] ([fldId])
GO
ALTER TABLE [Dead].[tblShomare] ADD CONSTRAINT [FK_tblShomare_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
