CREATE TABLE [Drd].[tblMapCodDaramad]
(
[fldId] [int] NOT NULL,
[fldCodeOld] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIdOld] [int] NOT NULL,
[fldCodeNew] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIdNew] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMapCodDaramad_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblMapCodDaramad] ADD CONSTRAINT [PK_tblMapCodDaramad] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
