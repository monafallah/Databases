CREATE TABLE [ACC].[tblCoding_ProjeFaaliat]
(
[fldId] [int] NOT NULL,
[fldCodingDetailId] [int] NOT NULL,
[fldProje_FaaliatId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_ProjeFaaliat] ADD CONSTRAINT [PK_tblCoding_ProjeFaaliat] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblCoding_ProjeFaaliat] ADD CONSTRAINT [FK_tblCoding_ProjeFaaliat_tblCoding_Details] FOREIGN KEY ([fldCodingDetailId]) REFERENCES [ACC].[tblCoding_Details] ([fldId])
GO
