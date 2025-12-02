CREATE TABLE [Pay].[tblMotalebateParametri_Personal]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldParametrId] [int] NOT NULL,
[fldNoePardakht] [bit] NOT NULL,
[fldMablagh] [int] NOT NULL CONSTRAINT [DF_MotalebateParametri_Personal_fldMablagh] DEFAULT ((0)),
[fldTedad] [int] NOT NULL CONSTRAINT [DF_MotalebateParametri_Personal_fldTedad] DEFAULT ((0)),
[fldTarikhPardakht] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMashmoleBime] [bit] NOT NULL,
[fldMashmoleMaliyat] [bit] NOT NULL,
[fldStatus] [bit] NOT NULL,
[fldDateDeactive] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMotalebateParametri_Personal_fldDate] DEFAULT (getdate()),
[fldMazayaMashmool] [bit] NULL CONSTRAINT [DF_tblMotalebateParametri_Personal_fldMazayaMashmool] DEFAULT ((0))
) ON [Personeli]
GO
ALTER TABLE [Pay].[tblMotalebateParametri_Personal] ADD CONSTRAINT [PK_MotalebateParametri_Personal] PRIMARY KEY CLUSTERED ([fldId]) ON [Personeli]
GO
ALTER TABLE [Pay].[tblMotalebateParametri_Personal] ADD CONSTRAINT [FK_MotalebateParametri_Personal_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId]) ON UPDATE CASCADE
GO
ALTER TABLE [Pay].[tblMotalebateParametri_Personal] ADD CONSTRAINT [FK_MotalebateParametri_Personal_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Pay].[tblMotalebateParametri_Personal] ADD CONSTRAINT [FK_tblMotalebateParametri_Personal_Pay_tblParametrs] FOREIGN KEY ([fldParametrId]) REFERENCES [Pay].[tblParametrs] ([fldId]) ON UPDATE CASCADE
GO
