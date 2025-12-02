CREATE TABLE [Drd].[tblMahdoodiyatMohasebat_Ashkhas]
(
[fldId] [int] NOT NULL,
[fldMahdoodiyatMohasebatId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_Ashkhas_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMahdoodiyatMohasebat_Ashkhas_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_Ashkhas] ADD CONSTRAINT [PK_tblMahdoodiyatMohasebat_Ashkhas] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_Ashkhas] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_Ashkhas_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_Ashkhas] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_Ashkhas_tblMahdoodiyatMohasebat] FOREIGN KEY ([fldMahdoodiyatMohasebatId]) REFERENCES [Drd].[tblMahdoodiyatMohasebat] ([fldId])
GO
ALTER TABLE [Drd].[tblMahdoodiyatMohasebat_Ashkhas] ADD CONSTRAINT [FK_tblMahdoodiyatMohasebat_Ashkhas_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
