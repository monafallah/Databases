CREATE TABLE [Com].[tblUserGroup]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUserGroup_fldTitle] DEFAULT (''),
[fldUserID] [int] NOT NULL CONSTRAINT [DF_tblUserGroup_fldUserID] DEFAULT ((1)),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUserGroup_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUserGroup_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUserGroup] ADD CONSTRAINT [PK_tblUserGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUserGroup] ADD CONSTRAINT [IX_tblUserGroup] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUserGroup] ADD CONSTRAINT [FK_tblUserGroup_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
