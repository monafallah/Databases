CREATE TABLE [BUD].[tblPishbini]
(
[fldpishbiniId] [int] NOT NULL IDENTITY(1, 1),
[fldCodingAcc_DetailsId] [int] NULL,
[fldCodingBudje_DetailsId] [int] NULL,
[fldMablagh] [bigint] NOT NULL,
[fldBudgetTypeId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPishbini_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblPishbini_fldUserId] DEFAULT ((1)),
[fldMotammamId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblPishbini] ADD CONSTRAINT [PK_tblPishbini] PRIMARY KEY NONCLUSTERED ([fldpishbiniId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblPishbini_3] ON [BUD].[tblPishbini] ([fldCodingAcc_DetailsId], [fldBudgetTypeId], [fldCodingBudje_DetailsId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblPishbini] ADD CONSTRAINT [FK_tblPishbini_tblBudgetType] FOREIGN KEY ([fldBudgetTypeId]) REFERENCES [BUD].[tblBudgetType] ([fldId])
GO
ALTER TABLE [BUD].[tblPishbini] ADD CONSTRAINT [FK_tblPishbini_tblCoding_Details] FOREIGN KEY ([fldCodingAcc_DetailsId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [BUD].[tblPishbini] ADD CONSTRAINT [FK_tblPishbini_tblCodingBudje_Details] FOREIGN KEY ([fldCodingBudje_DetailsId]) REFERENCES [BUD].[tblCodingBudje_Details] ([fldCodeingBudjeId])
GO
ALTER TABLE [BUD].[tblPishbini] ADD CONSTRAINT [FK_tblPishbini_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
