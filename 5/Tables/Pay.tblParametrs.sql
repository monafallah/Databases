CREATE TABLE [Pay].[tblParametrs]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (200) COLLATE Persian_100_CI_AI NOT NULL,
[fldTypeParametr] [bit] NOT NULL,
[fldTypeMablagh] [bit] NOT NULL,
[fldTypeEstekhdamId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametrs_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametrs_fldDate] DEFAULT (getdate()),
[fldActive] [bit] NULL CONSTRAINT [DF_tblParametrs_fldActive] DEFAULT ((1)),
[fldPrivate] [bit] NULL CONSTRAINT [DF_tblParametrs_fldPrivate] DEFAULT ((0)),
[fldHesabTypeParam] [tinyint] NULL CONSTRAINT [DF_tblParametrs_fldHesabTypeParamId] DEFAULT ((2)),
[fldOrganId] [int] NULL,
[fldIsMostamar] [tinyint] NULL CONSTRAINT [DF_tblParametrs_fldIsMostamar] DEFAULT ((0))
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblParametrs] ADD CONSTRAINT [PK_tblParametrs] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblParametrs] ADD CONSTRAINT [FK_tblParametrs_tblTypeEstekhdam] FOREIGN KEY ([fldTypeEstekhdamId]) REFERENCES [Com].[tblTypeEstekhdam] ([fldId])
GO
