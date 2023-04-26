WITH tb_join AS(


    SELECT DISTINCT 
        t1.order_id,
        t1.customer_id,
        t2.seller_id,
        t3.customer_state

    FROM tb_orders AS t1

    LEFT JOIN tb_order_items AS t2
    ON t1.order_id = t2.order_id

    LEFT JOIN tb_customers AS t3
    ON t1.customer_id = t3.customer_id 

    WHERE t1.order_purchase_timestamp < '2018-01-01'
    AND t1.order_purchase_timestamp >= DATE('2018-01-01', '-6 months')
    AND seller_id IS NOT NULL

),

tb_group AS(

    SELECT 
        seller_id,
        COUNT(DISTINCT customer_state) AS qtUFsPedidos,

        COUNT(DISTINCT CASE WHEN customer_state = 'AC' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoAC,
        COUNT(DISTINCT CASE WHEN customer_state = 'AL' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoAL,
        COUNT(DISTINCT CASE WHEN customer_state = 'AM' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoAM,
        COUNT(DISTINCT CASE WHEN customer_state = 'AP' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoAP,
        COUNT(DISTINCT CASE WHEN customer_state = 'BA' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoBA,
        COUNT(DISTINCT CASE WHEN customer_state = 'CE' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoCE,
        COUNT(DISTINCT CASE WHEN customer_state = 'DF' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoDF,
        COUNT(DISTINCT CASE WHEN customer_state = 'ES' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoES,
        COUNT(DISTINCT CASE WHEN customer_state = 'GO' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoGO,
        COUNT(DISTINCT CASE WHEN customer_state = 'MA' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoMA,
        COUNT(DISTINCT CASE WHEN customer_state = 'MG' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoMG,
        COUNT(DISTINCT CASE WHEN customer_state = 'MS' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoMS,
        COUNT(DISTINCT CASE WHEN customer_state = 'MT' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoMT,
        COUNT(DISTINCT CASE WHEN customer_state = 'PA' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoPA,
        COUNT(DISTINCT CASE WHEN customer_state = 'PB' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoPB,
        COUNT(DISTINCT CASE WHEN customer_state = 'PE' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoPE,
        COUNT(DISTINCT CASE WHEN customer_state = 'PI' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoPI,
        COUNT(DISTINCT CASE WHEN customer_state = 'PR' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoPR,
        COUNT(DISTINCT CASE WHEN customer_state = 'RJ' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoRJ,
        COUNT(DISTINCT CASE WHEN customer_state = 'RN' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoRN,
        COUNT(DISTINCT CASE WHEN customer_state = 'RO' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoRO,
        COUNT(DISTINCT CASE WHEN customer_state = 'RR' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoRR,
        COUNT(DISTINCT CASE WHEN customer_state = 'RS' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoRS,
        COUNT(DISTINCT CASE WHEN customer_state = 'SC' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoSC,
        COUNT(DISTINCT CASE WHEN customer_state = 'SE' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoSE,
        COUNT(DISTINCT CASE WHEN customer_state = 'SP' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoSP,
        COUNT(DISTINCT CASE WHEN customer_state = 'TO' THEN order_id END) / COUNT(DISTINCT order_id) AS pctPedidoTO

  from tb_join

    GROUP BY seller_id

)

SELECT 
      '2018-01-01' AS dtReference,
      *
FROM tb_group