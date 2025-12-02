CREATE TABLE [Com].[tblGeneralSetting_Value]
(
[fldId] [tinyint] NOT NULL,
[fldGeneralSettingId] [tinyint] NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGeneralSetting_Value_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGeneralSetting_Value_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting_Value] ADD CONSTRAINT [PK_tblGeneralSetting_Value] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting_Value] ADD CONSTRAINT [FK_tblGeneralSetting_Value_tblGeneralSetting] FOREIGN KEY ([fldGeneralSettingId]) REFERENCES [Com].[tblGeneralSetting] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting_Value] ADD CONSTRAINT [FK_tblGeneralSetting_Value_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting_Value] ADD CONSTRAINT [FK_tblGeneralSetting_Value_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
