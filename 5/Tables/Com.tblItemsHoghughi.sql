CREATE TABLE [Com].[tblItemsHoghughi]
(
[fldId] [int] NOT NULL,
[fldTitle] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameEN] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldType] [tinyint] NOT NULL CONSTRAINT [DF_tblItemsHoghughi_fldType] DEFAULT ((2)),
[fldTypeHesabId] [tinyint] NULL CONSTRAINT [DF_tblItemsHoghughi_fldTypeHesab] DEFAULT ((2)),
[fldUserId] [int] NULL,
[fldDate] [datetime] NULL CONSTRAINT [DF_tblItemsHoghughi_fldDate] DEFAULT (getdate()),
[fldMostamar] [tinyint] NULL CONSTRAINT [DF_tblItemsHoghughi_fldMostamar] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblItemsHoghughi] ADD CONSTRAINT [CK_tblItemsHoghughi] CHECK ((len([fldTitle])>=(2)))
GO
ALTER TABLE [Com].[tblItemsHoghughi] ADD CONSTRAINT [PK_tblItemsHoghughi] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblItemsHoghughi] ADD CONSTRAINT [IX_tblItemsHoghughi] UNIQUE NONCLUSTERED ([fldTitle]) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblItemsHoghughi] ADD CONSTRAINT [FK_tblItemsHoghughi_tblItemsHoghughi] FOREIGN KEY ([fldTypeHesabId]) REFERENCES [Com].[tblHesabType] ([fldId])
GO
