CREATE TABLE [Com].[tblItems_Estekhdam]
(
[fldId] [int] NOT NULL,
[fldItemsHoghughiId] [int] NOT NULL,
[fldTypeEstekhdamId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldHasZarib] [bit] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblItems_Estekhdam_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblItems_Estekhdam_fldDesc] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblItems_Estekhdam] ADD CONSTRAINT [CK_tblItems_Estekhdam] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Com].[tblItems_Estekhdam] ADD CONSTRAINT [PK_tblItems_Estekhdam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblItems_Estekhdam] ADD CONSTRAINT [FK_tblItems_Estekhdam_tblItemsHoghughi] FOREIGN KEY ([fldItemsHoghughiId]) REFERENCES [Com].[tblItemsHoghughi] ([fldId])
GO
