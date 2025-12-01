SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create  PROC [dbo].[prs_tblTicketSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	DECLARE @t TABLE(id INT)
	INSERT INTO @t
	SELECT tblTicketPermission.fldCategoryId FROM dbo.tblTicketPermission WHERE fldTicketUserId=@Value
	
                                          
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
						       tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						  
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId
						 inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE  tblTicket.fldId = @Value
		ORDER BY  tblTicket.fldId DESC

	if (@fieldname=N'fldDesc')
		SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
						       tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						  
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId
						 inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE tblTicket.fldDesc like  @Value
	ORDER BY  tblTicket.fldId DESC
	

	if (@fieldname=N'fldAshkhasId')
	select * from(	SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
						       tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						  
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId
						 inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
                         WHERE  fldAshkhasId like ( @Value) AND fldTicketCategoryId=@Value2
                         ORDER BY  tblTicket.fldId desc)t

order by fldid asc


if (@fieldname=N'admin')
		SELECT   TOP (@h) * FROM( SELECT  tblTicket.fldId , 
                        ISNULL((  SELECT TOP(1) t.fldHTML FROM dbo.tblTicket AS t
 WHERE t.fldSeen=0 and t.fldUserId IS NULL AND t.fldAshkhasId=dbo.tblTicket.fldAshkhasId 
 and t.fldTicketCategoryId in(SELECT id FROM @t)ORDER BY t.fldId DESC),tblTicket.fldHTML)fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh,
                         ISNULL((  SELECT TOP(1) t.fldSeen FROM dbo.tblTicket AS t
 WHERE t.fldSeen=0  and t.fldUserId IS  NULL 
 AND t.fldAshkhasId=dbo.tblTicket.fldAshkhasId 
  And t.fldTicketCategoryId in(select id from @t)
ORDER BY t.fldId DESC)
,1)
 AS fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
						  					
						  					ISNULL( (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM         
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId and fldAshkhasId<>@value),
						 ISNULL(ISNULL((SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM         
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId and fldAshkhasId<>@value),
						 (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM          tblAshkhas   WHERE dbo.tblAshkhas.fldId=tblticket.fldUserId and tblticket.fldAshkhasId=@value )),
				(SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
							FROM   tblAshkhas  WHERE dbo.tblAshkhas.fldId=tblticket.fldUserId and tblticket.fldAshkhasId=@value ))) AS fldName
                         
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, 
						  ISNULL((  SELECT TOP(1) c.fldTitle FROM dbo.tblTicket AS t inner join tblTicketCategory c on c.fldId=t.fldTicketCategoryId
 WHERE t.fldSeen=0 and t.fldUserId IS NULL AND t.fldAshkhasId=dbo.tblTicket.fldAshkhasId 
 and t.fldTicketCategoryId in(SELECT id FROM @t)ORDER BY t.fldId DESC),tblTicketCategory.fldTitle)fldTitle
						  ,fldAshkhasId
						  FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId
                         WHERE (tblTicket.fldAshkhasId<>@Value --or (tblTicket.fldSetadUserId=@Value and tblTicket.fldUserId is not null /*and tblTicket.flduserId in(SELECT fldId FROM dbo.tblUser WHERE fldTreeId=1)*/ )
                         )
                         and  tblTicket.fldId IN (SELECT     DISTINCT     MAX(tblTicket.fldId) OVER (PARTITION BY t.fldashkhasid) FROM dbo.tblTicket t) 
                         AND fldTicketCategoryId IN (SELECT id FROM @t))t
                         ORDER BY  fldId DESC 




	if (@fieldname=N'fldSetadUser_NotSeen')
		SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
		ISNULL( (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM        
                         tblAshkhas   WHERE dbo.tblAshkhas.fldId=fldAshkhasId),
						 (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM     
                         dbo.tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId)) AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						   
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId
                         WHERE  fldAshkhasId like ( @Value) AND tblTicket.fldSeen=0 AND tblTicket.fldUserId IS NOT null
                         ORDER BY  tblTicket.fldId DESC
                         
                         
           
   	if (@fieldname=N'CheckCategory')
		SELECT        TOP (1) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
ISNULL( (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM          
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId),
						 (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM          
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId)) AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						   
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId 
                         WHERE fldAshkhasId=@Value AND fldSeen=0 AND tblTicket.fldUserId IS NOT null
                         ORDER BY  tblTicket.fldId DESC      
                                          
                         
   
   	if (@fieldname=N'')
		SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
ISNULL( (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM         
                         tblAshkhas   WHERE dbo.tblAshkhas.fldId=fldAshkhasId),
						 (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM           
                         dbo.tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId)) AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId, tblTicketCategory.fldTitle
						  ,fldAshkhasId
						   
FROM            tblTicket INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId 
                         ORDER BY  tblTicket.fldId DESC                                                   
       
	if (@fieldname=N'Permmision')
		BEGIN

		SELECT        TOP (@h) tblTicket.fldId, 
                        tblTicket.fldHTML, tblTicket.fldUserId, tblTicket.fldDesc, tblTicket.fldDate, dbo.MiladiTOShamsi(tblTicket.fldDate) + '-' + CAST(CAST(tblTicket.fldDate AS time(0)) AS nvarchar(5)) 
                         AS fldTarikh, tblTicket.fldSeen, tblTicket.fldFileId, tblTicket.fldInputID,
ISNULL( (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM         
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId),
						 (SELECT        tblAshkhas.fldName+' '+ tblAshkhas.fldFamily
				FROM         
                         tblAshkhas  WHERE dbo.tblAshkhas.fldId=fldAshkhasId)) AS fldName
						  , dbo.MiladiTOShamsi(tblTicket.fldSeenDate) 
                         + '-' + CAST(CAST(tblTicket.fldSeenDate AS time(0)) AS nvarchar(5)) AS fldSeenDate, tblTicket.fldTicketCategoryId,(SELECT fldTitle FROM dbo.tblTicketCategory WHERE tblTicketCategory.fldid=fldTicketCategoryId)  AS fldTitle
						  ,fldAshkhasId
						   
FROM            tblTicket /*INNER JOIN
                         tblTicketCategory ON tblTicket.fldTicketCategoryId = tblTicketCategory.fldId */
                         WHERE fldTicketCategoryId IN (SELECT id FROM @t) AND fldUserId IS NULL AND fldseen=0 AND fldAshkhasId<>@Value
                         ORDER BY  tblTicket.fldId DESC 
end
	COMMIT
GO
