CREATE TABLE [BUD].[tblMotammam]
(
[fldId] [int] NOT NULL,
[fldFiscalYearId] [int] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblMotammam_fldDesc] DEFAULT (''),
[fldUserId] [int] NOT NULL,
[fldOrganId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblMotammam_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblMotammam] ADD CONSTRAINT [PK_tblMotammam] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
