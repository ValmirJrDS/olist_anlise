WITH tb_pedido AS(

    SELECT DISTINCT
        T1.order_id,
        T2.seller_id

    FROM tb_orders AS T1

    LEFT JOIN tb_order_items AS T2
    ON T1.order_id = T2.order_id

    WHERE T1.order_purchase_timestamp < '2018-01-01'
    AND T1.order_purchase_timestamp >= DATE('2018-01-01', '-6 months')
    AND seller_id IS NOT NULL

),
tb_join AS(
    SELECT T1.*, 
           T2.review_score

    FROM tb_pedido AS T1

    LEFT JOIN tb_order_reviews AS T2
    ON T1.order_id = T2.order_id
),

tb_summary AS(

    SELECT seller_id,

        AVG(review_score) AS avgNota,
        MAX(review_score) AS maxNota,
        MIN(review_score) AS minNota,
        COUNT(review_score) / COUNT(order_id) AS pctAvaliacao


    FROM tb_join

    GROUP BY seller_id

)

SELECT '2018-01-01' AS dtReference,
        * 

FROM tb_summary
