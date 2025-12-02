CREATE TABLE [Com].[tblModule_Organ]
(
[fldId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldModuleId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblModule_Organ_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblModule_Organ_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule_Organ] ADD CONSTRAINT [PK_tblModule_Organ] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule_Organ] ADD CONSTRAINT [IX_tblModule_Organ] UNIQUE NONCLUSTERED ([fldModuleId], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblModule_Organ] ADD CONSTRAINT [FK_tblModule_Organ_tblModule] FOREIGN KEY ([fldModuleId]) REFERENCES [Com].[tblModule] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblModule_Organ] ADD CONSTRAINT [FK_tblModule_Organ_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblModule_Organ] ADD CONSTRAINT [FK_tblModule_Organ_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
