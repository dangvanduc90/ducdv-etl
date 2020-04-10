#/bin/bash

myarray=(`find ~/.pipelinewise/postgres_dwh/mysql_src/log/ -maxdepth 1 -name "*.failed"`)

latest_file_failed=($(find ~/.pipelinewise/postgres_dwh/mysql_src/log/ -maxdepth 1 -name "*.failed" | sort -r | head -n1))

if [ ${#myarray[@]} -gt 0 ]; then
    my_payload="{\"channel\": \"#etl\", \"username\": \"webhookbot\", \"text\": \"This is file $latest_file_failed posted to #etl and comes from a bot named webhookbot.\", \"icon_emoji\": \":ghost:\"}"
    curl -X POST --data-urlencode "payload=$my_payload" https://hooks.slack.com/services/xxx/xxx/xxx
else
    echo "etl today work correcly"
fi