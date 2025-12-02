CREATE TABLE [Com].[tblKalaGroup]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKalaGroup_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKalaGroup_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaGroup] ADD CONSTRAINT [PK_tblKalaGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaGroup] ADD CONSTRAINT [IX_tblKalaGroup] UNIQUE NONCLUSTERED ([fldName], [fldOrganId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaGroup] ADD CONSTRAINT [FK_tblKalaGroup_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblKalaGroup] ADD CONSTRAINT [FK_tblKalaGroup_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
