import subprocess
import importlib
import time


def install_library(library_name):
    try:
        importlib.import_module(library_name)
        print(f'{library_name} is already installed' )
    except ImportError:
        print('Installing Library')
        subprocess.call(f'pip install {library_name}')

libraries=['bs4']
for i in libraries:
    install_library(i)

from bs4 import BeautifulSoup
import re
import glob
matching_files= glob.glob ("C:/Users/Administrator/Desktop/ebid_housekeeping_report*.html")
#import requests
with open(matching_files[0], "r") as file:
    soup=BeautifulSoup(file,'html.parser')

def HK_report():
    #try:
        flag='True'    
        red_ele=soup.find_all('font',{'color':'red'})
        for i in red_ele:
                if i.get_text().strip():
                    flag='False'
                    if flag == 'False':
                        print('getting issues')
                        
        table=soup.find_all('table',{'id':'t01'})
        sixth_table=table[6]
        data6=sixth_table.find_all('tr')
        for i in data6:
            d=i.find_all('td')
            for j in d:
                if j.get_text().strip():
                    print(j.get_text())
                else:
                    flag='False'
                    if flag == 'False':
                        print('empty value')
                        break
            if flag == 'False':
                print('empty value')
                break
        #print(flag)
        return flag
        
        
#HK_report()