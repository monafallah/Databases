CREATE TABLE [dbo].[tblDateDim]
(
[fldDate] [date] NOT NULL,
[fldTarikh] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldSal] [smallint] NOT NULL,
[fldMah] [tinyint] NOT NULL,
[fldRoz] [tinyint] NOT NULL,
[fldYear] [smallint] NULL,
[fldMonth] [tinyint] NULL,
[fldDay] [tinyint] NULL,
[fldTypeFasl] [tinyint] NULL,
[fldDateStr] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblDateDim] ADD CONSTRAINT [PK_tblDateDim] PRIMARY KEY CLUSTERED ([fldDate]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblDateDim] ADD CONSTRAINT [IX_tblDateDim] UNIQUE NONCLUSTERED ([fldTarikh]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ و زمان', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ میلادی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ ', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldDateStr'
GO
EXEC sp_addextendedproperty N'MS_Description', N'روز میلادی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldDay'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه شمسی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldMah'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ماه میلادی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldMonth'
GO
EXEC sp_addextendedproperty N'MS_Description', N'روز شمسی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldRoz'
GO
EXEC sp_addextendedproperty N'MS_Description', N'سال شمسی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldSal'
GO
EXEC sp_addextendedproperty N'MS_Description', N'تاریخ شمسی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldTarikh'
GO
EXEC sp_addextendedproperty N'MS_Description', N'نوع فصل', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldTypeFasl'
GO
EXEC sp_addextendedproperty N'MS_Description', N'سال میلادی', 'SCHEMA', N'dbo', 'TABLE', N'tblDateDim', 'COLUMN', N'fldYear'
GO
