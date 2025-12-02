CREATE TABLE [Drd].[tblNahvePardakht]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblNahvePardakht_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblNahvePardakht_fldDate] DEFAULT (getdate()),
[fldCodePardakht] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [CK_tblNahvePardakht] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [CK_tblNahvePardakht_1] CHECK ((len([fldCodePardakht])>=(2)))
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [PK_tblNahvePardakht] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [IX_tblNahvePardakht_1] UNIQUE NONCLUSTERED ([fldCodePardakht]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [IX_tblNahvePardakht] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblNahvePardakht] ADD CONSTRAINT [FK_tblNahvePardakht_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
