CREATE TABLE [Drd].[tblCompany]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShenaseMeli] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldKarbarId] [int] NOT NULL,
[fldURL] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCompany_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCompany_fldDate] DEFAULT (getdate()),
[fldUserNameService] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCompany_fldUserName] DEFAULT (''),
[fldPassService] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCompany_fldPass] DEFAULT (''),
[fldOrganId] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCompany] ADD CONSTRAINT [PK_tblCompany] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblCompany] ADD CONSTRAINT [IX_tblCompany] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblCompany] ADD CONSTRAINT [FK_tblCompany_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblCompany] ADD CONSTRAINT [FK_tblCompany_tblUser] FOREIGN KEY ([fldKarbarId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Drd].[tblCompany] ADD CONSTRAINT [FK_tblCompany_tblUser1] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
