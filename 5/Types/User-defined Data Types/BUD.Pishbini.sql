CREATE TYPE [BUD].[Pishbini] AS TABLE
(
[BudgetTypeId] [int] NOT NULL,
[Mablagh] [bigint] NOT NULL,
[MotammamId] [int] NULL,
PRIMARY KEY CLUSTERED ([BudgetTypeId])
)
GO
