CREATE TABLE [Com].[tblTypeEstekhdam_Formul]
(
[fldId] [tinyint] NOT NULL,
[fldTitle] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_Formul_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTypeEstekhdam_Formul_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeEstekhdam_Formul] ADD CONSTRAINT [PK_tblTypeEstekhdam_Formul] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblTypeEstekhdam_Formul] ADD CONSTRAINT [FK_tblTypeEstekhdam_Formul_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
