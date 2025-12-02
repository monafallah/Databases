CREATE TABLE [Pay].[tblMandehPasAndaz]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[FldMablagh] [int] NOT NULL,
[fldTarikhSabt] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMandehPasAndaz_fldDate] DEFAULT (getdate())
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMandehPasAndaz] ADD CONSTRAINT [PK_tblMandehPasAndaz] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMandehPasAndaz] ADD CONSTRAINT [FK_tblMandehPasAndaz_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblMandehPasAndaz] ADD CONSTRAINT [FK_tblMandehPasAndaz_tblUsers] FOREIGN KEY ([fldUserID]) REFERENCES [Com].[tblUser] ([fldId])
GO
