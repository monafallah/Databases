CREATE TABLE [dbo].[tblLimitationMacAddress]
(
[fldId] [int] NOT NULL,
[fldUserLimId] [int] NOT NULL,
[fldMacValid] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblLimitationMacAddress_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblLimitationMacAddress] ADD CONSTRAINT [PK_tblLimitationMacAddress] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblLimitationMacAddress] ADD CONSTRAINT [IX_tblLimitationMacAddress] UNIQUE NONCLUSTERED ([fldMacValid], [fldUserLimId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblLimitationMacAddress] ADD CONSTRAINT [FK_tblLimitationMacAddress_tblUser] FOREIGN KEY ([fldUserLimId]) REFERENCES [dbo].[tblUser] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'محدودیت مک آدرس', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationMacAddress', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationMacAddress', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ستون آی دی', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationMacAddress', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'مک آدرس', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationMacAddress', 'COLUMN', N'fldMacValid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد کاربر محدود', 'SCHEMA', N'dbo', 'TABLE', N'tblLimitationMacAddress', 'COLUMN', N'fldUserLimId'
GO
