CREATE TABLE [Drd].[tblPcPosParametr]
(
[fldId] [int] NOT NULL,
[fldFaName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldEnName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosParametr_fldDesc_1] DEFAULT (''),
[fldPspId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosParametr_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosParametr] ADD CONSTRAINT [PK_tblPcPosParametr_1] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosParametr] ADD CONSTRAINT [IX_tblPcPosParametr_1] UNIQUE NONCLUSTERED ([fldEnName], [fldPspId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosParametr] ADD CONSTRAINT [IX_tblPcPosParametr] UNIQUE NONCLUSTERED ([fldFaName], [fldPspId]) ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosParametr] ADD CONSTRAINT [FK_tblPcPosParametr_tblPspModel] FOREIGN KEY ([fldPspId]) REFERENCES [Drd].[tblPspModel] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosParametr] ADD CONSTRAINT [FK_tblPcPosParametr_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
