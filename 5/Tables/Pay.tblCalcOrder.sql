CREATE TABLE [Pay].[tblCalcOrder]
(
[fldId] [int] NOT NULL,
[fldName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldNameProc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldOrder] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Pay].[tblCalcOrder] ADD CONSTRAINT [PK_tblCalcOrder] PRIMARY KEY CLUSTERED ([fldId]) ON [PRIMARY]
GO
