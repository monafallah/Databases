CREATE TABLE [Pay].[Pay_tblPersonalInfo]
(
[fldId] [int] NOT NULL,
[fldPrs_PersonalInfoId] [int] NOT NULL,
[fldTypeBimeId] [int] NOT NULL,
[fldShomareBime] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fldBimeOmr] [bit] NOT NULL,
[fldBimeTakmili] [bit] NOT NULL,
[fldMashagheleSakhtVaZianAvar] [bit] NOT NULL,
[fldCostCenterId] [int] NOT NULL,
[fldMazad30Sal] [bit] NOT NULL,
[fldPasAndaz] [bit] NOT NULL,
[fldSanavatPayanKhedmat] [bit] NOT NULL,
[fldJobeCode] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fldInsuranceWorkShopId] [int] NOT NULL,
[fldHamsarKarmand] [bit] NOT NULL CONSTRAINT [DF_tblPersonalInfo_fldHamsarKarmand] DEFAULT ((0)),
[fldMoafDarman] [bit] NOT NULL CONSTRAINT [DF_tblPersonalInfo_fldMoafDarman] DEFAULT ((0)),
[fldUserId] [int] NOT NULL,
[fldDate] [datetime] NOT NULL CONSTRAINT [DF_tblPersonalInfo_fldDate] DEFAULT (getdate()),
[fldDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_tblPersonalInfo_fldDesc] DEFAULT (''),
[fldTarikhMazad30Sal] [int] NULL
) ON [PayRoll]
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [PK_tblPersonalInfo] PRIMARY KEY CLUSTERED ([fldId]) ON [PayRoll]
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [IX_Pay_tblPersonalInfo] UNIQUE NONCLUSTERED ([fldPrs_PersonalInfoId]) ON [PRIMARY]
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_Pay_tblPersonalInfo_Prs_tblPersonalInfo] FOREIGN KEY ([fldPrs_PersonalInfoId]) REFERENCES [Prs].[Prs_tblPersonalInfo] ([fldId])
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_Pay_tblPersonalInfo_tblTypeBime] FOREIGN KEY ([fldTypeBimeId]) REFERENCES [Com].[tblTypeBime] ([fldId])
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_tblPersonalInfo_Pay_tblCostCenter] FOREIGN KEY ([fldCostCenterId]) REFERENCES [Pay].[tblCostCenter] ([fldId])
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_tblPersonalInfo_Pay_tblInsuranceWorkshop] FOREIGN KEY ([fldInsuranceWorkShopId]) REFERENCES [Pay].[tblInsuranceWorkshop] ([fldId])
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_tblPersonalInfo_Pay_tblTabJobOfBime] FOREIGN KEY ([fldJobeCode]) REFERENCES [Pay].[tblTabJobOfBime] ([fldJobCode])
GO
ALTER TABLE [Pay].[Pay_tblPersonalInfo] ADD CONSTRAINT [FK_tblPersonalInfo_tblUsers] FOREIGN KEY ([fldUserId]) REFERENCES [Com].[tblUser] ([fldId])
GO
