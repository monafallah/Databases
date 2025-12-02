CREATE TABLE [Drd].[tblParametreSabet_Nerkh]
(
[fldId] [int] NOT NULL,
[fldParametreSabetId] [int] NOT NULL,
[fldTarikhFaalSazi] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblParametreSabet_Nerkh_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblParametreSabet_Nerkh_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblParametreSabet_Nerkh] ADD CONSTRAINT [CK_tblParametreSabet_Nerkh] CHECK ((len([fldTarikhFaalSazi])>=(2)))
GO
ALTER TABLE [Drd].[tblParametreSabet_Nerkh] ADD CONSTRAINT [PK_tblParametreSabet_Nerkh] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblParametreSabet_Nerkh] ADD CONSTRAINT [FK_tblParametreSabet_Nerkh_tblParametreSabet] FOREIGN KEY ([fldParametreSabetId]) REFERENCES [Drd].[tblParametreSabet] ([fldId])
GO
ALTER TABLE [Drd].[tblParametreSabet_Nerkh] ADD CONSTRAINT [FK_tblParametreSabet_Nerkh_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
