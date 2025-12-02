CREATE TABLE [Pay].[tblTypeEstekhdam_UserGroup]
(
[fldId] [int] NOT NULL,
[fldTypeEstekhamId] [int] NOT NULL,
[fldUseGroupId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_UserGroup_fldDesc] DEFAULT (''),
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_UserGroup_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblTypeEstekhdam_UserGroup] ADD CONSTRAINT [PK_tblTypeEstekhdam_UserGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblTypeEstekhdam_UserGroup] ADD CONSTRAINT [FK_tblTypeEstekhdam_UserGroup_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Pay].[tblTypeEstekhdam_UserGroup] ADD CONSTRAINT [FK_tblTypeEstekhdam_UserGroup_tblTypeEstekhdam] FOREIGN KEY ([fldTypeEstekhamId]) REFERENCES [Com].[tblTypeEstekhdam] ([fldId])
GO
ALTER TABLE [Pay].[tblTypeEstekhdam_UserGroup] ADD CONSTRAINT [FK_tblTypeEstekhdam_UserGroup_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Pay].[tblTypeEstekhdam_UserGroup] ADD CONSTRAINT [FK_tblTypeEstekhdam_UserGroup_tblUserGroup] FOREIGN KEY ([fldUseGroupId]) REFERENCES [Com].[tblUserGroup] ([fldId])
GO
