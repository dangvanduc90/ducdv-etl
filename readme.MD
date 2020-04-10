You must install superset from `https://github.com/dangvanduc90/superset` before
initial all command below:

`cd /var/www/`
<br />

`git clone git@github.com:dangvanduc90/ducdv-etl.git`
<br />

`cd /var/www/ducdv-etl`

<br />
run command on move database once

`./cmd_full_table.sh`

<br />

set crontab
`crontab -e`

<br />

insert this line below to crontab

`0 1 * * * sh /var/www/ducdv-etl/cmd_incremental.sh > /home/analyst/cronlogs/cmd_incremental.log`

make sure you have been create dir `/home/analyst/cronlogs/`

<br />

to check log crontab
<br />
`tail -f /home/analyst/cronlogs/cmd_incremental.log`

<br />

#### notice

`truncate` table when using transfer with `replication_method: "FULL_TABLE""` might not work correctly

better you should drop/delete table before