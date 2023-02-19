function f = Objective_function(x_new)
%experimental data for 32 coordianated INV01
  


    y_measure_1=y_measure_INV1;
    y_measure_2=y_measure_INV2;
    y_measure_3=y_measure_INH1;
    y_measure_4=y_measure_INH2;
    
 load gregnet_MC_3D
 ypredict = gregnet_MC_3D(x_new');
     y1_predict = ypredict(1:32,1);
     y2_predict = ypredict(33:64,1);
     y3_predict = ypredict(65:96,1);
     y4_predict = ypredict(97:128,1);
    
    NN=32;
         S1 = std(y_measure_INV01);
         M1 = mean(y_measure_INV01);
         S2 = std(y_measure_INV03);
         M2 = mean(y_measure_INV03);
         S3 = std(y_measure_INH01);
         M3 = mean(y_measure_INH01);
         S4 = std(y_measure_INH02);
         M4 = mean(y_measure_INH02);
           
    f=0;
     Alpha= 3;
     eps=0.000001;
        for i = 1:NN
            C1 = 1/ (Alpha*( (y_measure_INV01(i,1) - M1)/S1 +eps)^2);
            C2 =   1/ (Alpha*abs( (y_measure_INV03(i,1)) - M2)/S2+eps)^2;
            C3 =   1/Alpha* (abs( (y_measure_INH01(i,1)) - M3)/S3+eps)^2;
            C4 =   1/Alpha* (abs( (y_measure_INH02(i,1)) - M4)/S4+eps)^2;

          
              C1= tanh( C1); C2= tanh(C2); C3=  tanh(C3); C4=  tanh(C4);

       f1 =  (y1_predict(i,1) - y_measure_INV01(i,1))^2* C1;
       f2 =  (y2_predict(i,1) - y_measure_INV03(i,1))^2* C2;
       f3 =  (y3_predict(i,1) - y_measure_INH01(i,1))^2* C3;
       f4 =  (y4_predict(i,1) - y_measure_INH02(i,1))^2* C4;
   %     f= f+(f1 + f3) /(2*NN);
    f= f+(f1+f2+f3+f4)/(4*NN);
        end
      
   f
    
    
    
end