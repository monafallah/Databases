CREATE TABLE [ACC].[tblDocumentDesc]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDocDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblDocumentDesc_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblDocumentDesc_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldFlag] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentDesc] ADD CONSTRAINT [PK_tblDocumentDesc_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentDesc] ADD CONSTRAINT [IX_tblDocumentDesc] UNIQUE NONCLUSTERED ([fldName], [fldFlag]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblDocumentDesc] ADD CONSTRAINT [FK_tblDocumentDesc_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
