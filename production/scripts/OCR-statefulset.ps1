# this script is to do OCR with Tesseract
# the /OCR folder is a PV/PVC to SMB 3.0 share
# the script gets a hostname of the container
# checks to see if there is a folder that has the same name as the container
# if not it creates the folder
# then changes to the directory that has the same name as the container
# the loop will get all *.tif  & *.jpg files
# checks to see if there is a pdf/txt
# if they are missing one is produced
# the output file name is to remain the name as the image being ocr'd

Set-Location /OCR

$path = hostname
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

Set-Location /OCR/$path

# loop
# grab all tif's
# check to see if tif has pdf & text else make what is missing
$i=1
Do {

  foreach ($tif in get-ChildItem -Recurse *.tif,*.jpg) {
    Echo $tif.name
    $dir = Split-Path -Path $tif -Resolve -Parent
    $name = $dir+"/"+[System.IO.Path]::GetFileNameWithoutExtension("$tif")
    $namePDF = $name + ".pdf"
    $nameTXT = $name + ".txt"

    if (Test-Path $namePDF -PathType leaf) 
    {"File does Exist"
    $pdf = 0}
    else
    {"File does not exist"
    $pdf = 1
    }

    if (Test-Path $nameTXT -PathType leaf) 
    {"File does Exist"
    $txt = 0}
    else
    {"File does not exist"
    $txt = 1
    }

    if ($pdf -eq '1' -AND $txt -eq '1') {
    tesseract $tif $name -l eng --psm 4 txt pdf
    }

    if ($pdf -eq '0' -AND $txt -eq '1') {
    tesseract $tif $name -l eng --psm 4 txt
    }

    if ($pdf -eq '1' -AND $txt -eq '0') {
    tesseract $tif $name -l eng --psm 4 pdf
    }
}
}
While ($i -le 10)
 