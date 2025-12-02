CREATE TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily]
(
[fldId] [int] NOT NULL,
[fldPersonalId] [int] NOT NULL,
[fldTedadAsli] [int] NOT NULL CONSTRAINT [DF_AfradeTahtePoshesheBimeTakmily_fldTedadAsli] DEFAULT ((0)),
[fldTedadTakafol60Sal] [int] NOT NULL CONSTRAINT [DF_AfradeTahtePoshesheBimeTakmily_fldTedadTakalof60Sal] DEFAULT ((0)),
[fldTedadTakafol70Sal] [int] NOT NULL CONSTRAINT [DF_AfradeTahtePoshesheBimeTakmily_fldTedadTakalof70Sal] DEFAULT ((0)),
[fldTedadBedonePoshesh] [tinyint] NOT NULL CONSTRAINT [DF_tblAfradeTahtePoshesheBimeTakmily_fldTedadBedonePoshesh] DEFAULT ((0)),
[fldGHarardadBimeId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAfradeTahtePoshesheBimeTakmily_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAfradeTahtePoshesheBimeTakmily_fldDate] DEFAULT (getdate())
) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily] ADD CONSTRAINT [CK_tblAfradeTahtePoshesheBimeTakmily] CHECK (([fldTedadAsli]>=(0)))
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily] ADD CONSTRAINT [PK_AfradeTahtePoshesheBimeTakmily] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_Pay_tblGHarardadBime] FOREIGN KEY ([fldGHarardadBimeId]) REFERENCES [Pay].[tblGHarardadBime] ([fldId])
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_Pay_tblPersonalInfo] FOREIGN KEY ([fldPersonalId]) REFERENCES [Pay].[Pay_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId]) ON UPDATE CASCADE
GO
