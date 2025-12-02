CREATE TABLE [Drd].[tblShomareNameHa]
(
[fldId] [int] NOT NULL,
[fldMokatebatId] [int] NULL,
[fldReplyTaghsitId] [int] NULL,
[fldYear] [smallint] NOT NULL,
[fldShomare] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [Daramad]
GO
ALTER TABLE [Drd].[tblShomareNameHa] ADD CONSTRAINT [PK_tblShomareNameHa] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblShomareNameHa] ADD CONSTRAINT [FK_tblShomareNameHa_tblMokatebat] FOREIGN KEY ([fldMokatebatId]) REFERENCES [Drd].[tblMokatebat] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareNameHa] ADD CONSTRAINT [FK_tblShomareNameHa_tblReplyTaghsit] FOREIGN KEY ([fldReplyTaghsitId]) REFERENCES [Drd].[tblReplyTaghsit] ([fldId])
GO
ALTER TABLE [Drd].[tblShomareNameHa] ADD CONSTRAINT [FK_tblShomareNameHa_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
