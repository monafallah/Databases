CREATE TABLE [Drd].[tblMablaghTakhfif]
(
[fldId] [int] NOT NULL,
[fldTakhfifAsli] [bigint] NOT NULL,
[fldTakhfifMaliyat] [bigint] NOT NULL,
[fldTakhfifAvarez] [bigint] NOT NULL,
[fldCodeDaramadElamAvarezId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMablaghTakhfif_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMablaghTakhfif_fldDate] DEFAULT (getdate()),
[fldElamAvarezId] AS ([drd].[fn_ElamAvarezId]([fldCodeDaramadElamAvarezId])),
[fldTakhfifAmuzeshParvareshValu] [bigint] NOT NULL CONSTRAINT [DF_tblMablaghTakhfif_fldTakhfifAmuzeshParvareshValu] DEFAULT ((0))
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMablaghTakhfif] ADD CONSTRAINT [PK_tblMablaghTakhfif] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMablaghTakhfif] ADD CONSTRAINT [FK_tblMablaghTakhfif_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldCodeDaramadElamAvarezId]) REFERENCES [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID])
GO
ALTER TABLE [Drd].[tblMablaghTakhfif] ADD CONSTRAINT [FK_tblMablaghTakhfif_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
