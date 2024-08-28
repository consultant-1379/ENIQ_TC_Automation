import numpy as np
from  decimal import Decimal


#from bigfloat import *
#import pandas as pd

def ffaxw(vector,pmbranchdelta):
   z=vector.split('\r\n')
   del z[-2:]
   db_list=[int(i) for i in z if i.strip()]
   y=pmbranchdelta.split('\r\n')
   del y[-2:]
   pmbranchdelta_list=[int(i) for i in y if i.strip()]
   print("pmbranchdelta_list",pmbranchdelta_list)
   lis=[]
   file = open('H:\ENIQ_TC_Automation\TP\Bharathi\FFAXW.txt', 'r')
   for line in file.readlines():
      fname = line.rstrip().split(' ') 
      for i in fname:
         if (i.startswith('VALUES')):
            status=i.split(',')[-1]
            lis.append(status.replace(')',''))

   test_list = [float(i) for i in lis]
   print(test_list)

   midpoint=test_list
   print("midpoint",midpoint)
   multiply_midpoint=np.multiply(pmbranchdelta_list,midpoint)
   print("multiply_midpoint",multiply_midpoint)
   totalpmbranchdelta=np.sum(pmbranchdelta_list)
   print("totalpmbranchdelta",totalpmbranchdelta)
   totalmultiplymid=np.sum(multiply_midpoint)
   print("totalmultiplymid",totalmultiplymid)
   mean=totalmultiplymid/totalpmbranchdelta
   print("mean",mean)
   midpoint_mean_sub=[x-mean for x in midpoint]
   print("midpoint_mean_sub",midpoint_mean_sub)
   midpoint_mean=np.multiply(midpoint_mean_sub,midpoint_mean_sub)
   
   midpoint_mean=[np.double(x) for x in midpoint_mean ]
   print("midpoint_mean",midpoint_mean)
   frequency_pmbranchdelta=np.multiply(pmbranchdelta_list,midpoint_mean)
   frequency_pmbranchdelta=[np.double(x) for x in frequency_pmbranchdelta ]
   print("frequency",frequency_pmbranchdelta)
   total_frequency_pmbranchdelta=np.sum(frequency_pmbranchdelta)
   print("total_frequency_pmbranchdelta",total_frequency_pmbranchdelta)
   standard_deviation=np.sqrt(total_frequency_pmbranchdelta/totalpmbranchdelta)
   standard_deviation=np.round(standard_deviation,2)
   print("standard_deviation",standard_deviation)
   power=np.power(standard_deviation,2)
   #power=np.round(power,2)
   pmBranchDeltaSir_Samples_SD_SD=np.multiply((totalpmbranchdelta-1),power)
   pmBranchDeltaSir_Samples_SD_SD=np.round(pmBranchDeltaSir_Samples_SD_SD,2)
   print("pmBranchDeltaSir_Samples_SD_SD",pmBranchDeltaSir_Samples_SD_SD)
   mean=np.round(mean,2)
   pmBranchDeltaSir_Samples_MEAN=np.multiply(totalpmbranchdelta,mean)
   pmBranchDeltaSir_Samples_MEAN=np.round(pmBranchDeltaSir_Samples_MEAN,2)
   print("pmBranchDeltaSir_Samples_MEAN",pmBranchDeltaSir_Samples_MEAN)
   power_mean=np.power(mean,2)
   pmBranchDeltaSir_Samples_MEAN_MEAN=np.multiply(totalpmbranchdelta,power_mean)
   pmBranchDeltaSir_Samples_MEAN_MEAN=np.round(pmBranchDeltaSir_Samples_MEAN_MEAN,2)
   print("pmBranchDeltaSir_Samples_MEAN_MEAN",pmBranchDeltaSir_Samples_MEAN_MEAN)
   return pmBranchDeltaSir_Samples_SD_SD,pmBranchDeltaSir_Samples_MEAN,pmBranchDeltaSir_Samples_MEAN_MEAN

def ffaxw_date(output):
   z="".join(output.split("\n")[:-2])
   d_db=z.strip()
   return d_db

def ffaxw_comapare(db_out,rbs_out):
   a,b,c=float(db_out[0]),float(db_out[1]),float(db_out[2])
   d,e,f=rbs_out[0],rbs_out[1],rbs_out[2]
      
   print(a,b,c)
   print(d,e,f)
   if a==d and b==e and c==f:
      return True
   else:
      return False
   
      
      

   
      
    