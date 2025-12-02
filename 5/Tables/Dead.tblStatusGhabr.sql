CREATE TABLE [Dead].[tblStatusGhabr]
(
[fldId] [int] NOT NULL,
[fldShomareId] [int] NOT NULL,
[fldStatus] [tinyint] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblStatusGhabr_fldDate] DEFAULT (getdate()),
[fldOrganId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblStatusGhabr] ADD CONSTRAINT [PK_tblStatusGhabr] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'1)رزرو
2)امانت
3)فوت شده', 'SCHEMA', N'Dead', 'TABLE', N'tblStatusGhabr', 'COLUMN', N'fldStatus'
GO
