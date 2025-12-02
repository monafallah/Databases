CREATE TABLE [Pay].[tblItemsMablgh]
(
[fldId] [int] NOT NULL,
[fldTarikhEjra] [int] NOT NULL,
[fldItemsHoghughiId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldPercentW_H] [decimal] (4, 2) NOT NULL CONSTRAINT [DF_tblItemsMablgh_fldPercentWife] DEFAULT ((0)),
[fldPercentChild] [decimal] (4, 2) NOT NULL CONSTRAINT [DF_tblItemsMablgh_fldPercentChild] DEFAULT ((0)),
[fldCount] [tinyint] NOT NULL CONSTRAINT [DF_tblItemsMablgh_fldCount] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblItemsMablgh_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblItemsMablgh] ADD CONSTRAINT [PK_tblItemsMablgh] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblItemsMablgh] ADD CONSTRAINT [FK_tblItemsMablgh_tblItemsHoghughi] FOREIGN KEY ([fldItemsHoghughiId]) REFERENCES [Com].[tblItemsHoghughi] ([fldId])
GO
ALTER TABLE [Pay].[tblItemsMablgh] ADD CONSTRAINT [FK_tblItemsMablgh_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
