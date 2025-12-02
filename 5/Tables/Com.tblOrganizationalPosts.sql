CREATE TABLE [Com].[tblOrganizationalPosts]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrgPostCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldChartOrganId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOrganizationalPosts_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOrganizationalPosts_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganizationalPosts] ADD CONSTRAINT [PK_tblOrganizationalPosts] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganizationalPosts] ADD CONSTRAINT [IX_tblOrganizationalPosts] UNIQUE NONCLUSTERED ([fldTitle], [fldChartOrganId], [fldOrgPostCode]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganizationalPosts] ADD CONSTRAINT [FK_tblOrganizationalPosts_tblChartOrgan] FOREIGN KEY ([fldChartOrganId]) REFERENCES [Com].[tblChartOrgan] ([fldId])
GO
ALTER TABLE [Com].[tblOrganizationalPosts] ADD CONSTRAINT [FK_tblOrganizationalPosts_tblOrganizationalPosts] FOREIGN KEY ([fldPID]) REFERENCES [Com].[tblOrganizationalPosts] ([fldId])
GO
ALTER TABLE [Com].[tblOrganizationalPosts] ADD CONSTRAINT [FK_tblOrganizationalPosts_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
