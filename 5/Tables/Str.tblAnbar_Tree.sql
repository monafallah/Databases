CREATE TABLE [Str].[tblAnbar_Tree]
(
[fldId] [int] NOT NULL,
[fldAnbarId] [int] NOT NULL,
[fldAnbarTreeId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAnbar_Tree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAnbar_Tree_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblAnbar_Tree] ADD CONSTRAINT [PK_tblAnbar_Tree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblAnbar_Tree] ADD CONSTRAINT [FK_tblAnbar_Tree_tblAnbar] FOREIGN KEY ([fldAnbarId]) REFERENCES [Str].[tblAnbar] ([fldId])
GO
ALTER TABLE [Str].[tblAnbar_Tree] ADD CONSTRAINT [FK_tblAnbar_Tree_tblAnbarTree] FOREIGN KEY ([fldAnbarTreeId]) REFERENCES [Str].[tblAnbarTree] ([fldId])
GO
