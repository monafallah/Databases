CREATE TABLE [Drd].[tblBarat]
(
[fldId] [int] NOT NULL,
[fldTarikhSarResid] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldReplyTaghsitId] [int] NOT NULL,
[fldShomareSanad] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablaghSanad] [bigint] NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldBaratDarId] [int] NOT NULL,
[fldMakanPardakht] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBarat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBarat_fldDate] DEFAULT (getdate()),
[fldDateStatus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [CK_tblBarat] CHECK ((len([fldTarikhSarResid])>=(2)))
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [CK_tblBarat_1] CHECK ((len([fldMakanPardakht])>=(2)))
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [CK_tblBarat_2] CHECK ((len([fldShomareSanad])>=(2)))
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [PK_tblBarat] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [IX_tblBarat] UNIQUE NONCLUSTERED ([fldShomareSanad]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [FK_tblBarat_tblAshkhas] FOREIGN KEY ([fldBaratDarId]) REFERENCES [Com].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [FK_tblBarat_tblReplyTaghsit] FOREIGN KEY ([fldReplyTaghsitId]) REFERENCES [Drd].[tblReplyTaghsit] ([fldId])
GO
ALTER TABLE [Drd].[tblBarat] ADD CONSTRAINT [FK_tblBarat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
