CREATE TABLE [Com].[tblKala_Tree]
(
[fldId] [int] NOT NULL,
[fldKalaId] [int] NOT NULL,
[fldKalaTreeId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKala_Tree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKala_Tree_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKala_Tree] ADD CONSTRAINT [PK_tblKala_Tree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblKala_Tree] ADD CONSTRAINT [FK_tblKala_Tree_tblKala] FOREIGN KEY ([fldKalaId]) REFERENCES [Str].[tblKala] ([fldId])
GO
ALTER TABLE [Com].[tblKala_Tree] ADD CONSTRAINT [FK_tblKala_Tree_tblKalaTree] FOREIGN KEY ([fldKalaTreeId]) REFERENCES [Com].[tblKalaTree] ([fldId])
GO
ALTER TABLE [Com].[tblKala_Tree] ADD CONSTRAINT [FK_tblKala_Tree_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Com].[tblKala_Tree] ADD CONSTRAINT [FK_tblKala_Tree_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
