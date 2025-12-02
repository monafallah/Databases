CREATE TABLE [Pay].[tblTypeNesbat]
(
[fldId] [tinyint] NOT NULL,
[fldTypeName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblTypeNesbat] ADD CONSTRAINT [PK_tblTypeNesbat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد یکتا', 'SCHEMA', N'Pay', 'TABLE', N'tblTypeNesbat', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه', 'SCHEMA', N'Pay', 'TABLE', N'tblTypeNesbat', 'COLUMN', N'fldTypeName'
GO
