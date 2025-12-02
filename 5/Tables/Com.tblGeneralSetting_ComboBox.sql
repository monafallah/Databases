CREATE TABLE [Com].[tblGeneralSetting_ComboBox]
(
[fldId] [tinyint] NOT NULL,
[fldGeneralSettingId] [tinyint] NOT NULL,
[fldTtile] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldValue] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblGeneralSetting_ComboBox_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblGeneralSetting_ComboBox_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting_ComboBox] ADD CONSTRAINT [PK_tblGeneralSetting_ComboBox] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblGeneralSetting_ComboBox] ADD CONSTRAINT [FK_tblGeneralSetting_ComboBox_tblGeneralSetting] FOREIGN KEY ([fldGeneralSettingId]) REFERENCES [Com].[tblGeneralSetting] ([fldId])
GO
ALTER TABLE [Com].[tblGeneralSetting_ComboBox] ADD CONSTRAINT [FK_tblGeneralSetting_ComboBox_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
