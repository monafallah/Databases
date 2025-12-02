CREATE TABLE [Dead].[tblRequestAmanat]
(
[fldId] [int] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldShomareId] [int] NOT NULL,
[fldTarikh] [int] NULL,
[fldIsEbtal] [bit] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblRequestAmanat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblRequestAmanat_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblRequestAmanat] ADD CONSTRAINT [PK_tblRequestAmanat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblRequestAmanat] ADD CONSTRAINT [FK_tblRequestAmanat_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Dead].[tblRequestAmanat] ADD CONSTRAINT [FK_tblRequestAmanat_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Dead].[tblRequestAmanat] ADD CONSTRAINT [FK_tblRequestAmanat_tblShomare] FOREIGN KEY ([fldShomareId]) REFERENCES [Dead].[tblShomare] ([fldId])
GO
ALTER TABLE [Dead].[tblRequestAmanat] ADD CONSTRAINT [FK_tblRequestAmanat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
