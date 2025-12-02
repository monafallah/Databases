CREATE TABLE [Cntr].[tblContract_CodingBudje]
(
[fldId] [int] NOT NULL,
[fldBudjeCodingId_Detail] [int] NOT NULL,
[fldContractId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContract_CodingBudje] ADD CONSTRAINT [PK_tblContract_CodingBudje] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Cntr].[tblContract_CodingBudje] ADD CONSTRAINT [FK_tblContract_CodingBudje_tblCodingBudje_Details] FOREIGN KEY ([fldBudjeCodingId_Detail]) REFERENCES [BUD].[tblCodingBudje_Details] ([fldCodeingBudjeId])
GO
ALTER TABLE [Cntr].[tblContract_CodingBudje] ADD CONSTRAINT [FK_tblContract_CodingBudje_tblContracts] FOREIGN KEY ([fldContractId]) REFERENCES [Cntr].[tblContracts] ([fldId])
GO
