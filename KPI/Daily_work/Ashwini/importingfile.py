import os
import zipfile


#     p=r'H:\Downloads\report_package\ENIQ_Feature_Files_R36A232.zip'
#     with zipfile.ZipFile(p,'r') as a:
#     # with a.open('feature_descriptions') as b:
#         a.extractall(r'H:\Downloads\report_package')

        # print(b.readlines())
# import  zipfile
# from zipfile    import ZipFile
# def extract_file(file_name: str):
#     path = r"H:\\Downloads\\report_package\\ENIQ_Feature_Files_R36B232.zip"
#     with ZipFile(path) as f:
#         f.extractall(r"H:\\Downloads\\report_package\\ENIQ_Feature_Files_R36B232.zip")

# extract_file('ENIQ_Feature_Files_R36B232.zip')
# from zipfile    import ZipFile
# #path = f"H:\\Downloads\\report_package\\ENIQ_Feature_Files_R36B232.zip"
# path='H:/Downloads/report_package/ENIQ_Feature_Files_R36B232.zip'
# print(path)
# with ZipFile(path,'r') as zip_object:
#    print("test")
#    print(zip_object)
#    zip_object.extractall('H:\Downloadsreport_package')
 
from zipfile import ZipFile
def extract_file(file_name: str):
    # file_name = 'ENIQ_Feature_Files_R36B232.zip'
    with ZipFile(file_name,'r') as zip: 
        zip.printdir()
        zip.extractall()
    