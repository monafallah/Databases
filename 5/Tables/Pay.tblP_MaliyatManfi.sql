CREATE TABLE [Pay].[tblP_MaliyatManfi]
(
[fldId] [int] NOT NULL,
[fldMohasebeId] [int] NOT NULL,
[fldMablagh] [int] NOT NULL,
[fldSal] [smallint] NOT NULL,
[fldMah] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL,
[fldTimeEdit] [timestamp] NOT NULL,
[fldEdit] AS (CONVERT([bigint],[fldTimeEdit],(0))) PERSISTED
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblP_MaliyatManfi] ADD CONSTRAINT [PK_tblP_MaliyatManfi] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblP_MaliyatManfi] ADD CONSTRAINT [FK_tblP_MaliyatManfi_Pay_tblMohasebat] FOREIGN KEY ([fldMohasebeId]) REFERENCES [Pay].[tblMohasebat] ([fldId])
GO
ALTER TABLE [Pay].[tblP_MaliyatManfi] ADD CONSTRAINT [FK_tblP_MaliyatManfi_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
