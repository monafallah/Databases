CREATE TABLE [dbo].[tblContactInfo]
(
[fldId] [int] NOT NULL,
[fldType] [tinyint] NOT NULL,
[fldMatn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldInputId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblContactInfo_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblContactInfo] ADD CONSTRAINT [PK_tblContactInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
