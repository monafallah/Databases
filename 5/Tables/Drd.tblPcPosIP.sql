CREATE TABLE [Drd].[tblPcPosIP]
(
[fldId] [int] NOT NULL,
[fldPcPosInfoId] [int] NOT NULL,
[fldSerial] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosIp_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosIp_fldDate] DEFAULT (getdate()),
[fldIp] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosIP] ADD CONSTRAINT [PK_tblPcPosIP_1] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosIP] ADD CONSTRAINT [FK_tblPcPosIP_tblPcPosInfo] FOREIGN KEY ([fldPcPosInfoId]) REFERENCES [Drd].[tblPcPosInfo] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosIP] ADD CONSTRAINT [FK_tblPcPosIp_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
