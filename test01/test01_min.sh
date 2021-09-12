#!/bin/bash

cd /home/ubuntu/test_01/

        # создаем файл размером 100К вида dd-mm-YYYY-hh:mm.log
base64 /dev/urandom | head -c 100000 > $(date +%d-%m-%Y-%H:%M).log

        # отправляем созданный файл на второй сервер
rsync -avz /home/ubuntu/test_01/*.log root@85.192.35.116:/tmp/test01

	# на удаленном сервере удаляем файлы, которые старше 5 мин. 
ssh root@85.192.35.116 "cd /tmp/test01; find . -cmin +5 -exec rm -f {} \;; exit"

	# удаляем созданные .log файлы
rm -rf *.log

