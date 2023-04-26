 
 WITH tb_join AS(
 
    SELECT DISTINCT
            T2.seller_id,
            T3.*

    FROM tb_orders AS T1

    LEFT JOIN tb_order_items AS T2
    ON T1.order_id = T2.order_id

    LEFT JOIN tb_products AS T3
    ON T2.product_id = T3.product_id

    WHERE T1.order_purchase_timestamp < '2018-01-01'
    AND T1.order_purchase_timestamp >= DATE('2018-01-01', '-6 months')
    AND T2.seller_id IS NOT NULL

 ),
 
 tb_summary as (
     SELECT seller_id,
            AVG(COALESCE(product_photos_qty, 0)) AS avgFotos,
            AVG(product_weight_g * product_length_cm * product_height_cm) AS avgVolumeProduto, 
            MIN(product_weight_g * product_length_cm * product_height_cm) AS minVolumeProduto,
            MAX(product_weight_g * product_length_cm * product_height_cm) AS maxVolumeProduto,
        
            COUNT(DISTINCT CASE WHEN product_category_name = 'cama_mesa_banho' THEN product_id END) / COUNT(DISTINCT product_id) AS pctcama_mesa_banho,
            COUNT(DISTINCT CASE WHEN product_category_name = 'beleza_saude' THEN product_id END) / COUNT(DISTINCT product_id) AS pctbeleza_saude,
            COUNT(DISTINCT CASE WHEN product_category_name = 'esporte_lazer' THEN product_id END) / COUNT(DISTINCT product_id) AS pctesporte_lazer,
            COUNT(DISTINCT CASE WHEN product_category_name = 'informatica_acessorios' THEN product_id END) / COUNT(DISTINCT product_id) AS pctinformatica_acessorios,
            COUNT(DISTINCT CASE WHEN product_category_name = 'moveis_decoracao' THEN product_id END) / COUNT(DISTINCT product_id) AS pctmoveis_decoracao,
            COUNT(DISTINCT CASE WHEN product_category_name = 'utilidades_domesticas' THEN product_id END) / COUNT(DISTINCT product_id) AS pctutilidades_domesticas,
            COUNT(DISTINCT CASE WHEN product_category_name = 'relogios_presentes' THEN product_id END) / COUNT(DISTINCT product_id) AS pctrelogios_presentes,
            COUNT(DISTINCT CASE WHEN product_category_name = 'telefonia' THEN product_id END) / COUNT(DISTINCT product_id) AS pcttelefonia,
            COUNT(DISTINCT CASE WHEN product_category_name = 'automotivo' THEN product_id END) / COUNT(DISTINCT product_id) AS pctautomotivo,
            COUNT(DISTINCT CASE WHEN product_category_name = 'brinquedos' THEN product_id END) / COUNT(DISTINCT product_id) AS pctbrinquedos,
            COUNT(DISTINCT CASE WHEN product_category_name = 'cool_stuff' THEN product_id END) / COUNT(DISTINCT product_id) AS pctcool_stuff,
            COUNT(DISTINCT CASE WHEN product_category_name = 'ferramentas_jardim' THEN product_id END) / COUNT(DISTINCT product_id) AS pctferramentas_jardim,
            COUNT(DISTINCT CASE WHEN product_category_name = 'perfumaria' THEN product_id END) / COUNT(DISTINCT product_id) AS pctperfumaria,
            COUNT(DISTINCT CASE WHEN product_category_name = 'bebes' THEN product_id END) / COUNT(DISTINCT product_id) AS pctbebes,
            COUNT(DISTINCT CASE WHEN product_category_name = 'eletronicos' THEN product_id END) / COUNT(DISTINCT product_id) AS pcteletronicos

        
     FROM tb_join 

     GROUP BY seller_id
 )

 SELECT '2018-01-01' AS dtReference,
        *
 
 
 FROM tb_summary

 /* SELECT product_category_name
 
 FROM tb_products AS T1

 LEFT JOIN tb_order_items AS T2
 ON T1.product_id = T2.product_id

 WHERE T2.seller_id IS NOT NULL

 GROUP BY 1
 ORDER BY COUNT(DISTINCT order_id)DESC

 LIMIT 15 */ 







 

 