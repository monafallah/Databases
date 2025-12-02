CREATE TABLE [Com].[tblMasuolin_Detail]
(
[fldId] [int] NOT NULL,
[fldEmployId] [int] NULL,
[fldOrganPostId] [int] NULL,
[fldMasuolinId] [int] NOT NULL,
[fldOrderId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMasuolin_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMasuolin_Detail_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [PK_tblMasuolin_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [IX_tblMasuolin_Detail] UNIQUE NONCLUSTERED ([fldMasuolinId], [fldEmployId], [fldOrganPostId], [fldOrderId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [FK_tblMasuolin_Detail_tblEmployee] FOREIGN KEY ([fldEmployId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [FK_tblMasuolin_Detail_tblMasuolin] FOREIGN KEY ([fldMasuolinId]) REFERENCES [Com].[tblMasuolin] ([fldId])
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [FK_tblMasuolin_Detail_tblOrganizationPost] FOREIGN KEY ([fldOrganPostId]) REFERENCES [Com].[tblOrganizationalPosts] ([fldId])
GO
ALTER TABLE [Com].[tblMasuolin_Detail] ADD CONSTRAINT [FK_tblMasuolin_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
