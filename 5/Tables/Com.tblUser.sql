CREATE TABLE [Com].[tblUser]
(
[fldId] [int] NOT NULL,
[fldEmployId] [int] NOT NULL,
[fldUserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassword] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldActive_Deactive] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUser_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUser_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [IX_tblUser] UNIQUE NONCLUSTERED ([fldEmployId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [IX_tblUser_1] UNIQUE NONCLUSTERED ([fldEmployId], [fldUserName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [IX_tblUser_2] UNIQUE NONCLUSTERED ([fldUserName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [FK_tblUser_tblEmployee] FOREIGN KEY ([fldEmployId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Com].[tblUser] ADD CONSTRAINT [FK_tblUser_tblUser1] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
