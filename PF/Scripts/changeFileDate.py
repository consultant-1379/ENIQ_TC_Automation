#s1='A20230311.1000+0200-1015+0200_SubNetwork=SubNetwork,NetworkElement=vAFG01_20230311-1000_statsfile.tar.gz'
#s2=s1.replace(s1[s1.find('2023'):s1.find('2023')+8],'20240311')
from datetime import datetime, timedelta
import os
import sys
# Get today's date
#tpname=raw_input()
today = datetime.now()

# Calculate yesterday's date
yesterday = today - timedelta(days=1)

# Format the date as yyyymmdd
formatted_yesterday = yesterday.strftime("%Y%m%d")

def get_all_files(directory):
    # Get a list of all files and folders in the specified directory
    contents = os.listdir(directory)

    # Filter out only the files
    files = [item for item in contents if os.path.isfile(os.path.join(directory, item))]

    return files
# Specify the directory path
directory_path = "/eniq/home/dcuser/"+sys.argv[1]

# Get all folders in the specified directory
folders = []


for root, dirs, files in os.walk(directory_path):
    for name in dirs:
        folders.append(root+'/'+name)
newfilename=''
# Print the list of folders
print("Folders in the directory:")
for folder in folders:
    print(folder)
    files=get_all_files(folder+'/')
    for file in files:
        print(file)
        if '2023' in file:
            newfilename=file.replace(file[file.find('2023'):file.find('2023')+8],formatted_yesterday)
            print(newfilename)
            os.rename(folder+'/'+file,folder+'/'+newfilename)         