CREATE TABLE [Drd].[tblMahdoodiyatMohasebat]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAzTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTatarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNoeKarbar] [bit] NOT NULL,
[fldNoeCodeDaramad] [bit] NOT NULL,
[fldNoeAshkhas] [bit] NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat] ADD CONSTRAINT [PK_tblMahdoodiyatMohasebat] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
