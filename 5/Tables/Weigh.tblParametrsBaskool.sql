CREATE TABLE [Weigh].[tblParametrsBaskool]
(
[fldId] [int] NOT NULL,
[fldEnName] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFaName] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametrsBaskool_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametrsBaskool_fldDate] DEFAULT (getdate()),
[fldIP] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblParametrsBaskool] ADD CONSTRAINT [PK_tblParametrsBaskool] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Weigh].[tblParametrsBaskool] ADD CONSTRAINT [FK_tblParametrsBaskool_tblParametrsBaskool] FOREIGN KEY ([fldId]) REFERENCES [Weigh].[tblParametrsBaskool] ([fldId])
GO
