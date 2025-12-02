CREATE TABLE [Auto].[tblVazieyat_Letter]
(
[fldId] [bigint] NOT NULL,
[fldLetterId] [bigint] NOT NULL,
[fldStatusId] [int] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblVazieyat_Letter_fldDate] DEFAULT (getdate()),
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblVazieyat_Letter] ADD CONSTRAINT [PK_tblVazieyat_Letter] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Auto].[tblVazieyat_Letter] ADD CONSTRAINT [FK_tblVazieyat_Letter_tblLetter] FOREIGN KEY ([fldLetterId]) REFERENCES [Auto].[tblLetter] ([fldID])
GO
ALTER TABLE [Auto].[tblVazieyat_Letter] ADD CONSTRAINT [FK_tblVazieyat_Letter_tblLetterStatus] FOREIGN KEY ([fldStatusId]) REFERENCES [Auto].[tblLetterStatus] ([fldId])
GO
ALTER TABLE [Auto].[tblVazieyat_Letter] ADD CONSTRAINT [FK_tblVazieyat_Letter_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
