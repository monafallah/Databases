CREATE TABLE [Drd].[tblDaramadGroup]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDaramadGroup_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDaramadGroup_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblDaramadGroup] ADD CONSTRAINT [PK_tblDaramadGroup] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblDaramadGroup] ADD CONSTRAINT [FK_tblDaramadGroup_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
