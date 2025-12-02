CREATE TABLE [Drd].[tblFormatShomareName]
(
[fldId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldFormatShomareName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldShomareShoro] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblFormatShomareShenasname_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblFormatShomareShenasname_fldDate] DEFAULT (getdate()),
[fldType] [bit] NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblFormatShomareName] ADD CONSTRAINT [CK_tblFormatShomareName] CHECK ((len([fldFormatShomareName])>=(2)))
GO
ALTER TABLE [Drd].[tblFormatShomareName] ADD CONSTRAINT [PK_tblFormatShomareShenasname] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblFormatShomareName] ADD CONSTRAINT [IX_tblFormatShomareName] UNIQUE NONCLUSTERED ([fldYear], [fldType]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblFormatShomareName] ADD CONSTRAINT [FK_tblFormatShomareShenasname_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
