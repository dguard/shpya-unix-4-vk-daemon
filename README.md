VK-daemon
=================================
**Использование**:

    chmod +x vk-daemon.sh
    ./vk-daemon.sh <user_id> [tmp-dir=/tmp/vk-daemon]
    
 - **user_id** - идентификатор пользователя
  
 - **tmp-dir** - директория для временных файлов
 
 
**Пример**:
 
    ./vk-daemon.sh 1

**Зависимости**:

 -  notify-send
 
	    sudo apt-get install notify-send
	    

Установка crontab с периодом 5 минут:

    crontab -e

    */5 *   *   *   *    bash /home/alexander/www/shpya-unix-4-vk-daemon/vk-daemon.sh 1
    