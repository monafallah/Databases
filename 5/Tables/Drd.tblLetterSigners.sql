CREATE TABLE [Drd].[tblLetterSigners]
(
[fldId] [int] NOT NULL,
[fldLetterMinutId] [int] NOT NULL,
[fldOrganizationalPostsId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Drd.tblLetterSigners_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Drd.tblLetterSigners_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblLetterSigners] ADD CONSTRAINT [PK_Drd.tblLetterSigners] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblLetterSigners] ADD CONSTRAINT [FK_Drd.tblLetterSigners_tblLetterMinut] FOREIGN KEY ([fldLetterMinutId]) REFERENCES [Drd].[tblLetterMinut] ([fldId])
GO
ALTER TABLE [Drd].[tblLetterSigners] ADD CONSTRAINT [FK_Drd.tblLetterSigners_tblOrganizationalPosts] FOREIGN KEY ([fldOrganizationalPostsId]) REFERENCES [Com].[tblOrganizationalPosts] ([fldId])
GO
ALTER TABLE [Drd].[tblLetterSigners] ADD CONSTRAINT [FK_Drd.tblLetterSigners_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
