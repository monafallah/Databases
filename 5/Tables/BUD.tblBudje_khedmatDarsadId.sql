CREATE TABLE [BUD].[tblBudje_khedmatDarsadId]
(
[fldBudje_khedmatDarsadId] [int] NOT NULL IDENTITY(1, 1),
[fldCodingAcc_detailId] [int] NOT NULL,
[fldCodingBudje_DetailsId] [int] NOT NULL,
[fldDarsad] [float] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBudje_khedmatDarsadId_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblBudje_khedmatDarsadId_fldUserId] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudje_khedmatDarsadId] ADD CONSTRAINT [PK_tblBudje_Khedmat] PRIMARY KEY CLUSTERED ([fldBudje_khedmatDarsadId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblBudje_khedmatDarsadId] ON [BUD].[tblBudje_khedmatDarsadId] ([fldCodingAcc_detailId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblBudje_khedmatDarsadId_1] ON [BUD].[tblBudje_khedmatDarsadId] ([fldCodingBudje_DetailsId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblBudje_khedmatDarsadId] ADD CONSTRAINT [FK_tblBudje_Khedmat_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
