/* RFV - RECENCIA, FREQUENCIA E VALOR */

SELECT  T2.seller_id,
        SUM(T2.price) AS receita_total, /* VALOR */
        COUNT(DISTINCT T1.order_id) AS qtd_pedidos, /* FREQUENCIA */
        COUNT(T2.product_id) AS qtde_produtos


/* PARA UNIR 2 TABELAS DETERMINA UM ALIAS PARA CADA UMA(T1,T2) */
FROM tb_orders AS T1
/* USANDO O LEFT JOIN UNIREMOS AS DUAS PLANILHAS PELA COLUNA ORDER_ID */
LEFT JOIN tb_order_items AS T2
ON T1.order_id = T2.order_id

/* EMCONTRAMOS NA T1 A COLUNA DE TEMPO */
WHERE T1.order_approved_at BETWEEN '2017-06-01' AND '2018-06-01'

/* AGRUPAMOS PELA COLUNA SELLER_ID DA T2 */
GROUP BY T2.seller_id