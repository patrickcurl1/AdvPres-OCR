

$path = hostname
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

# loop
# grab all tif's
# check to see if tif has pdf & text else make what is missing
$i=1
Do {

  foreach ($tif in get-ChildItem -Recurse *.tif) {
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
 