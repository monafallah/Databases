CREATE TABLE [Drd].[tblPardakhtFiles_Detail]
(
[fldId] [int] NOT NULL,
[fldShenaseGhabz] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShenasePardakht] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhPardakht] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPardakhtFiles_Detail_fldTarikhPardakht] DEFAULT (getdate()),
[fldCodeRahgiry] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNahvePardakhtId] [int] NOT NULL,
[fldPardakhtFileId] [int] NOT NULL CONSTRAINT [DF_tblPardakhtFiles_Detail_fldPardakhtFileId] DEFAULT ((1)),
[fldOrganId] [int] NOT NULL CONSTRAINT [DF_tblPardakhtFiles_Detail_fldCountryDivisionId] DEFAULT ((1)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPardakhtFiles_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPardakhtFiles_Detail_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPardakhtFiles_Detail] ADD CONSTRAINT [PK_tblPardakhtFiles_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPardakhtFiles_Detail] ADD CONSTRAINT [FK_tblPardakhtFiles_Detail_tblNahvePardakht] FOREIGN KEY ([fldNahvePardakhtId]) REFERENCES [Drd].[tblNahvePardakht] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFiles_Detail] ADD CONSTRAINT [FK_tblPardakhtFiles_Detail_tblOrganization] FOREIGN KEY ([fldOrganId]) REFERENCES [Com].[tblOrganization] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFiles_Detail] ADD CONSTRAINT [FK_tblPardakhtFiles_Detail_tblPardakhtFile] FOREIGN KEY ([fldOrganId]) REFERENCES [Drd].[tblPardakhtFile] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFiles_Detail] ADD CONSTRAINT [FK_tblPardakhtFiles_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
