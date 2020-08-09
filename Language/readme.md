this Lanuage folder is for language specific Tesseract OCR items.

we are splicing them out:
- to keep the container light
- to keep the container running as quick as possible
- to avoide any confusion with the primary english language

Basic command line usage:

tesseract imagename outputbase [-l lang] [--oem ocrenginemode] [--psm pagesegmode] [configfiles...]
For more information about the various command line options use tesseract --help or man tesseract.
```
tesseract input.tiff output --oem 1 -l eng
```
Examples can be found in the documentation.

Tesseract Lanauge Specific Namespace Reference Page
https://tesseract-ocr.github.io/tessapi/5.x/a01825.html

### Tesseract Official GitHub TessData Repo
https://github.com/tesseract-ocr/tessdata

These language data files only work with Tesseract 4.0.0. They are based on the sources in tesseract-ocr/langdata on GitHub. (still to be updated for 4.0.0 - 20180322)

These have models for legacy tesseract engine (--oem 0) as well as the new LSTM neural net based engine (--oem 1).

The LSTM models (--oem 1) in these files have been updated to the integerized versions of tessdata_best on GitHub. So, they should be faster but probably a little less accurate than tessdata_best.

tessdata_fast on GitHub provides an alternate set of integerized LSTM models which have been built with a smaller network. tessdata_fast files are the ones packaged for Debian and Ubuntu.

The legacy tesseract models (--oem 0) have been removed for Indic and Arabic script language files.
