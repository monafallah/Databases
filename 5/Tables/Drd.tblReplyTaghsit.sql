CREATE TABLE [Drd].[tblReplyTaghsit]
(
[fldId] [int] NOT NULL,
[fldMablaghNaghdi] [bigint] NOT NULL,
[fldTedadAghsat] [tinyint] NOT NULL,
[fldShomareMojavez] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTaghsit_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTaghsit_fldDate] DEFAULT (getdate()),
[fldStatusId] [int] NOT NULL,
[fldTedadMahAghsat] [tinyint] NOT NULL,
[fldJarimeTakhir] [bigint] NOT NULL,
[fldYear] AS (substring([dbo].[Fn_AssembelyMiladiToShamsi]([fldDate]),(1),(4))),
[fldElamAvarezId] AS ([drd].[fn_IdReplyTaghsit]([fldId])),
[fldDarsad] [decimal] (5, 2) NULL,
[fldDescKarmozd] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblReplyTaghsit_fldDescKarmozd] DEFAULT ('')
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblReplyTaghsit] ADD CONSTRAINT [CK_tblReplyTaghsit] CHECK ((len([fldTarikh])>=(2)))
GO
ALTER TABLE [Drd].[tblReplyTaghsit] ADD CONSTRAINT [PK_tblTaghsit] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblReplyTaghsit] ADD CONSTRAINT [FK_tblReplyTaghsit_tblStatusTaghsit_Takhfif] FOREIGN KEY ([fldStatusId]) REFERENCES [Drd].[tblStatusTaghsit_Takhfif] ([fldId])
GO
ALTER TABLE [Drd].[tblReplyTaghsit] ADD CONSTRAINT [FK_tblTaghsit_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
