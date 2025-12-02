CREATE TABLE [Pay].[tblDefaultTax]
(
[fldId] [int] NOT NULL,
[fldItemHoghoghiId] [int] NOT NULL,
[fldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMashmool] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblDefaultTax] ADD CONSTRAINT [PK_tblDefaultTax] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblDefaultTax] ADD CONSTRAINT [FK_tblDefaultTax_tblItemsHoghughi] FOREIGN KEY ([fldItemHoghoghiId]) REFERENCES [Com].[tblItemsHoghughi] ([fldId])
GO
