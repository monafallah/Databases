CREATE TABLE [Drd].[tblTakhfifDetail]
(
[fldId] [int] NOT NULL,
[fldTakhfifId] [int] NOT NULL,
[fldShCodeDaramad] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTakhfifDetail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTakhfifDetail_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTakhfifDetail] ADD CONSTRAINT [PK_tblTakhfifDetail] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblTakhfifDetail] ADD CONSTRAINT [FK_tblTakhfifDetail_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShCodeDaramad]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
ALTER TABLE [Drd].[tblTakhfifDetail] ADD CONSTRAINT [FK_tblTakhfifDetail_tblTakhfif] FOREIGN KEY ([fldTakhfifId]) REFERENCES [Drd].[tblTakhfif] ([fldId])
GO
ALTER TABLE [Drd].[tblTakhfifDetail] ADD CONSTRAINT [FK_tblTakhfifDetail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
