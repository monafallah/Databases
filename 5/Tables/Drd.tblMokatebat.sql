CREATE TABLE [Drd].[tblMokatebat]
(
[fldId] [int] NOT NULL,
[fldCodhayeDaramadiElamAvarezId] [int] NOT NULL,
[fldFileId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMokatebat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMokatebat_fldDate] DEFAULT (getdate()),
[fldYear] AS (substring([dbo].[Fn_AssembelyMiladiToShamsi]([fldDate]),(1),(4)))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMokatebat] ADD CONSTRAINT [PK_tblMokatebat] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMokatebat] ADD CONSTRAINT [FK_tblMokatebat_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldCodhayeDaramadiElamAvarezId]) REFERENCES [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID])
GO
ALTER TABLE [Drd].[tblMokatebat] ADD CONSTRAINT [FK_tblMokatebat_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Drd].[tblMokatebat] ADD CONSTRAINT [FK_tblMokatebat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
