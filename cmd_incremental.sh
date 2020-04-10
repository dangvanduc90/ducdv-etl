#!/bin/bash

cd /home/analyst/ducdv-etl || exit

/home/analyst/pipelinewise/bin/pipelinewise-docker import --dir pipelinewise_incremental

/home/analyst/pipelinewise/bin/pipelinewise-docker status

/home/analyst/pipelinewise/bin/pipelinewise-docker run_tap --tap mysql_src --target postgres_dwh
/home/analyst/pipelinewise/bin/pipelinewise-docker run_tap --tap mysql_src_auth --target postgres_dwh

/home/analyst/pipelinewise/bin/pipelinewise-docker status

# logined to postgres cli and selected ducdv_dw database
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE txns SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE deposits SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE merchants SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE orders SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE transfers SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE withdrawals SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "UPDATE users SET dim_date_id = CAST(TO_CHAR(created_at, 'YYYYMMDD') AS BIGINT), is_loaded = TRUE WHERE is_loaded is FALSE;"
