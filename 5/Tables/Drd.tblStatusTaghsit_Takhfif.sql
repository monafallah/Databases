CREATE TABLE [Drd].[tblStatusTaghsit_Takhfif]
(
[fldId] [int] NOT NULL,
[fldRequestId] [int] NOT NULL,
[fldTypeMojavez] [tinyint] NOT NULL,
[fldTypeRequest] [tinyint] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblStatusTaghsit_Takhfif_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblStatusTaghsit_Takhfif_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblStatusTaghsit_Takhfif] ADD CONSTRAINT [PK_tblStatusTaghsit_Takhfif] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblStatusTaghsit_Takhfif] ADD CONSTRAINT [FK_tblStatusTaghsit_Takhfif_tblRequestTaghsit_Takhfif] FOREIGN KEY ([fldRequestId]) REFERENCES [Drd].[tblRequestTaghsit_Takhfif] ([fldId])
GO
ALTER TABLE [Drd].[tblStatusTaghsit_Takhfif] ADD CONSTRAINT [FK_tblStatusTaghsit_Takhfif_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
