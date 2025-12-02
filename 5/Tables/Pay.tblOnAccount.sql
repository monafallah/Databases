CREATE TABLE [Pay].[tblOnAccount]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldTitle] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblOnAccount_fldTitle] DEFAULT (''),
[fldCodeMeli] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[fldNobatePardakt] [tinyint] NOT NULL CONSTRAINT [DF_tblOnAccount_fldNobatePardakt] DEFAULT ((1)),
[fldYear] [smallint] NOT NULL CONSTRAINT [DF_tblOnAccount_fldYear] DEFAULT ((1394)),
[fldMonth] [tinyint] NOT NULL CONSTRAINT [DF_tblOnAccount_fldMonth] DEFAULT ((1)),
[fldKhalesPardakhti] [int] NOT NULL,
[fldFlag] [bit] NOT NULL,
[fldGhatei] [bit] NOT NULL CONSTRAINT [DF_tblOnAccount_fldGhatei] DEFAULT ((0)),
[fldShomareHesab] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblOnAccount_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblOnAccount] ADD CONSTRAINT [PK_tblOnAccount] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblOnAccount] ON [Pay].[tblOnAccount] ([fldYear], [fldMonth], [fldTitle], [fldCodeMeli], [fldNobatePardakt], [fldGhatei]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblOnAccount] ADD CONSTRAINT [FK_tblOnAccount_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
