CREATE TABLE [Drd].[tblPardakhtFile]
(
[fldId] [int] NOT NULL,
[fldBankId] [int] NOT NULL,
[fldFileName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDateSendFile] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPardakhtFile_fldDateSendFile] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPardakhtFile_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPardakhtFile_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPardakhtFile] ADD CONSTRAINT [PK_tblPardakhtFile] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPardakhtFile] ADD CONSTRAINT [FK_tblPardakhtFile_tblBank] FOREIGN KEY ([fldBankId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Drd].[tblPardakhtFile] ADD CONSTRAINT [FK_tblPardakhtFile_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
