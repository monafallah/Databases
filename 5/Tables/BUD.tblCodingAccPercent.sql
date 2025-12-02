CREATE TABLE [BUD].[tblCodingAccPercent]
(
[fldId] [int] NOT NULL,
[fldCodingAcc_DetailsId] [int] NOT NULL,
[fldPercentHazine] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_tblCodingAccPercent_fldPercentHazine] DEFAULT ((0)),
[fldPercentTamallok] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_tblCodingAccPercent_fldPercentTamallok] DEFAULT ((0)),
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblCodingAccPercent_fldUserId] DEFAULT ((1)),
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodingAccPercent_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingAccPercent] ADD CONSTRAINT [PK_tblCodingAccPercent] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblCodingAccPercent] ADD CONSTRAINT [FK_tblCodingAccPercent_tblCoding_Details] FOREIGN KEY ([fldCodingAcc_DetailsId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [BUD].[tblCodingAccPercent] ADD CONSTRAINT [FK_tblCodingAccPercent_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
