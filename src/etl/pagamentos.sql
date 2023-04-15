
WITH tb_pedidos AS(

    SELECT
        DISTINCT
        t1.order_id,
        t2.seller_id

    FROM tb_orders AS t1

    LEFT JOIN tb_order_items as t2
    ON t1.order_id = t2.order_id

   WHERE t1.order_purchase_timestamp < '2018-01-01'
    AND t1.order_purchase_timestamp >= DATE('2018-01-01', '-6 months')
    AND seller_id IS NOT NULL

    
),

tb_join AS(

    SELECT  
            t1.seller_id,
            t2.*
            

    FROM tb_pedidos AS t1

    LEFT JOIN tb_order_payments AS t2
    ON t1.order_id = t2.order_id

    
),

tb_group AS(

    SELECT seller_id,
        payment_type,
        COUNT(DISTINCT order_id) AS qtdePedidoMeioPagamento,
        SUM(payment_value) AS vlPedidosMeioPagamento



    FROM tb_join

    GROUP BY seller_id, payment_type
),

tb_sumary AS(

    SELECT  
        seller_id,

        SUM(CASE WHEN payment_type = 'credit_card' THEN qtdePedidoMeioPagamento ELSE 0 END) AS qtde_credit_card,
        SUM(CASE WHEN payment_type = 'boleto' THEN qtdePedidoMeioPagamento ELSE 0 END) AS qtde_boleto,
        SUM(CASE WHEN payment_type = 'debit_card' THEN qtdePedidoMeioPagamento ELSE 0 END) AS qtde_debit_card,
        SUM(CASE WHEN payment_type = 'voucher' THEN qtdePedidoMeioPagamento ELSE 0 END) AS qtde_voucher,
        
        SUM(CASE WHEN payment_type = 'credit_card' THEN qtdePedidoMeioPagamento ELSE 0 END) / SUM( qtdePedidoMeioPagamento) AS pct_qtd_credit_card,
        SUM(CASE WHEN payment_type = 'boleto' THEN qtdePedidoMeioPagamento ELSE 0 END) / SUM( qtdePedidoMeioPagamento) AS pct_qtd_boleto,
        SUM(CASE WHEN payment_type = 'debit_card' THEN qtdePedidoMeioPagamento ELSE 0 END) / SUM( qtdePedidoMeioPagamento) AS pct_qtd_debit_card,
        SUM(CASE WHEN payment_type = 'voucher' THEN qtdePedidoMeioPagamento ELSE 0 END)  / SUM(qtdePedidoMeioPagamento )AS pct_qtd_voucher,

        SUM(CASE WHEN payment_type = 'credit_card' THEN vlPedidosMeioPagamento ELSE 0 END)  AS valor_credit_card_pedido,
        SUM(CASE WHEN payment_type = 'boleto' THEN vlPedidosMeioPagamento ELSE 0 END)  AS valor_boleto_pedido,
        SUM(CASE WHEN payment_type = 'debit_card' THEN vlPedidosMeioPagamento ELSE 0 END)  AS valor_debit_card_pedido,
        SUM(CASE WHEN payment_type = 'voucher' THEN vlPedidosMeioPagamento ELSE 0 END)  AS valor_vouche_pedidor,


        SUM(CASE WHEN payment_type = 'credit_card' THEN vlPedidosMeioPagamento ELSE 0 END)  AS pct_valor_credit_card,
        SUM(CASE WHEN payment_type = 'boleto' THEN vlPedidosMeioPagamento ELSE 0 END)  AS pct_valor_boleto,
        SUM(CASE WHEN payment_type = 'debit_card' THEN vlPedidosMeioPagamento ELSE 0 END)  AS pct_valor_debit_card,
        SUM(CASE WHEN payment_type = 'voucher' THEN vlPedidosMeioPagamento ELSE 0 END)  AS pct_valor_voucher

    
    FROM tb_group

    GROUP BY seller_id
),

tb_cartao AS(
    SELECT seller_id,
        AVG(payment_sequential) AS avgQtdeParcelas,
        MAX(payment_sequential) AS maxgQtdeParcelas,
        MIN(payment_sequential) AS mingQtdeParcelas

    from tb_join

    WHERE payment_type = 'credit_card'

    GROUP BY seller_id
)

SELECT
        '2018-01-01' AS dtReference,
        t1.*,
        t2.avgQtdeParcelas,
        t2.maxgQtdeParcelas,
        t2.mingQtdeParcelas
FROM tb_sumary as t1

LEFT JOIN tb_cartao AS t2
ON t1.seller_id = t2.seller_id
        
 