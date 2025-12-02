CREATE TABLE [Drd].[tblRequestTaghsit_Takhfif]
(
[fldId] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldRequestType] [tinyint] NOT NULL,
[fldEmployeeId] [int] NOT NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldEmail] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldCodePosti] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldMobile] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblRequestTaghsit_Takhfif_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblRequestTaghsit_Takhfif_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [CK_tblRequestTaghsit_Takhfif] CHECK ((len([fldAddress])>=(2)))
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [CK_tblRequestTaghsit_Takhfif_1] CHECK ((len([fldEmail])>=(2)))
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [CK_tblRequestTaghsit_Takhfif_2] CHECK ((len([fldCodePosti])>=(2)))
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [CK_tblRequestTaghsit_Takhfif_3] CHECK ((len([fldMobile])>=(2)))
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [CK_tblRequestTaghsit_Takhfif_4] CHECK (([com].[fn_AppEmailCheck]([fldEmail])=(1)))
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [PK_tblRequestTaghsit_Takhfif] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
CREATE NONCLUSTERED INDEX [IX_tblRequestTaghsit_Takhfif] ON [Drd].[tblRequestTaghsit_Takhfif] ([fldElamAvarezId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [FK_tblRequestTaghsit_Takhfif_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [FK_tblRequestTaghsit_Takhfif_tblEmployee] FOREIGN KEY ([fldEmployeeId]) REFERENCES [Com].[tblEmployee] ([fldId])
GO
ALTER TABLE [Drd].[tblRequestTaghsit_Takhfif] ADD CONSTRAINT [FK_tblRequestTaghsit_Takhfif_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
