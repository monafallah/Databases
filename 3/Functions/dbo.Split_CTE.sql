SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[Split_CTE](@S NVARCHAR(4000),@B AS NVARCHAR(4000))
RETURNS @Items TABLE (
      Item                          NVARCHAR(max),
	  Identifier INT
)

AS
BEGIN
--DECLARE @Items TABLE (
--      Item                          NVARCHAR(max),
--	  Identifier INT
--)
--DECLARE @S NVARCHAR(50)='I;;am;;a;;student;;I;;go;;to;;school';
--DECLARE @B AS NVARCHAR(50)=';;'
SET @S=@S+@B;


WITH CTE AS
(
     SELECT 1 rnk,
            1 start,
            CHARINDEX(@B, @s) - 1 ed
     UNION ALL
     SELECT rnk + 1,
            ed + 2+LEN(@B)-1,
            CHARINDEX(@B, @s, ed + 2) - 1
       FROM CTE
      WHERE CHARINDEX(@B, @s, ed + 2) > 0
)
INSERT INTO @Items
        ( Identifier,Item)
SELECT rnk, SUBSTRING(@s, start, ed - start + 1) AS word
FROM CTE
--SELECT * FROM @Items
RETURN
END

GO
