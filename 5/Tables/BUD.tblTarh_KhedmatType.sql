CREATE TABLE [BUD].[tblTarh_KhedmatType]
(
[fldId] [tinyint] NOT NULL,
[fldValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [BUD].[tblTarh_KhedmatType] ADD CONSTRAINT [PK_tblCodingValue] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
