CREATE TABLE [Drd].[tblEbtal]
(
[fldId] [int] NOT NULL,
[fldFishId] [int] NULL,
[fldRequestTaghsit_TakhfifId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblEbtal_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblEbtal_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblEbtal] ADD CONSTRAINT [PK_tblEbtal] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblEbtal] ADD CONSTRAINT [FK_tblEbtal_tblFish] FOREIGN KEY ([fldFishId]) REFERENCES [Drd].[tblSodoorFish] ([fldId])
GO
ALTER TABLE [Drd].[tblEbtal] ADD CONSTRAINT [FK_tblEbtal_tblRequestTaghsit_Takhfif] FOREIGN KEY ([fldRequestTaghsit_TakhfifId]) REFERENCES [Drd].[tblRequestTaghsit_Takhfif] ([fldId])
GO
ALTER TABLE [Drd].[tblEbtal] ADD CONSTRAINT [FK_tblEbtal_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
