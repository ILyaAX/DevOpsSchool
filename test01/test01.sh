#!/bin/bash

cd /home/ubuntu/test_01/

        # создаем файл размером 100К вида dd-mm-YYYY.log
base64 /dev/urandom | head -c 100000 > $(date +%d-%m-%Y).log

        # отправляем созданный файл на второй сервер
rsync -avz /home/ubuntu/test_01/*.log root@85.192.35.116:/tmp/test01

	# на удаленном сервере удаляем файлы, которые старше 7 дней. 
ssh root@85.192.35.116 "cd /tmp/test01; find . -mtime +7 -exec rm -f {} \;; exit"

	# удаляем созданные .log файлы
rm -rf *.log

