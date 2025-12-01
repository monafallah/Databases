CREATE TABLE [dbo].[tblContract]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCreatedDate] [datetime] NOT NULL,
[fldTechnologies] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldImageUrl] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblContract_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContract_fldDate] DEFAULT (getdate()),
[fldDemoUrl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldGitHubUrl] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblContract] ADD CONSTRAINT [PK_tblContract] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
