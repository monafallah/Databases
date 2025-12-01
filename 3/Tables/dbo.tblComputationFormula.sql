CREATE TABLE [dbo].[tblComputationFormula]
(
[fldId] [int] NOT NULL,
[fldFormul] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldLibrary] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblComputationFormula_fldDesc] DEFAULT (''),
[fldCompiledCode] [varbinary] (max) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblComputationFormula] ADD CONSTRAINT [PK_tblComputationFormula] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'محاسبات', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'کدهای گرداوری شده', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', 'COLUMN', N'fldCompiledCode'
GO
EXEC sp_addextendedproperty N'MS_Description', N'توضیحات', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', 'COLUMN', N'fldDesc'
GO
EXEC sp_addextendedproperty N'MS_Description', N'فرمول', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', 'COLUMN', N'fldFormul'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کد ', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', 'COLUMN', N'fldId'
GO
EXEC sp_addextendedproperty N'MS_Description', N'کتابخانه ها', 'SCHEMA', N'dbo', 'TABLE', N'tblComputationFormula', 'COLUMN', N'fldLibrary'
GO
