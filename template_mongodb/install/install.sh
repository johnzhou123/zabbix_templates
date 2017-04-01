# conf
cp conf/mongodb.conf /usr/local/zabbix/etc/zabbix_agentd.conf.d/

# scripts
mkdir /usr/local/zabbix/bin/scripts
cp conf/mdb_sstat.py /usr/local/zabbix/bin/scripts/
cp -rf conf/qiueer/ /usr/local/zabbix/bin/scripts/
chmod 777 /usr/local/zabbix/bin/scripts/mdb_sstat.py

# UnsafeUserParameters=1
CHECK=`grep "^Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/" /usr/local/zabbix/etc/zabbix_agentd.conf|wc -l`
if [[ "w$CHECK" == "w0" ]]
then
    echo 'Include=/usr/local/zabbix/etc/zabbix_agentd.conf.d/' >> /usr/local/zabbix/etc/zabbix_agentd.conf
fi

# UnsafeUserParameters=1
CHECK=`grep "^UnsafeUserParameters=1" /usr/local/zabbix/etc/zabbix_agentd.conf|wc -l`
if [[ "w$CHECK" == "w0" ]]
then
    sed -ri '/UnsafeUserParameters=/a UnsafeUserParameters=1' /usr/local/zabbix/etc/zabbix_agentd.conf
fi

# Timeout=10
CHECK=`grep "^Timeout=3" /usr/local/zabbix/etc/zabbix_agentd.conf|wc -l`
if [[ "w$CHECK" == "w0" ]]
then
    sed -ri '/Timeout=3/a Timeout=10' /usr/local/zabbix/etc/zabbix_agentd.conf
fi

# AllowRoot=1
CHECK=`grep "^AllowRoot=1" /usr/local/zabbix/etc/zabbix_agentd.conf|wc -l`
if [[ "w$CHECK" == "w0" ]]
then
    sed -ri '/AllowRoot=0/a AllowRoot=1' /usr/local/zabbix/etc/zabbix_agentd.conf
fi
/etc/init.d/zabbix_agentd restart
