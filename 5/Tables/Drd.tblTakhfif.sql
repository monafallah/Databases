CREATE TABLE [Drd].[tblTakhfif]
(
[fldId] [int] NOT NULL,
[fldShomareMojavez] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTarikhMojavez] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldAzTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTaTarikh] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldTakhfifKoli] [decimal] (5, 2) NULL,
[fldTakhfifNaghdi] [decimal] (5, 2) NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblTakhfif] ADD CONSTRAINT [PK_tblTakhfif_1] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblTakhfif] ADD CONSTRAINT [FK_tblTakhfif_tblTakhfif] FOREIGN KEY ([fldUserId]) REFERENCES [Drd].[tblTakhfif] ([fldId])
GO
