CREATE TABLE [Drd].[tblParametreSabet_Value]
(
[fldID] [int] NOT NULL,
[fldElamAvarezId] [int] NOT NULL,
[fldValue] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldParametreSabetId] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMaghadireEkhtesasi_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMaghadireEkhtesasi_fldDate] DEFAULT (getdate()),
[fldCodeDaramadElamAvarezId] [int] NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [PK_tblMaghadireEkhtesasi] PRIMARY KEY CLUSTERED ([fldID]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [IX_tblParametreSabet_Value] UNIQUE NONCLUSTERED ([fldCodeDaramadElamAvarezId], [fldParametreSabetId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [FK_tblMaghadireEkhtesasi_tblElamAvarez] FOREIGN KEY ([fldElamAvarezId]) REFERENCES [Drd].[tblElamAvarez] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [FK_tblMaghadireEkhtesasi_tblParametreSabet] FOREIGN KEY ([fldParametreSabetId]) REFERENCES [Drd].[tblParametreSabet] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [FK_tblMaghadireEkhtesasi_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet_Value] ADD CONSTRAINT [FK_tblParametreSabet_Value_tblCodhayeDaramadiElamAvarez] FOREIGN KEY ([fldCodeDaramadElamAvarezId]) REFERENCES [Drd].[tblCodhayeDaramadiElamAvarez] ([fldID])
GO
