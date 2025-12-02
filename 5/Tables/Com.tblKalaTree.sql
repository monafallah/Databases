CREATE TABLE [Com].[tblKalaTree]
(
[fldId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldGroupId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKalaTree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKalaTree_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [PK_tblKalaTree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [IX_tblKalaTree] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [FK_tblKalaTree_tblKalaGroup] FOREIGN KEY ([fldGroupId]) REFERENCES [Com].[tblKalaGroup] ([fldId])
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [FK_tblKalaTree_tblKalaTree1] FOREIGN KEY ([fldPID]) REFERENCES [Com].[tblKalaTree] ([fldId])
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [FK_tblKalaTree_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblKalaTree] ADD CONSTRAINT [FK_tblKalaTree_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
