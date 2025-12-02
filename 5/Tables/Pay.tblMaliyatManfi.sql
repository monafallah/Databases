CREATE TABLE [Pay].[tblMaliyatManfi]
(
[fldId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldMohasebeId] [int] NOT NULL,
[fldSal] [smallint] NOT NULL,
[fldMah] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldTimeEdit] [timestamp] NOT NULL,
[fldEdit] AS (CONVERT([bigint],[fldTimeEdit],(0))) PERSISTED
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMaliyatManfi] ADD CONSTRAINT [PK_tblMaliyatManfi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblMaliyatManfi] ADD CONSTRAINT [FK_tblMaliyatManfi_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebeId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblMaliyatManfi] ADD CONSTRAINT [FK_tblMaliyatManfi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
