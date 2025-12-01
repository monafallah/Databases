CREATE TABLE [dbo].[tblUser]
(
[fldId] [int] NOT NULL,
[fldUserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldPassword] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldActive_Deactive] [bit] NOT NULL,
[fldFirstLogin] [bit] NOT NULL CONSTRAINT [DF_tblUser_fldFirstLogin_1] DEFAULT ((0)),
[fldShakhsId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblUser_fldDesc_1] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblUser_fldDate_1] DEFAULT (getdate()),
[fldInputID] [int] NOT NULL,
[fldUserType] [tinyint] NOT NULL,
[fldType] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [IX_tblUser] UNIQUE NONCLUSTERED ([fldUserName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [FK_tblUser_tblAshkhas] FOREIGN KEY ([fldShakhsId]) REFERENCES [dbo].[tblAshkhas] ([fldId])
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [FK_tblUser_tblInputInfo] FOREIGN KEY ([fldInputID]) REFERENCES [dbo].[tblInputInfo] ([fldId])
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [FK_tblUser_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون ورود و خروج', 'SCHEMA', N'dbo', 'TABLE', N'tblUser', 'COLUMN', N'fldInputID'
GO
