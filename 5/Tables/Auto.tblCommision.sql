CREATE TABLE [Auto].[tblCommision]
(
[fldID] [int] NOT NULL,
[fldAshkhasID] [int] NOT NULL,
[fldOrganizPostEjraeeID] [int] NOT NULL,
[fldStartDate] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEndDate] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganicNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganID] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCommision_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCommision_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSign] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblCommision] ADD CONSTRAINT [PK_tblCommision] PRIMARY KEY CLUSTERED ([fldID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblCommision_1] ON [Auto].[tblCommision] ([fldOrganizPostEjraeeID], [fldAshkhasID]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblCommision] ADD CONSTRAINT [FK_tblCommision_tblAshkhas] FOREIGN KEY ([fldAshkhasID]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Auto].[tblCommision] ADD CONSTRAINT [FK_tblCommision_tblOrganization] FOREIGN KEY ([fldOrganID]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Auto].[tblCommision] ADD CONSTRAINT [FK_tblCommision_tblOrganizationalPostsEjraee] FOREIGN KEY ([fldOrganizPostEjraeeID]) REFERENCES [Com].[tblOrganizationalPostsEjraee] ([fldId])
GO
ALTER TABLE [Auto].[tblCommision] ADD CONSTRAINT [FK_tblCommision_tblUser] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
