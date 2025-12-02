CREATE TABLE [ACC].[tblTemplateName]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAccountingTypeId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTemplateName_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTemplateName_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateName] ADD CONSTRAINT [PK_tblTemplateName] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateName] ADD CONSTRAINT [IX_tblTemplateName] UNIQUE NONCLUSTERED ([fldName], [fldAccountingTypeId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblTemplateName] ADD CONSTRAINT [FK_tblTemplateName_tblAccountingType] FOREIGN KEY ([fldAccountingTypeId]) REFERENCES [ACC].[tblAccountingType] ([fldId])
GO
ALTER TABLE [ACC].[tblTemplateName] ADD CONSTRAINT [FK_tblTemplateName_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
