# Google Bigquery Test connection
import os
from google.cloud import bigquery as bq
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "config/f74f.json"
client = bq.Client()
query = "SELECT 1"
query_job = client.query(query)

# 检查查询结果
rows = list(query_job)
if rows:
    print("連線成功")
else:
    print("連線失敗，請檢查配置檔,或開啟Google憑證。")
 
 
# Creat new dataset
dataset_id = 'abiding-ascent-408115.test' # 設定 Dataset 名稱為test，可以修改。
dataset = bq.Dataset(dataset_id)
# dataset.location = "asia-east1"  # 設定資料位置，如不設定預設是 US
# dataset.default_table_expiration_ms = 30 * 24 * 60 * 60 * 1000  # 設定資料過期時間，這邊設定 30 天過期
# dataset.description = 'creat_new_dataset & expiration in 30 days & location at asia-east1'  # 設定 dataset 描述
dataset = client.create_dataset(dataset)  # Make an API request.

datasets = list(client.list_datasets())  # Make an API request.
 
for dataset in datasets:
    print(dataset.dataset_id)


# Google 的 OAuth 2.0 機制進行身份驗證
# from google_auth_oauthlib import flow
# launch_browser = True # when using locally and False when remote
# appflow = flow.InstalledAppFlow.from_client_secrets_file(
#     '1111.json',
#     scopes=['https://www.googleapis.com/auth/bigquery'])

# if launch_browser:
#     appflow.run_local_server()
# else:
#     appflow.run_console()

# credentials = appflow.credentials
