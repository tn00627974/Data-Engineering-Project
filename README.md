# Data-Engineering-Project
 使用ETL data pipeline 將UBER 資料清洗、排程、最後放置在GCP上運行與後續分析 的專案

#還在更新中 , 尚未全部完成

# 步驟1
用pandas套件去讀取uber_date.csv
- 使用 .drop_duplicates() 函數刪除重複行。
- 使用 .reset_index(drop=True) 參數表示刪除原始索引，並生成一個新的索引列。
- 最後使用 .merge 將原有df表格 與 清洗過的表格進行merge ,可進行更多的分析和研究。

# 步驟2
使用 lucidchart  建立表格ER圖 
(https://www.lucidchart.com/pages/)
![image](https://github.com/tn00627974/Data-Engineering-Project/assets/139155210/8354e3fb-8375-4fba-925a-d33c32990923)

# 步驟3 
使用 GCP Cloud Storage 上傳檔案csv檔,建立公開連結
![Frame 1](https://github.com/tn00627974/Data-Engineering-Project/assets/139155210/775766ee-be78-4daa-82cd-b6016153d056)
![Frame 2](https://github.com/tn00627974/Data-Engineering-Project/assets/139155210/cddf25da-440b-477a-b2ca-22c29e841ab0)

