CREATE TABLE [BUD].[tblTahodatSanavati]
(
[fldId] [int] NOT NULL,
[fldD1] [bigint] NULL,
[fldD2] [bigint] NULL,
[fldD3] [bigint] NULL,
[fldH1] [bigint] NULL,
[fldH2] [bigint] NULL,
[fldH3] [bigint] NULL,
[fldH4] [bigint] NULL,
[fldFiscalYearId] [int] NOT NULL,
[fldUserId] [int] NOT NULL CONSTRAINT [DF_tblTahodatSanavati_fldUserId] DEFAULT ((1)),
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblTahodatSanavati_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblTahodatSanavati] ADD CONSTRAINT [PK_tblTahodatSanavati] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblTahodatSanavati] ADD CONSTRAINT [FK_tblTahodatSanavati_tblFiscalYear] FOREIGN KEY ([fldFiscalYearId]) REFERENCES [ACC].[tblFiscalYear] ([fldId])
GO
ALTER TABLE [BUD].[tblTahodatSanavati] ADD CONSTRAINT [FK_tblTahodatSanavati_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
