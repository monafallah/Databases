CREATE TABLE [Drd].[tblPcPosParam_Detail]
(
[fldId] [int] NOT NULL,
[fldPcPosParamId] [int] NOT NULL,
[fldPcPosInfoId] [int] NOT NULL,
[fldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosParam_Detail_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosParam_Detail_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosParam_Detail] ADD CONSTRAINT [PK_tblPcPosParam_Detail] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosParam_Detail] ADD CONSTRAINT [FK_tblPcPosParam_Detail_tblPcPosInfo] FOREIGN KEY ([fldPcPosInfoId]) REFERENCES [Drd].[tblPcPosInfo] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosParam_Detail] ADD CONSTRAINT [FK_tblPcPosParam_Detail_tblPcPosParametr] FOREIGN KEY ([fldPcPosParamId]) REFERENCES [Drd].[tblPcPosParametr] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosParam_Detail] ADD CONSTRAINT [FK_tblPcPosParam_Detail_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
