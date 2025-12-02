CREATE TABLE [Com].[tblOrganizationalPostsEjraee]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrgPostCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldChartOrganId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOrganizationalPostsEjraee_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOrganizationalPostsEjraee_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganizationalPostsEjraee] ADD CONSTRAINT [PK_tblOrganizationalPostsEjraee] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblOrganizationalPostsEjraee] ADD CONSTRAINT [FK_tblOrganizationalPostsEjraee_tblChartOrganEjraee] FOREIGN KEY ([fldChartOrganId]) REFERENCES [Com].[tblChartOrganEjraee] ([fldId])
GO
ALTER TABLE [Com].[tblOrganizationalPostsEjraee] ADD CONSTRAINT [FK_tblOrganizationalPostsEjraee_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
