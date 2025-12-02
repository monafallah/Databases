SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

    CREATE   PROCEDURE [Pay].[spr_tblBudgetPayHeaderSelect]
    @fieldname nvarchar(50),
    @Value nvarchar(50),
    @Value2 nvarchar(50),
    @h int
    AS
    BEGIN
        if (@h=0) set @h=2147483647
        SET @Value=Com.fn_TextNormalize(@value)
        if (@fieldname=N'fldId')
            SELECT        p.fldId, p.fldFiscalYearId, p.fldItemsHoghughiId, p.fldParametrId,fldkosuratBudgetPayId, p.fldBudgetCode, p.fldUserId, p.fldIP, p.fldDate, p.fldDesc, i.fldTitle
            ,d.fldTitle as fldTitleBudget,f.fldYear
            ,/*isnull(be.fldTitleEstkhdam,e.fldTitleEstkhdam)*/'' as fldTitleEstkhdam
        ,/*isnull(be.fldTypeEstekhdamId,e.fldTypeEstekhdamId)*/'' as fldTypeEstekhdamId
        ,/*isnull(bb.fldTitleBime,b.fldTitleBime)*/'' as fldTitleBime
        ,/*isnull(bb.fldTypeBimeId,b.fldTypeBimeId)*/'' as fldTypeBimeId,1 as fldType
            FROM            Pay.tblBudgetPayHeader AS p 
            INNER JOIN Com.tblItemsHoghughi AS i ON i.fldId = p.fldItemsHoghughiId
            inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId
            inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear
            inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId 
            --        from  com.tblTypeEstekhdam as e )e
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from  com.tblTypeBime as e )b
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeEstekhdam as e on e.fldId=b.fldTypeEstekhdamId
            --            where b.fldHeaderId=p.fldId)be
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeBime as e on e.fldId=b.fldTypeBimeId
            --            where b.fldHeaderId=p.fldId)bb
            where  p.fldId=@Value

   

         if (@fieldname=N'fldYear')
        begin
            declare @Id int=0
            select @Id=fldId from acc.tblFiscalYear where fldYear=@Value
        select * from(      SELECT        isnull(p.fldId,0)as fldId, isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,isnull( p.fldItemsHoghughiId,i.fldId) as fldItemsHoghughiId, fldParametrId,fldkosuratBudgetPayId
            , isnull(p.fldBudgetCode,0) as fldBudgetCode, isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc, i.fldTitle ,isnull(p.fldTitle + '('+fldDaramadCode+')','') as fldTitleBudget,isnull(p.fldYear,@Value) as fldYear
            ,/*isnull(be.fldTitleEstkhdam,e.fldTitleEstkhdam)*/'' as fldTitleEstkhdam
        ,/*isnull(be.fldTypeEstekhdamId,e.fldTypeEstekhdamId)*/'' as fldTypeEstekhdamId
        ,/*isnull(bb.fldTitleBime,b.fldTitleBime)*/'' as fldTitleBime
        ,/*isnull(bb.fldTypeBimeId,b.fldTypeBimeId)*/'' as fldTypeBimeId,1 as fldType
           FROM         Com.tblItemsHoghughi AS i
            outer apply(select top 1 * from(select count(*) over (partition by p.fldBudgetCode) as fldCount,p.*,d.fldTitle,fldDaramadCode,f.fldYear
                    from   Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldId
                    where i.fldId = p.fldItemsHoghughiId)t
                    order by fldCount desc)p
            -- outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId 
            --        from  com.tblTypeEstekhdam as e )e
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from  com.tblTypeBime as e )b
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId  
            --            from (select distinct e.fldId,e.fldTitle
            --            from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeEstekhdam as e on e.fldId=b.fldTypeEstekhdamId  
            --                where b.fldHeaderId=p.fldId)e )be
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from (select distinct e.fldId,e.fldTitle from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeBime as e on e.fldId=b.fldTypeBimeId
            --            where b.fldHeaderId=p.fldId)e)bb
                         

        union all

         SELECT        isnull(p.fldId,0)as fldId, isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId, p.fldItemsHoghughiId,isnull( fldParametrId,i.fldId) as fldParametrId,fldkosuratBudgetPayId
            , isnull(p.fldBudgetCode,0) as fldBudgetCode, isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc,i.fldTitle collate SQL_Latin1_General_CP1_CI_AS  ,isnull(p.fldTitle + '('+fldDaramadCode+')','') as fldTitleBudget,isnull(p.fldYear,@Value) as fldYear
            ,/*isnull(be.fldTitleEstkhdam,e.fldTitleEstkhdam)*/'' as fldTitleEstkhdam
        ,/*isnull(be.fldTypeEstekhdamId,e.fldTypeEstekhdamId)*/'' as fldTypeEstekhdamId
        ,/*isnull(bb.fldTitleBime,b.fldTitleBime)*/'' as fldTitleBime
        ,/*isnull(bb.fldTypeBimeId,b.fldTypeBimeId)*/'' as fldTypeBimeId,2 as fldtype
           FROM         pay.tblParametrs AS i
            outer apply(select top 1 * from(select count(*) over (partition by p.fldBudgetCode) as fldCount,p.*,d.fldTitle,fldDaramadCode,f.fldYear
                    from   Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldId
                    where i.fldId = p.fldParametrId)t
                    order by fldCount desc)p
            -- outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId 
            --        from  com.tblTypeEstekhdam as e )e
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from  com.tblTypeBime as e )b
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId  
            --            from (select distinct e.fldId,e.fldTitle
            --            from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeEstekhdam as e on e.fldId=b.fldTypeEstekhdamId  
            --                where b.fldHeaderId=p.fldId)e )be
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from (select distinct e.fldId,e.fldTitle from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeBime as e on e.fldId=b.fldTypeBimeId
            --            where b.fldHeaderId=p.fldId)e)bb
                        where i.fldTypeParametr=0
                       
        
        union all

         SELECT        isnull(p.fldId,0)as fldId, isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId, p.fldItemsHoghughiId,fldParametrId,isnull( fldkosuratBudgetPayId,i.fldId) as  fldkosuratBudgetPayId
            , isnull(p.fldBudgetCode,0) as fldBudgetCode, isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc,i.fldTitle collate SQL_Latin1_General_CP1_CI_AS  ,isnull(p.fldTitle + '('+fldDaramadCode+')','') as fldTitleBudget,isnull(p.fldYear,@Value) as fldYear
            ,/*isnull(be.fldTitleEstkhdam,e.fldTitleEstkhdam)*/'' as fldTitleEstkhdam
        ,/*isnull(be.fldTypeEstekhdamId,e.fldTypeEstekhdamId)*/'' as fldTypeEstekhdamId
        ,/*isnull(bb.fldTitleBime,b.fldTitleBime)*/'' as fldTitleBime
        ,/*isnull(bb.fldTypeBimeId,b.fldTypeBimeId)*/'' as fldTypeBimeId,3 as fldtype
           FROM         pay.tblKosuratBudgetPay AS i
            outer apply(select top 1 * from(select count(*) over (partition by p.fldBudgetCode) as fldCount,p.*,d.fldTitle,fldDaramadCode,f.fldYear
                    from   Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldId
                    where i.fldId = p.fldkosuratBudgetPayId)t
                    order by fldCount desc)p
            -- outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId 
            --        from  com.tblTypeEstekhdam as e )e
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from  com.tblTypeBime as e )b
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleEstkhdam,STRING_AGG(e.fldId,',') as fldTypeEstekhdamId  
            --            from (select distinct e.fldId,e.fldTitle
            --            from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeEstekhdam as e on e.fldId=b.fldTypeEstekhdamId  
            --                where b.fldHeaderId=p.fldId)e )be
            --outer apply(select STRING_AGG(e.fldTitle,N'، ') as fldTitleBime,STRING_AGG(e.fldId,',') as fldTypeBimeId 
            --            from (select distinct e.fldId,e.fldTitle from pay.tblBudgetPayDetail as b 
            --            inner join com.tblTypeBime as e on e.fldId=b.fldTypeBimeId
            --            where b.fldHeaderId=p.fldId)e)bb
                        )t
                        order by fldtype,fldItemsHoghughiId asc,fldParametrId asc ,fldkosuratBudgetPayId asc

        end
  if (@fieldname=N'fldItemsHoghughiId')
        begin   
        select @Id=fldId from acc.tblFiscalYear where fldYear=@Value
         select * from( 
     SELECT    distinct    isnull(p.fldId,0)as fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,isnull( p.fldItemsHoghughiId,i.fldId) as fldItemsHoghughiId, fldParametrId,fldkosuratBudgetPayId
            ,   isnull(p.fldBudgetCode,0)  as fldBudgetCode
            , isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc, i.fldTitle 
            ,  isnull(d.fldTitle + '('+fldDaramadCode+')','')  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            ,  isnull(e.fldTitle,'') as fldTitleEstkhdam
            , isnull(cast(e.fldId as varchar(10)),'')  as fldTypeEstekhdamId
            , isnull(b.fldTitle,'')  as fldTitleBime
            , isnull(cast(b.fldId as varchar(10)),'') as fldTypeBimeId,1 as fldType
           FROM         Com.tblItemsHoghughi AS i
           inner join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldid 
                    inner join com.tblTypeEstekhdam as e on e.fldId=bd.fldTypeEstekhdamId                     
                    inner join com.tblTypeBime as b on b.fldId=bd.fldTypeBimeId
                    on i.fldId = p.fldItemsHoghughiId
                  
           where i.fldId=@Value2

           union 

              SELECT    distinct    0 fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,isnull( p.fldItemsHoghughiId,i.fldId) as fldItemsHoghughiId, fldParametrId,fldkosuratBudgetPayId
            ,  0  as fldBudgetCode
            , 0 as fldUserId, '' as fldIP, GETDATE() as fldDate
            , '' as fldDesc, i.fldTitle 
            ,  ''  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            , es.fldTitleEstkhdam  as fldTitleEstkhdam
            , cast(es.fldTypeEstekhdamId as varchar(10))  as fldTypeEstekhdamId
            ,es.fldTitleBime  as fldTitleBime
            , cast(es.fldTypeBimeId as varchar(10))  as fldTypeBimeId,1 as fldType
           FROM         Com.tblItemsHoghughi AS i
           left join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId and fldYear=@Value
                    on i.fldId = p.fldItemsHoghughiId
                    
             cross apply (select (e2.fldTitle) as fldTitleEstkhdam,(e2.fldId) as fldTypeEstekhdamId ,(bime.fldTitle) as fldTitleBime,(bime.fldId) as fldTypeBimeId 
                    from  com.tblTypeEstekhdam as e2  
                    cross join com.tblTypeBime as bime
                    where not exists (select * from pay.tblBudgetPayDetail as bd 
                    inner join Pay.tblBudgetPayHeader AS pb on bd.fldHeaderId=pb.fldId and pb.fldFiscalYearId=p.fldFiscalYearId
                    where pb.fldItemsHoghughiId=p.fldItemsHoghughiId and bd.fldTypeEstekhdamId=e2.fldId and  bd.fldTypeBimeId=bime.fldId)
                    )es
           where i.fldId=@Value2
           )t
           order by fldTypeEstekhdamId,fldTypeBimeId

    end
    if (@fieldname=N'fldParametrId')
        begin       
        select @Id=fldId from acc.tblFiscalYear where fldYear=@Value
         select * from( 
     SELECT    distinct    isnull(p.fldId,0)as fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,isnull( p.fldItemsHoghughiId,i.fldId) as fldItemsHoghughiId, fldParametrId,fldkosuratBudgetPayId
            ,   isnull(p.fldBudgetCode,0)  as fldBudgetCode
            , isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc, i.fldTitle 
            ,  isnull(d.fldTitle + '('+fldDaramadCode+')','')  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            ,  isnull(e.fldTitle,'') as fldTitleEstkhdam
            , isnull(cast(e.fldId as varchar(10)),'')  as fldTypeEstekhdamId
            , isnull(b.fldTitle,'')  as fldTitleBime
            , isnull(cast(b.fldId as varchar(10)),'') as fldTypeBimeId,2 as fldType
           FROM         pay.tblParametrs AS i
           inner join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldid 
                    inner join com.tblTypeEstekhdam as e on e.fldId=bd.fldTypeEstekhdamId                     
                    inner join com.tblTypeBime as b on b.fldId=bd.fldTypeBimeId
                    on i.fldId = p.fldParametrId
                  
           where i.fldId=@Value2

           union 

              SELECT    distinct    0 as fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId, fldItemsHoghughiId,isnull( p.fldParametrId,i.fldId) as fldParametrId,fldkosuratBudgetPayId
            ,   0  as fldBudgetCode
            , 0 as fldUserId, '' as fldIP, GETDATE() as fldDate
            , '' as fldDesc, i.fldTitle 
            , ''  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            , es.fldTitleEstkhdam  as fldTitleEstkhdam
            , cast(es.fldTypeEstekhdamId as varchar(10))  as fldTypeEstekhdamId
            ,es.fldTitleBime  as fldTitleBime
            , cast(es.fldTypeBimeId as varchar(10))  as fldTypeBimeId,2 as fldType
           FROM         pay.tblParametrs AS i
           left join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId  and fldYear=@Value
                    on i.fldId = p.fldParametrId
                    
             cross apply (select (e2.fldTitle) as fldTitleEstkhdam,(e2.fldId) as fldTypeEstekhdamId ,(bime.fldTitle) as fldTitleBime,(bime.fldId) as fldTypeBimeId 
                    from  com.tblTypeEstekhdam as e2  
                    cross join com.tblTypeBime as bime
                    where not exists (select * from pay.tblBudgetPayDetail as bd 
                    inner join Pay.tblBudgetPayHeader AS pb on bd.fldHeaderId=pb.fldId and pb.fldFiscalYearId=p.fldFiscalYearId
                    where pb.fldParametrId=p.fldParametrId and bd.fldTypeEstekhdamId=e2.fldId and  bd.fldTypeBimeId=bime.fldId)
                    )es
           where i.fldId=@Value2
           )t
           order by fldTypeEstekhdamId,fldTypeBimeId
    end

    if (@fieldname=N'fldkosuratBudgetPayId')
        begin    
        select @Id=fldId from acc.tblFiscalYear where fldYear=@Value
         select * from( 
     SELECT    distinct    isnull(p.fldId,0)as fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,fldItemsHoghughiId, fldParametrId,isnull( p.fldkosuratBudgetPayId,i.fldId) as  fldkosuratBudgetPayId
            ,   isnull(p.fldBudgetCode,0)  as fldBudgetCode
            , isnull(p.fldUserId,0) as fldUserId, isnull(p.fldIP,'') as fldIP, isnull(p.fldDate,GETDATE()) as fldDate
            , isnull(p.fldDesc,'') as fldDesc, i.fldTitle 
            ,  isnull(d.fldTitle + '('+fldDaramadCode+')','')  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            ,  isnull(e.fldTitle,'') as fldTitleEstkhdam
            , isnull(cast(e.fldId as varchar(10)),'')  as fldTypeEstekhdamId
            , isnull(b.fldTitle,'')  as fldTitleBime
            , isnull(cast(b.fldId as varchar(10)),'') as fldTypeBimeId,3 as fldType
           FROM         pay.tblKosuratBudgetPay AS i
           inner join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId 
                    inner join acc.tblCoding_Header as h on h.fldYear=f.fldYear and f.fldYear=@Value
                    inner join acc.tblCoding_Details as d on d.fldId=p.fldBudgetCode
                    inner join pay.tblBudgetPayDetail as bd on bd.fldHeaderId=p.fldid 
                    inner join com.tblTypeEstekhdam as e on e.fldId=bd.fldTypeEstekhdamId                     
                    inner join com.tblTypeBime as b on b.fldId=bd.fldTypeBimeId
                    on i.fldId = p.fldkosuratBudgetPayId
                  
           where i.fldId=@Value2

           union 

              SELECT    distinct    0 as fldId
     , isnull(p.fldFiscalYearId,@Id) as fldFiscalYearId,fldItemsHoghughiId, fldParametrId,isnull( p.fldkosuratBudgetPayId,i.fldId) as fldkosuratBudgetPayId
            ,  0  as fldBudgetCode
            , 0 as fldUserId, '' as fldIP, GETDATE() as fldDate
            , '' as fldDesc, i.fldTitle 
            ,  ''  as fldTitleBudget,isnull(f.fldYear,@Value) as fldYear
            , es.fldTitleEstkhdam  as fldTitleEstkhdam
            , cast(es.fldTypeEstekhdamId as varchar(10))  as fldTypeEstekhdamId
            ,es.fldTitleBime  as fldTitleBime
            , cast(es.fldTypeBimeId as varchar(10))  as fldTypeBimeId,3 as fldType
           FROM         Com.tblKosuratBudgetPay AS i
           left join Pay.tblBudgetPayHeader AS p 
                    inner join acc.tblFiscalYear as f on f.fldId=p.fldFiscalYearId  and fldYear=@Value
                    on i.fldId = p.fldkosuratBudgetPayId
                    
             cross apply (select (e2.fldTitle) as fldTitleEstkhdam,(e2.fldId) as fldTypeEstekhdamId ,(bime.fldTitle) as fldTitleBime,(bime.fldId) as fldTypeBimeId 
                    from  com.tblTypeEstekhdam as e2  
                    cross join com.tblTypeBime as bime
                    where not exists (select * from pay.tblBudgetPayDetail as bd 
                    inner join Pay.tblBudgetPayHeader AS pb on bd.fldHeaderId=pb.fldId and pb.fldFiscalYearId=p.fldFiscalYearId
                    where pb.fldkosuratBudgetPayId=p.fldkosuratBudgetPayId and bd.fldTypeEstekhdamId=e2.fldId and  bd.fldTypeBimeId=bime.fldId)
                    )es
           where i.fldId=@Value2
           )t
           order by fldTypeEstekhdamId,fldTypeBimeId

    end

    
    
    END
    
GO
