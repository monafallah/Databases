CREATE TABLE [Cntr].[tblTamdidTypes]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTamdidTypes] ADD CONSTRAINT [PK_tblTamdidTypes] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblTamdidTypes] ADD CONSTRAINT [IX_tblTamdidTypes] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
