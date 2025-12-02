CREATE TABLE [Com].[tblUser_Group]
(
[fldId] [int] NOT NULL,
[fldUserGroupId] [int] NOT NULL,
[fldUserSelectId] [int] NOT NULL,
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblUser_Group_fldUserId] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUser_Group_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUser_Group_fldDate] DEFAULT (getdate()),
[fldGrant] [bit] NOT NULL CONSTRAINT [DF_tblUser_Group_fldGrant] DEFAULT ((1)),
[fldWithGrant] [bit] NOT NULL CONSTRAINT [DF_tblUser_Group_fldWithGrant] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser_Group] ADD CONSTRAINT [PK_tblUser_Group] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser_Group] ADD CONSTRAINT [IX_tblUser_Group] UNIQUE NONCLUSTERED ([fldUserGroupId], [fldUserSelectId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser_Group] ADD CONSTRAINT [FK_tblUser_Group_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Com].[tblUser_Group] ADD CONSTRAINT [FK_tblUser_Group_tblUser1] FOREIGN KEY ([fldUserSelectId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Com].[tblUser_Group] ADD CONSTRAINT [FK_tblUser_Group_tblUserGroup] FOREIGN KEY ([fldUserGroupId]) REFERENCES [Com].[tblUserGroup] ([fldId])
GO
