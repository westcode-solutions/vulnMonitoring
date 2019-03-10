# vulnMonitoring
Omvärldsbevakning 

Grundinstallation av Kali rolling 

git clone https://github.com/cve-search/cve-search.git
#pwd 
/root/cve-search
# apt install python3-pip
# pip3 install -r requirements.txt
# apt install mongodb mongodb-dev
# systemctl enable mongodb
# systemctl start mongodb
# cd /root/cve-search/sbin
# python3 db_mgmt.py -p
# python3 db_mgmt_cpe_dictionary.py (tar en bra stund, nära 1h)
# python3 db_updater.py -c
# python3 db_mgmt_ref.py (kräver Redis server, inget som körs ännu)
# python3 db_updater.py -v  (för att uppdatera DB)

fixa så uppdatering görs varje halvtimme av cve DB 
# python3 /root/cve-search/sbin/db_updater.py -v

fixa redis också: 
# apt install redis
# systemctl enable redis-server 
# systemctl start redis-server 
# python3 /root/cve-search/sbin/db_mgmt_ref.py

crontab -e 
kör var 30:e minut
*/30 * * * * python3 /root/cve-search/sbin/db_updater.py -v -c
-c är för redis/cache utifall webbversionen skall användas
(OBS! kör inte -v -f , då droppas och återpoppuleras alla databaser ,vilket tar nån timme)
jobb som körts hamnar under /var/log/syslog
Jun 25 17:30:01 kali CRON[9253]: (root) CMD (python3 /root/cve-search/sbin/db_updater.py -v)
Jun 25 18:00:01 kali CRON[9401]: (root) CMD (python3 /root/cve-search/sbin/db_updater.py -v)
Jun 25 18:30:01 kali CRON[9605]: (root) CMD (python3 /root/cve-search/sbin/db_updater.py -v)

python3 db_fulltext.py -l 0 -v (tar en bra stund, eventuellt inte nödvändigt) <- tog ett par timmar! 
