CREATE TABLE [Com].[tblLoginFailed]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldUserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldIP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Table_1_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblLoginFailed_fldDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblLoginFailed] ADD CONSTRAINT [PK_tblLoginFailed] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
