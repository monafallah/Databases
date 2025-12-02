CREATE TABLE [ACC].[tblLevelsAccountingType]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAccountTypeId] [int] NOT NULL,
[fldArghumNum] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLevelsAccountingType_fldDesc] DEFAULT (''),
[flddate] [datetime] NOT NULL CONSTRAINT [DF_tblLevelsAccountingType_flddate] DEFAULT (getdate()),
[fldIp] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblLevelsAccountingType] ADD CONSTRAINT [PK_tblLevelsAccountingType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblLevelsAccountingType] ADD CONSTRAINT [IX_tblLevelsAccountingType] UNIQUE NONCLUSTERED ([fldName], [fldAccountTypeId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblLevelsAccountingType] ADD CONSTRAINT [FK_tblLevelsAccountingType_tblAccountingType] FOREIGN KEY ([fldAccountTypeId]) REFERENCES [ACC].[tblAccountingType] ([fldId])
GO
ALTER TABLE [ACC].[tblLevelsAccountingType] ADD CONSTRAINT [FK_tblLevelsAccountingType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
