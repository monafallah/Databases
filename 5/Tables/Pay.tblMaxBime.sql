CREATE TABLE [Pay].[tblMaxBime]
(
[fldId] [tinyint] NOT NULL,
[fldYear] [smallint] NOT NULL,
[fldMablaghBime] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMaxBime_fldDate] DEFAULT (getdate()),
[fldIp] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMaxBime] ADD CONSTRAINT [PK_tblMaxBime] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblMaxBime] ADD CONSTRAINT [FK_tblMaxBime_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
