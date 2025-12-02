CREATE TABLE [ACC].[tblCodingDetail_CaseType]
(
[fldId] [int] NOT NULL,
[fldCodingDetailId] [int] NOT NULL,
[fldCaseTypeId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCodingDetai_CaseType_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCodingDetail_CaseType] ADD CONSTRAINT [PK_tblCodingDetail_CaseType] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCodingDetail_CaseType] ADD CONSTRAINT [FK_tblCodingDetai_CaseType_tblCaseType] FOREIGN KEY ([fldCaseTypeId]) REFERENCES [ACC].[tblCaseType] ([fldId])
GO
ALTER TABLE [ACC].[tblCodingDetail_CaseType] ADD CONSTRAINT [FK_tblCodingDetai_CaseType_tblCoding_Details] FOREIGN KEY ([fldCodingDetailId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
ALTER TABLE [ACC].[tblCodingDetail_CaseType] ADD CONSTRAINT [FK_tblCodingDetai_CaseType_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
