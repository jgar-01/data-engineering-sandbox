\# Portland Airbnb Data Engineering \& Analytics Pipeline



A production-grade, end-to-end SQL data pipeline built to ingest, clean, transform, and analyze \~486k rows of Portland Airbnb market data. 



\## 🚀 Project Overview

Raw data is notoriously messy. This project simulates a real-world data engineering workflow: moving unstructured raw data through a cleaning and type-casting pipeline, and finally materializing an analytics-ready layer to generate actionable market insights.



\## 📁 Repository Structure

```text

├── sql/

│   ├── 01\_eda\_raw\_data.sql      # Initial data profiling and anomaly detection

│   ├── 02\_transform\_data.sql    # Idempotent ETL script (cleaning, regex stripping, casting)

│   └── 03\_analysis.sql          # Business intelligence and market aggregation queries

└── README.md

