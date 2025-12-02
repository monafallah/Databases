CREATE TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details]
(
[fldId] [int] NOT NULL,
[fldAfradTahtePoshehsId] [int] NOT NULL,
[fldBimeTakmiliId] [int] NOT NULL CONSTRAINT [DF_Table_2_fldTedadAsli] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblAfradeTahtePoshesheBimeTakmily_Details_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblAfradeTahtePoshesheBimeTakmily_Details_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ADD CONSTRAINT [PK_tblAfradeTahtePoshesheBimeTakmily_Details] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_Details_Pay_tblPersonalInfo] FOREIGN KEY ([fldBimeTakmiliId]) REFERENCES [Pay].[tblAfradeTahtePoshesheBimeTakmily] ([fldId])
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_Details_tblAfradTahtePooshesh] FOREIGN KEY ([fldAfradTahtePoshehsId]) REFERENCES [Prs].[tblAfradTahtePooshesh] ([fldId])
GO
ALTER TABLE [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ADD CONSTRAINT [FK_tblAfradeTahtePoshesheBimeTakmily_Details_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
