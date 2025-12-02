CREATE TABLE [Com].[tblGeneralSetting]
(
[fldId] [tinyint] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSetting_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSetting_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL,
[fldModuleId] [int] NULL,
[fldFormulId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [PK_tblSetting_2] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [IX_tblGeneralSetting] UNIQUE NONCLUSTERED ([fldModuleId], [fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [FK_tblGeneralSetting_tblComputationFormula] FOREIGN KEY ([fldFormulId]) REFERENCES [Com].[tblComputationFormula] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [FK_tblGeneralSetting_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [FK_tblSetting_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting] ADD CONSTRAINT [FK_tblSetting_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
