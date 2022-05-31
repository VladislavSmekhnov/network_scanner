#!/usr/bin/python3

import pathlib
import requests
from datetime import datetime
import speedtest
import time

current_directory = pathlib.Path().resolve()
url = 'https://www.google.com'
file_name = 'internet_logs.txt'

timeout = 5  # время в секундах, в течение которого запросы должны ждать до остановки


def get_time():
    now = datetime.now()
    current_time = now.strftime('%d.%m.%Y, %H:%M:%S')
    return current_time


def count_ping(wifi):
    servernames = []
    wifi.get_servers(servernames)
    return wifi.results.ping


def check_internet_connection(req_number=5, downtime=5):
    print('\nThe program started to work...')
    connection_info = []
    for i in range(req_number):
        connection_status = ''
        try:
            print(f'Last request time:\t{get_time()}')
            request = requests.get(url, timeout=timeout)
            if i == 0:
                print('Status (now):\tConnected to the Internet')

            connection_status = 'Connected to the Internet'
            wifi = speedtest.Speedtest()
            download_speed = wifi.download()
            upload_speed = wifi.upload()

            ping = count_ping(wifi=wifi)
            download_speed /= 1048576
            upload_speed /= 1048576

            if 27 > download_speed > 0 and upload_speed > 0:
                connection_info.clear()

                ping_info = f'Ping:\t{ping:.2f} ms'
                download_speed_info = f'Download speed:\t{download_speed:.2f} Mbit/s'
                upload_speed_info = f'Upload speed:\t{upload_speed:.2f} Mbit/s'

                connection_info = [connection_status, get_time(), ping_info, download_speed_info, upload_speed_info]
                with open(file_name, 'a', encoding='utf-8') as f:
                    for line in connection_info:
                        f.write(line)
                        f.write('\n')
                    f.write(30 * '=')
                    f.write('\n')

        except (requests.ConnectionError, requests.Timeout) as exception:
            connection_status = 'No Internet connection'
            if i == 0:
                print(f'Status (now): {connection_status}')

            connection_info.clear()
            connection_info = [connection_status, get_time()]
            with open(file_name, 'a', encoding='utf-8') as f:
                for line in connection_info:
                    f.write(line)
                    f.write('\n')
                f.write(30 * '=')
                f.write('\n')

        time.sleep(downtime)


def main():
    print('Hi! This is a program for checking your internet connection and its quality.')
    open(file_name, 'w', encoding='utf-8').close() # to erase the .txt file contents
    req_number = input('Enter the number of requests: ')
    downtime = input('Enter the timeout between requests (in seconds): 25 + ')
    check_internet_connection(req_number=int(req_number), downtime=int(downtime))
    print(f'All information is contained along this path: {current_directory}\\{file_name}')


if __name__ == '__main__':
    main()
