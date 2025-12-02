CREATE TABLE [Drd].[tblMohdoodiyatMohasebat_User]
(
[fldId] [int] NOT NULL,
[fldIdUser] [int] NOT NULL,
[fldMahdoodiyatMohasebatId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMohdoodiyatMohasebat_User_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMohdoodiyatMohasebat_User_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMohdoodiyatMohasebat_User] ADD CONSTRAINT [PK_tblMohdoodiyatMohasebat_User] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblMohdoodiyatMohasebat_User] ADD CONSTRAINT [FK_tblMohdoodiyatMohasebat_User_tblMahdoodiyatMohasebat] FOREIGN KEY ([fldMahdoodiyatMohasebatId]) REFERENCES [Drd].[tblMahdoodiyatMohasebat] ([fldId])
GO
ALTER TABLE [Drd].[tblMohdoodiyatMohasebat_User] ADD CONSTRAINT [FK_tblMohdoodiyatMohasebat_User_tblUser] FOREIGN KEY ([fldIdUser]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Drd].[tblMohdoodiyatMohasebat_User] ADD CONSTRAINT [FK_tblMohdoodiyatMohasebat_User_tblUser1] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
