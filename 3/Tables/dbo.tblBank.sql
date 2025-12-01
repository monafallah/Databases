CREATE TABLE [dbo].[tblBank]
(
[fldId] [tinyint] NOT NULL,
[fldBankName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldFileId] [int] NULL,
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblBank_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBank_fldDesc] DEFAULT (''),
[fldCentralBankCode] [tinyint] NULL,
[fldInfinitiveBank] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblBank_fldInfinitiveBank] DEFAULT (''),
[fldFix] [bit] NOT NULL,
[fldNumberCard] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblBank] ADD CONSTRAINT [PK_tblBank_1] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
