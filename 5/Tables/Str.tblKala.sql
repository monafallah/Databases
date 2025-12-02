CREATE TABLE [Str].[tblKala]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldKalaType] [tinyint] NOT NULL,
[fldKalaCode] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldStatus] [tinyint] NOT NULL,
[fldSell] [bit] NULL,
[fldArzeshAfzodeh] [bit] NOT NULL,
[fldIranCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMoshakhaseType] [tinyint] NOT NULL,
[fldMoshakhase] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldVahedAsli] [int] NOT NULL,
[fldVahedFaree] [int] NOT NULL,
[fldNesbatType] [tinyint] NOT NULL,
[fldVahedMoadel] [int] NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblKala_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblKala_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [PK_tblKala] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [IX_tblKala_1] UNIQUE NONCLUSTERED ([fldKalaCode]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [IX_tblKala] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [FK_tblKala_tblMeasureUnit] FOREIGN KEY ([fldVahedAsli]) REFERENCES [Com].[tblMeasureUnit] ([fldId])
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [FK_tblKala_tblMeasureUnit1] FOREIGN KEY ([fldVahedFaree]) REFERENCES [Com].[tblMeasureUnit] ([fldId])
GO
ALTER TABLE [Str].[tblKala] ADD CONSTRAINT [FK_tblKala_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
