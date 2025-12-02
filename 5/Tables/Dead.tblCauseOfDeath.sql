CREATE TABLE [Dead].[tblCauseOfDeath]
(
[fldId] [int] NOT NULL,
[fldReason] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblCauseOfDeath_fldDate] DEFAULT (getdate()),
[fldUserID] [int] NOT NULL,
[fldDesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblCauseOfDeath_fldDesc] DEFAULT (''),
[fldIP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblCauseOfDeath] ADD CONSTRAINT [PK_tblCauseOfDeath] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
ALTER TABLE [Dead].[tblCauseOfDeath] ADD CONSTRAINT [IX_tblCauseOfDeath] UNIQUE NONCLUSTERED ([fldReason]) ON [PRIMARY]
GO
