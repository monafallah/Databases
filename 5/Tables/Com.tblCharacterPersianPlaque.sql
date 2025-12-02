CREATE TABLE [Com].[tblCharacterPersianPlaque]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCharacterPersianPlaque_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCharacterPersianPlaque_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCharacterPersianPlaque] ADD CONSTRAINT [PK_tblCharacterPersianPlaque] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCharacterPersianPlaque] ADD CONSTRAINT [IX_tblCharacterPersianPlaque] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblCharacterPersianPlaque] ADD CONSTRAINT [FK_tblCharacterPersianPlaque_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
