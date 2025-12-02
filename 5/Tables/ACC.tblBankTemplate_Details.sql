CREATE TABLE [ACC].[tblBankTemplate_Details]
(
[fldId] [int] NOT NULL,
[fldHeaderId] [int] NOT NULL,
[fldBankId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankTemplate_Details] ADD CONSTRAINT [PK_tblBankTemplate_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [ACC].[tblBankTemplate_Details] ADD CONSTRAINT [FK_tblBankTemplate_Details_tblBank] FOREIGN KEY ([fldBankId]) REFERENCES [Com].[tblBank] ([fldId])
GO
ALTER TABLE [ACC].[tblBankTemplate_Details] ADD CONSTRAINT [FK_tblBankTemplate_Details_tblBankTemplate_Header] FOREIGN KEY ([fldHeaderId]) REFERENCES [ACC].[tblBankTemplate_Header] ([fldId])
GO
