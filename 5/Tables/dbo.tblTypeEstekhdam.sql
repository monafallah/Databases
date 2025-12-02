CREATE TABLE [dbo].[tblTypeEstekhdam]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTypeEstekhdam] ADD CONSTRAINT [PK_tblTypeEstekhdam_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
