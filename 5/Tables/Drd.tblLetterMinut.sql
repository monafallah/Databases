CREATE TABLE [Drd].[tblLetterMinut]
(
[fldId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDescMinut] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_com.d_letterMinut_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_com.d_letterMinut_fldDesc] DEFAULT (''),
[fldSodoorBadAzVarizNaghdi] [bit] NOT NULL,
[fldSodoorBadAzTaghsit] [bit] NOT NULL,
[fldTanzimkonande] [bit] NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblLetterMinut] ADD CONSTRAINT [CK_tblLetterMinut] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Drd].[tblLetterMinut] ADD CONSTRAINT [CK_tblLetterMinut_1] CHECK ((len([fldDescMinut])>=(2)))
GO
ALTER TABLE [Drd].[tblLetterMinut] ADD CONSTRAINT [PK_com.d_letterMinut] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblLetterMinut] ADD CONSTRAINT [FK_tblLetterMinut_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblLetterMinut] ADD CONSTRAINT [FK_tblLetterMinut_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
