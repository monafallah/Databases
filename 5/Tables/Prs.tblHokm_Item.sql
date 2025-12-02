CREATE TABLE [Prs].[tblHokm_Item]
(
[fldId] [int] NOT NULL,
[fldPersonalHokmId] [int] NOT NULL,
[fldItems_EstekhdamId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldZarib] [decimal] (6, 3) NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_Prs_tblHokm_Item_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Prs_tblHokm_Item_fldDesc] DEFAULT ('')
) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokm_Item] ADD CONSTRAINT [PK_tblHokm_Item] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Prs].[tblHokm_Item] ADD CONSTRAINT [FK_tblHokm_Item_tblItems_Estekhdam] FOREIGN KEY ([fldItems_EstekhdamId]) REFERENCES [Com].[tblItems_Estekhdam] ([fldId])
GO
ALTER TABLE [Prs].[tblHokm_Item] ADD CONSTRAINT [FK_tblHokm_Item_tblPersonalHokm] FOREIGN KEY ([fldPersonalHokmId]) REFERENCES [Prs].[tblPersonalHokm] ([fldId])
GO
ALTER TABLE [Prs].[tblHokm_Item] ADD CONSTRAINT [FK_tblHokm_Item_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
