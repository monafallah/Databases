CREATE TABLE [Com].[tblOrganization]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPId] [int] NULL,
[fldFileId] [int] NOT NULL,
[fldCityId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOrganization_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOrganization_fldDate] DEFAULT (getdate()),
[fldCodAnformatic] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodKhedmat] [tinyint] NOT NULL,
[fldAshkhaseHoghoghiId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganization] ADD CONSTRAINT [PK_tblOrganization] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganization] ADD CONSTRAINT [FK_tblOrganization_tblAshkhaseHoghoghi] FOREIGN KEY ([fldAshkhaseHoghoghiId]) REFERENCES [Com].[tblAshkhaseHoghoghi] ([fldId])
GO
ALTER TABLE [Com].[tblOrganization] ADD CONSTRAINT [FK_tblOrganization_tblOrganization] FOREIGN KEY ([fldPId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblOrganization] ADD CONSTRAINT [FK_tblOrganization_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
