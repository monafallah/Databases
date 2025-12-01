CREATE TABLE [Cnt].[tblContact_Ashkhas]
(
[fldId] [int] NOT NULL,
[fldAshkhasId] [int] NOT NULL,
[fldContactId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cnt].[tblContact_Ashkhas] ADD CONSTRAINT [PK_tblContact_Ashkhas] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cnt].[tblContact_Ashkhas] ADD CONSTRAINT [FK_tblContact_Ashkhas_tblAshkhas] FOREIGN KEY ([fldAshkhasId]) REFERENCES [dbo].[tblAshkhas] ([fldId])
GO
ALTER TABLE [Cnt].[tblContact_Ashkhas] ADD CONSTRAINT [FK_tblContact_Ashkhas_tblContact] FOREIGN KEY ([fldContactId]) REFERENCES [Cnt].[tblContact] ([fldId]) ON DELETE CASCADE
GO
EXEC sp_addextendedproperty N'MS_Description', N'تماس -اشخاص', 'SCHEMA', N'Cnt', 'TABLE', N'tblContact_Ashkhas', NULL, NULL
GO
