CREATE TABLE [Drd].[tblRoonevesht]
(
[fldId] [int] NOT NULL,
[fldShomareHesabCodeDaramadId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_com.d_tblRoonevesht_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_com.d_tblRoonevesht_fldDesc] DEFAULT ('')
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblRoonevesht] ADD CONSTRAINT [PK_com.d_tblRoonevesht] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblRoonevesht] ADD CONSTRAINT [FK_com.d_tblRoonevesht_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Drd].[tblRoonevesht] ADD CONSTRAINT [FK_tblRoonevesht_tblShomareHesabCodeDaramad] FOREIGN KEY ([fldShomareHesabCodeDaramadId]) REFERENCES [Drd].[tblShomareHesabCodeDaramad] ([fldId])
GO
