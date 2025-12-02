CREATE TABLE [Drd].[tblSafte]
(
[fldId] [int] NOT NULL,
[fldTarikhSarResid] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldReplyTaghsitId] [int] NOT NULL,
[fldShomareSanad] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMablaghSanad] [bigint] NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSafte_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSafte_fldDate] DEFAULT (getdate()),
[fldDateStatus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [CK_tblSafte] CHECK ((len([fldTarikhSarResid])>=(2)))
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [CK_tblSafte_1] CHECK ((len([fldShomareSanad])>=(2)))
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [PK_tblSafte] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [IX_tblSafte] UNIQUE NONCLUSTERED ([fldShomareSanad]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [FK_tblSafte_tblReplyTaghsit] FOREIGN KEY ([fldReplyTaghsitId]) REFERENCES [Drd].[tblReplyTaghsit] ([fldId])
GO
ALTER TABLE [Drd].[tblSafte] ADD CONSTRAINT [FK_tblSafte_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
