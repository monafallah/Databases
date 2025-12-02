CREATE TABLE [Com].[tblUserGroup_ModuleOrgan]
(
[fldId] [int] NOT NULL,
[fldUserGroupId] [int] NOT NULL CONSTRAINT [DF_Table_1_fldTitle] DEFAULT (''),
[fldModuleOrganId] [int] NOT NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblUserGroup_ModuleOrgan_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUserGroup_ModuleOrgan_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUserGroup_ModuleOrgan_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUserGroup_ModuleOrgan] ADD CONSTRAINT [PK_tblUserGroup_ModuleOrgan] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblUserGroup_ModuleOrgan] ON [Com].[tblUserGroup_ModuleOrgan] ([fldModuleOrganId], [fldUserGroupId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUserGroup_ModuleOrgan] ADD CONSTRAINT [FK_tblUserGroup_ModuleOrgan_tblModule_Organ] FOREIGN KEY ([fldModuleOrganId]) REFERENCES [Com].[tblModule_Organ] ([fldId])
GO
ALTER TABLE [Com].[tblUserGroup_ModuleOrgan] ADD CONSTRAINT [FK_tblUserGroup_ModuleOrgan_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Com].[tblUserGroup_ModuleOrgan] ADD CONSTRAINT [FK_tblUserGroup_ModuleOrgan_tblUserGroup] FOREIGN KEY ([fldUserGroupId]) REFERENCES [Com].[tblUserGroup] ([fldId])
GO
