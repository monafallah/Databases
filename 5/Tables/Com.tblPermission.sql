CREATE TABLE [Com].[tblPermission]
(
[fldId] [int] NOT NULL,
[fldUserGroup_ModuleOrganID] [int] NOT NULL,
[fldApplicationPartID] [int] NOT NULL,
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblPermission_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPermission_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPermission_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPermission] ADD CONSTRAINT [PK_tblPermission] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblApplicationPart] FOREIGN KEY ([fldApplicationPartID]) REFERENCES [Com].[tblApplicationPart] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Com].[tblPermission] ADD CONSTRAINT [FK_tblPermission_tblUserGroup_ModuleOrgan] FOREIGN KEY ([fldUserGroup_ModuleOrganID]) REFERENCES [Com].[tblUserGroup_ModuleOrgan] ([fldId])
GO
