# Data-Engineering-Project
 使用ETL data pipeline 將UBER 資料清洗、排程、最後放置在GCP上運行與後續分析專案

## Technology Used 使用的技術

- Python
- Pandas
- Jupyter notebook

Google Cloud Platform 
- Google Storage 
- Compute Engine 
- BigQuery
- Looker Studio 

Modern Data Pipeine Tool 
- Magi.AI

# 資料抓取&清洗 & 建立ER圖 
用pandas套件去讀取uber_date.csv
- 使用 .drop_duplicates() 函數刪除重複行。
- 使用 .reset_index(drop=True) 參數表示刪除原始索引，並生成一個新的索引列。
- 最後使用 .merge 將原有df表格 與 清洗過的表格進行merge ,可進行更多的分析和研究。
- 使用 lucidchart  建立表格ER圖 (https://www.lucidchart.com/pages/)
![image](https://github.com/tn00627974/Data-Engineering-Project/assets/139155210/8354e3fb-8375-4fba-925a-d33c32990923)

# 步驟1 (可參考step_viewer的frame1)
- GCP Cloud Storage 上傳檔案
- 取得連結 https://storage.googleapis.com/uber-dataset-0410/uber_data.csv
# 步驟2 (可參考step_viewer的frame2)
- 建置GCP Compute Engine VM虛擬機硬碟及配置
- 作業環境要選 Debian GNU/Linux 11 x86_64 (bullseye), 可以解決安裝時不用.venv的問題 (解決瘋狂噴錯等問題)
- - 啟動你的VM虛擬機 (將以下指令複製貼上VM shell裡installing)
### 虛擬機 vm 安裝指令
```shell
# Install Python and pip 
# 更新您系統上已安裝軟體的套件清單 -y = 自動確認
sudo apt-get update -y 

# 安裝 Python 3 的 `distutils` 套件，這是 Python 程式打包和分發的工具。
sudo apt-get install python3-distutils -y

# 安裝 Python 3 的 `apt` 套件，它提供了一個 Python 介面來與系統的 APT (Advanced Package Tool) 套件管理器交互。
sudo apt-get install python3-apt

# 安裝 `wget` 工具，它是一個用於從網路上下載檔案的命令行工具。
sudo apt-get install wget

# 使用 `wget` 工具從指定的 URL 下載了一個名為 `get-pip.py` 的 Python 腳本。這個腳本用於安裝 Python 的套件管理器 `pip`。
wget https://bootstrap.pypa.io/get-pip.py

# 執行 get-pip.py
sudo python3 get-pip.py

# Install Mage
sudo pip3 install mage-ai

# Install dask_expr
sudo pip3 install dask_expr

# Install Pandas
sudo pip3 install pandas

# Install Google Cloud Library
sudo pip3 install google-cloud
sudo pip3 install google-cloud-bigquery
```

## 官方mage.ai
https://www.mage.ai/

```shell
mage start uber_de_project # 建立專案 uber_de_project
```

```shell
sudo apt-get install git -y # mage start 有錯誤的話 , 請執行它
```


## <span class="red">若作業環境選錯 , 會需要使用 venv來建立安裝 (但不推薦 )</span>
```shell
# 需用venv虛擬去執行程式碼 ,因為會跟環境起衝突 (會跳出error,請參考以下)
python3 -m venv vm # 建立 虛擬環境資料夾vm
source vm/bin/activate # 進入剛創立vm虛擬環境
python3 ./get-pip.py # 最後再執行 
# 若有環境出錯,可參考網址文章
https://www.yaolong.net/article/pip-externally-managed-environment/

# vm 錯誤代碼
error: externally-managed-environment
× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.
    
    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.
    
    If you wish to install a non-Debian packaged Python application,
    it may be easiest to use pipx install xyz, which will manage a
    virtual environment for you. Make sure you have pipx installed.
    
    See /usr/share/doc/python3.11/README.venv for more information.

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

## 查看GCP所有安裝套件
```shell
dpkg --get-selections
```


# 步驟3 (可參考step_viewer的frame3)
Mage.ai 防火牆規則設定
- 虛擬私有雲網路 > 防火牆
- 選 目標 > 網路中的所有執行個體 > 指定TCP 6789 port
- 之後複製VM外部IP > 使用預覽器貼上 > 進入Mage.ai伺服器

# 步驟 4 (可參考step_viewer的frame4)
Mage 面板操作
- 左側面板 > 選 Edit pipeline >
- 載入 Cloud Storage 上傳的 CSV https://storage.googleapis.com/uber-dataset-0410/uber_data.csv
- 轉換 Transformers >  
- 萃取 Extract > GCP bigquery裡面 (需先開通gcp 憑證才能萃取)

# 開通GCP 憑證KEY
- 點選API和服務 >建立憑證 > 服務帳戶 > 角色請選(Bigquery管理員)
- 進入BigQuery > 選專案 > 建立資料集

# Bigquery  (事實表 & 維度表)

| 特點    | **事實表**         | **維度表**              |
| ----- | --------------- | -------------------- |
| 定義    | 包含數據的量化信息       | 包含數據的描述性信息或維度        |
| 單位    | 特定的事件或事實        | 唯一的維度值，如時間、地點、產品、客戶等 |
| 行     | 每一行代表一個特定的事件或事實 | 每一行代表一個唯一的維度值        |
| 主鍵    | -               | 通常包含主鍵，用於唯一標識每個維度值   |
| 外鍵    | 通常包含外鍵，用於與維度表關聯 | -                    |
| 表示的數據 | 事件或事實的數值度量      | 事實表中數據的各種屬性或維度       |

# 步驟5 (可參考step_viewer的frame5)
- 使用 Looker Studio 建立儀錶板 
- 以距離分析票價及常用付款方式
- 最後建立氣泡地圖,將數據可視化在google map上呈現
- https://lookerstudio.google.com/reporting/b1ccee39-8719-4314-9ff4-01b8a9a2a4b4/page/p_mrrofv4hgd 


# 專案遇到的問題 , 處理方式及解決的心得與新學習到的技術 

**環境設置和套件安裝**：
    
    - 在建置計算引擎 VM 虛擬機時，可能會遇到套件安裝的問題，特別是在虛擬環境（venv）中。若出現「externally-managed-environment」錯誤，可能需要確保使用正確的安裝指令，或者使用 venv 虛擬環境來避免與系統套件的衝突。
    
    - 解決方案：作業環境要選 Debian GNU/Linux 11 x86_64 (bullseye), 可以解決安裝時不用.venv的問題 (解決瘋狂噴錯等問題)

**GCP 憑證和權限設置**：
    
    - 在使用 BigQuery 和 Google Storage 時可能會遇到權限不足的問題，導致無法建立憑證或執行操作。
    
    - 解決方案：確保帳戶有足夠的權限來建立憑證，通常需要具有 BigQuery 管理員角色。若遇到權限問題，可以通過更換帳戶或者重新設置權限來解決。

**ETL 流程設計和實現**：
    
    - 處理大量數據時，ETL 流程可能會變得複雜，需要確保每個步驟都能正確執行並保持效率。

    - 解決方案：使用現代資料管道工具（如 Mage.ai）可以簡化 ETL 流程的設計和管理。同時，通過分段處理數據、優化查詢和採用適當的資料結構等方法，可以提高流程的效率和穩定性。
	

**Mage.Ai轉換**：
    
	- 當使用 Mage.ai 進行 Extract 轉換匯入時，遭遇到 403 錯誤：「Access Denied: BigQuery BigQuery: Missing required OAuth scope」。即便採取了多種權限與憑證API設定的嘗試，仍無法成功進行轉換。
	
	- 解決方案是，重新使用 GCP BigQuery 舊有專案，重新建置虛擬機器並進行相應的設定，以確保權限和 OAuth 範圍的正確性，從而解決 403 錯誤。


**數據可視化和分析**：
    
    - 在使用 Looker Studio 建立儀錶板時，可能需要處理大量的數據，並設計合適的可視化方式來呈現分析結果。
    - 解決方案：在設計儀錶板時，可以根據項目需求和目標觀眾來選擇合適的圖表類型和呈現方式。同時，通過將數據轉化為易於理解的視覺元素，可以幫助用戶更好地理解數據和分析結果。


**學習新技術** :
- GCP BigQuery
- Looker Studio 
- Modern Data Pipeine Tool - Magi.AI

# 參考文獻 及 解決文章

https://www.googlecloudcommunity.com/gc/Data-Analytics/Access-Denied-BigQuery-Missing-required-OAuth-scope-Need/td-p/671657
https://medium.com/google-cloud/how-to-end-user-oauth-for-gcp-1dce8e8ef1a2
https://www.googlecloudcommunity.com/gc/Data-Analytics/Access-Denied-BigQuery-BigQuery-Missing-required-OAuth-scope/m-p/486175#M885
[# google_auth_oauthlib.interactive 的源碼](https://google-auth-oauthlib.readthedocs.io/en/latest/_modules/google_auth_oauthlib/interactive.html)
[How to End User OAuth for GCP  如何為 GCP 進行最終用戶 OAuth](https://medium.com/google-cloud/how-to-end-user-oauth-for-gcp-1dce8e8ef1a2)


# Mage.ai 使用 GCP Exporter文件
https://docs.mage.ai/development/blocks/data_exporters/templates#google-bigquery

