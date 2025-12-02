CREATE TABLE [Drd].[tblReplyTakhfif]
(
[fldId] [int] NOT NULL,
[fldDarsad] [decimal] (5, 2) NOT NULL,
[fldStatusId] [int] NOT NULL,
[fldMablagh] [bigint] NOT NULL,
[fldShomareMajavez] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTakhfif_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTakhfif_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblReplyTakhfif] ADD CONSTRAINT [CK_tblReplyTakhfif] CHECK (([fldDarsad]>=(0) AND [fldDarsad]<=(100)))
GO
ALTER TABLE [Drd].[tblReplyTakhfif] ADD CONSTRAINT [CK_tblReplyTakhfif_2] CHECK ((len([fldTarikh])>=(2)))
GO
ALTER TABLE [Drd].[tblReplyTakhfif] ADD CONSTRAINT [PK_tblTakhfif] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblReplyTakhfif] ADD CONSTRAINT [FK_tblReplyTakhfif_tblStatusTaghsit_Takhfif] FOREIGN KEY ([fldStatusId]) REFERENCES [Drd].[tblStatusTaghsit_Takhfif] ([fldId])
GO
ALTER TABLE [Drd].[tblReplyTakhfif] ADD CONSTRAINT [FK_tblTakhfif_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
