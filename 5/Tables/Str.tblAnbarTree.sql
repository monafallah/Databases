CREATE TABLE [Str].[tblAnbarTree]
(
[fldId] [int] NOT NULL,
[fldPID] [int] NULL,
[fldGroupId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAnbarTree_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAnbarTree_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblAnbarTree] ADD CONSTRAINT [PK_tblAnbarTree] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblAnbarTree] ADD CONSTRAINT [IX_tblAnbarTree] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [Str].[tblAnbarTree] ADD CONSTRAINT [FK_tblAnbarTree_tblAnbarGroup] FOREIGN KEY ([fldGroupId]) REFERENCES [Str].[tblAnbarGroup] ([fldId])
GO
ALTER TABLE [Str].[tblAnbarTree] ADD CONSTRAINT [FK_tblAnbarTree_tblAnbarTree] FOREIGN KEY ([fldPID]) REFERENCES [Str].[tblAnbarTree] ([fldId])
GO
ALTER TABLE [Str].[tblAnbarTree] ADD CONSTRAINT [FK_tblAnbarTree_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
