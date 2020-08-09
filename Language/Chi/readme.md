
Chi == Chinese lanuage

the files listed below are already included in the Tesseract container in the following path.  date/time stamps match the tessdata github repo date/time stamps.

```
root@ocr-1:/usr/share/tesseract-ocr/4.00/tessdata# ll chi*
-rw-r--r-- 1 root root 2469156 Sep 24  2019 chi_sim.traineddata
-rw-r--r-- 1 root root 1927902 Sep 24  2019 chi_sim_vert.traineddata
-rw-r--r-- 1 root root 2366642 Sep 24  2019 chi_tra.traineddata
-rw-r--r-- 1 root root 1824756 Sep 24  2019 chi_tra_vert.traineddata
root@ocr-1:/usr/share/tesseract-ocr/4.00/tessdata#
```

### Tesseract Official GitHub TessData Repo
https://github.com/tesseract-ocr/tessdata

The following files are specific to chi trained data, these need to be downloaded in dockerfile for Chi
- chi_sim.traineddata - Update traineddata LSTM model with best model converted to integer - https://github.com/tesseract-ocr/tessdata/blob/master/chi_sim.traineddata
- chi_sim_vert.traineddata - Update LSTM Models to integerized tessdata_best for files < 25mb - https://github.com/tesseract-ocr/tessdata/blob/master/chi_sim_vert.traineddata
- chi_tra.traineddata - Update traineddata LSTM model with best model converted to integer - https://github.com/tesseract-ocr/tessdata/blob/master/chi_tra.traineddata
- chi_tra_vert.traineddata - Update LSTM Models to integerized tessdata_best for files < 25mb - https://github.com/tesseract-ocr/tessdata/blob/master/chi_tra_vert.traineddata


### Tesseract Lanauge Specific Namespace Reference Page
Chi SIM & TRA Details

#### CHI_SIM_FONTS
list language_specific.CHI_SIM_FONTS
```
 =  [
     "AR PL UKai CN",
     "AR PL UMing Patched Light",
     "Arial Unicode MS",
     "Arial Unicode MS Bold",
     "WenQuanYi Zen Hei Medium",
 ]
```
#### CHI_TRA_FONTS
list language_specific.CHI_TRA_FONTS
```
 =  [
     "AR PL UKai TW",
     "AR PL UMing TW MBE Light",
     "AR PL UKai Patched",
     "AR PL UMing Patched Light",
     "Arial Unicode MS",
     "Arial Unicode MS Bold",
     "WenQuanYi Zen Hei Medium",
 ]
```


### Original information requested came from this page and info
Orginal email Aug 7, 2020 @4pm from Jeff Kiley

https://stackoverflow.com/questions/16581626/chinese-character-recognition-using-tesseract-ocr

16

You need to download chinese trained data (it will be a file like chi_sim.traineddata) and add it to your tessdata folder.

To download the file https://github.com/tesseract-ocr/tessdata/raw/master/chi_sim.traineddata

and use like this
```
Tesseract* tesseract= [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"chi_sim"];
```

if you have any problem you can download my experiment with tessaract (with chinese language support) from https://github.com/aryansbtloe/ExperimentWithTesseract.git

I have tested this one...Hope you will find this useful.