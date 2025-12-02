CREATE TABLE [ACC].[tblCase]
(
[fldId] [int] NOT NULL,
[fldCaseTypeId] [int] NOT NULL,
[fldSourceId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCase_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCase_fldDate] DEFAULT (getdate()),
[fldIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCase] ADD CONSTRAINT [PK_tblCase] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCase] ADD CONSTRAINT [FK_tblCase_tblCaseType] FOREIGN KEY ([fldCaseTypeId]) REFERENCES [ACC].[tblCaseType] ([fldId])
GO
ALTER TABLE [ACC].[tblCase] ADD CONSTRAINT [FK_tblCase_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
