CREATE TABLE [Com].[tblSHobe]
(
[fldId] [int] NOT NULL,
[fldBankId] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldCodeSHobe] [int] NOT NULL,
[fldAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSHobe_fldAddress] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblSHobe_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblSHobe_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblSHobe] ADD CONSTRAINT [PK_Com_tblSHobe] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblSHobe] ADD CONSTRAINT [IX_tblSHobe] UNIQUE NONCLUSTERED ([fldBankId], [fldName]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblSHobe] ADD CONSTRAINT [FK_tblSHobe_tblBank] FOREIGN KEY ([fldBankId]) REFERENCES [Com].[tblBank] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Com].[tblSHobe] ADD CONSTRAINT [FK_tblSHobe_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
