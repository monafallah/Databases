CREATE TABLE [Dead].[tblGhabreAmanat]
(
[fldId] [int] NOT NULL,
[fldShomareId] [int] NULL,
[fldShomareTabaghe] [tinyint] NULL,
[fldEmployeeId] [int] NULL,
[fldOrganId] [int] NOT NULL,
[fldTarikhRezerv] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGhabreAmanat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGhabreAmanat_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldGhabrInfoId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [PK_tblGhabreAmanat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [IX_tblGhabreAmanat] UNIQUE NONCLUSTERED ([fldEmployeeId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [FK_tblGhabreAmanat_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [FK_tblGhabreAmanat_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [FK_tblGhabreAmanat_tblShomare] FOREIGN KEY ([fldShomareId]) REFERENCES [Dead].[tblShomare] ([fldId])
GO
ALTER TABLE [Dead].[tblGhabreAmanat] ADD CONSTRAINT [FK_tblGhabreAmanat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
