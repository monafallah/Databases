CREATE TABLE [Com].[tblWebServiceLog]
(
[fldId] [int] NOT NULL IDENTITY(1, 1),
[fldMatn] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldUser] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[flddate] [datetime] NULL CONSTRAINT [DF_tblWebServiceLog_flddate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [Com].[tblWebServiceLog] ADD CONSTRAINT [PK_tblWebServiceLog] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
