CREATE TABLE [Pay].[tblTavighKosurat]
(
[fldId] [int] NOT NULL,
[fldKosuratId] [int] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMonth] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTavighKosurat_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTavighKosurat_fldDate] DEFAULT (getdate())
) ON [PayRoll] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblTavighKosurat] ADD CONSTRAINT [PK_tblTavighKosurat] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblTavighKosurat] ADD CONSTRAINT [FK_tblTavighKosurat_tblKosorateParametri_Personal] FOREIGN KEY ([fldKosuratId]) REFERENCES [Pay].[tblKosorateParametri_Personal] ([fldId])
GO
ALTER TABLE [Pay].[tblTavighKosurat] ADD CONSTRAINT [FK_tblTavighKosurat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
