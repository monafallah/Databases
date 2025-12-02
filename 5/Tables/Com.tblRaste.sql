CREATE TABLE [Com].[tblRaste]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldCode] [float] NOT NULL,
[fldText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIndex] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMaliyat] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblRaste] ADD CONSTRAINT [PK_tblRaste_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
