CREATE TABLE [ACC].[tblCaseType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCaseType_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCaseType_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCaseType] ADD CONSTRAINT [PK_tblCaseType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCaseType] ADD CONSTRAINT [IX_tblCaseType] UNIQUE NONCLUSTERED ([fldName]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCaseType] ADD CONSTRAINT [FK_tblCaseType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
