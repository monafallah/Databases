CREATE TABLE [dbo].[tblCounty]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[fldStateId] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCounty] ADD CONSTRAINT [PK_tblCounty] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCounty] ADD CONSTRAINT [FK_tblCounty_tblState] FOREIGN KEY ([fldStateId]) REFERENCES [dbo].[tblState] ([fldId])
GO
EXEC sp_addextendedproperty N'MS_Description', N'شهرستان', 'SCHEMA', N'dbo', 'TABLE', N'tblCounty', NULL, NULL
GO
