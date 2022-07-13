/* https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced
You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.
The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day. */


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