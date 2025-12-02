CREATE TABLE [Drd].[tblPcPosUser]
(
[fldId] [int] NOT NULL,
[fldPosIpId] [int] NOT NULL,
[fldIdUser] [int] NOT NULL,
[fldUserId] [int] NOT NULL,
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPcPosUser_fldDesc] DEFAULT (''),
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPcPosUser_fldDate] DEFAULT (getdate())
) ON [Daramad] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Drd].[tblPcPosUser] ADD CONSTRAINT [PK_tblPcPosUser] PRIMARY KEY CLUSTERED ([fldId]) ON [Daramad]
GO
ALTER TABLE [Drd].[tblPcPosUser] ADD CONSTRAINT [FK_tblPcPosUser_tblPcPosIP] FOREIGN KEY ([fldPosIpId]) REFERENCES [Drd].[tblPcPosIP] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosUser] ADD CONSTRAINT [FK_tblPcPosUser_tblUser] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
ALTER TABLE [Drd].[tblPcPosUser] ADD CONSTRAINT [FK_tblPcPosUser_tblUser1] FOREIGN KEY ([fldIdUser]) REFERENCES [Com].[tblUser] ([fldId])
GO
