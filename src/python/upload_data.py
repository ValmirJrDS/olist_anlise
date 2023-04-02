#%%
import os
import pandas as pd
import sqlalchemy

""" VARIAVEL PARA CONEXÃO COM O BANCO """
str_connection = 'sqlite:///{path}'

#%%

""" DEFINIR A BASE DO DIRETORIO DO PROJETO
    E SETAR ONDE ESTÃO AS PLANILHAS 
 """
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DATA_DIR = os.path.join( BASE_DIR, 'data' )


# %%
""" COMPRESSÃO DE LISTA(LIST COMPREND) """
files_names = [ i for i in os.listdir( DATA_DIR ) if i.endswith('.csv') ]

""" ABRINDO CONEXAO COM O BANCO E TRANSFORMANDO 
    AS TABELAS EM .DB
 """
str_connection = str_connection.format( path= os.path.join( DATA_DIR, 'olist.db' ) ) 
connection = sqlalchemy.create_engine( str_connection)

for i in files_names:
    print(i)
    df_tmp = pd.read_csv(os.path.join(DATA_DIR, i))

    """ TRATANDO A NOMECLATURA DAS TABELAS """
    table_name = "tb_" + i.strip(".csv").replace("olist_", "").replace("_dataset", "")
    df_tmp.to_sql( table_name, 
                  connection,
                  if_exists='replace',
                  index=False)
# %%

