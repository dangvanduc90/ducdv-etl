#!/bin/bash

/home/analyst/pipelinewise/bin/pipelinewise-docker import --dir pipelinewise_full_table

/home/analyst/pipelinewise/bin/pipelinewise-docker status

/home/analyst/pipelinewise/bin/pipelinewise-docker run_tap --tap mysql_src --target postgres_dwh
/home/analyst/pipelinewise/bin/pipelinewise-docker run_tap --tap mysql_src_auth --target postgres_dwh

/home/analyst/pipelinewise/bin/pipelinewise-docker status

# logined to postgres cli and selected ducdv_dw database
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE txns ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE deposits ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE merchants ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE orders ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE transfers ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE withdrawals ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"
/usr/local/bin/docker-compose -f /home/analyst/superset/docker-compose.yml exec -T postgres psql ducdv_dw postgres -c "ALTER TABLE users ADD COLUMN IF NOT EXISTS dim_date_id bigint, ADD COLUMN IF NOT EXISTS is_loaded BOOLEAN DEFAULT FALSE;"