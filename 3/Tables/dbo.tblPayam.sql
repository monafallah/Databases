CREATE TABLE [dbo].[tblPayam]
(
[fldId] [int] NOT NULL,
[fldNameShakhs] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMobile] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSubject] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldMatn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPayam] ADD CONSTRAINT [PK_tblPayam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
