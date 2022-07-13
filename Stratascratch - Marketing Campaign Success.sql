select

    count(distinct a.user_id)
    
from

    marketing_campaign a
    
JOIN

    (
        select
            user_id,
            group_concat(product_id) as first_products
        from
            (
                select *
                    from (
                            select
                                user_id,
                                created_at,
                                product_id,
                                dense_rank() over (partition by user_id order by created_at) as purchase_order
                            from marketing_campaign
                        ) as first_purchase_tbl
            where purchase_order = 1
            ) as first_purchase_tbl_distinct
            
        group by
            user_id
    ) b
    
ON a.user_id = b.user_id

where LOCATE(a.product_id,b.first_products) = 0;