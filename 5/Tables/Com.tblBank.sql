CREATE TABLE [Com].[tblBank]
(
[fldId] [int] NOT NULL,
[fldBankName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Com_tblBank_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Com_tblBank_fldDesc] DEFAULT (''),
[fldCentralBankCode] [tinyint] NULL,
[fldInfinitiveBank] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBank_fldInfinitiveBank] DEFAULT (''),
[fldFix] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [CK_tblBank] CHECK ((len([fldBankName])>=(2)))
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [PK_Com_tblBank] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [IX_tblBank] UNIQUE NONCLUSTERED ([fldBankName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [FK_tblBank_tblBank] FOREIGN KEY ([fldId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [FK_tblBank_tblFile] FOREIGN KEY ([fldFileId]) REFERENCES [Com].[tblFile] ([fldId])
GO
ALTER TABLE [Com].[tblBank] ADD CONSTRAINT [FK_tblBank_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
