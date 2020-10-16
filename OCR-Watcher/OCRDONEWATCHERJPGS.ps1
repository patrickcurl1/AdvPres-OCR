﻿
$server = 'SQL02'
$database = 'DISCO'
$destPath = '\\hvcro02\Data\OCRComplete'

#Check DB for OCR Machines working
$connection = New-Object System.Data.SQLClient.SQLConnection
$connection.ConnectionString = "server='tcp:$server';database='$database';trusted_connection=true"
$connection.Open()
$qcommand = $connection.CreateCommand()
$qcommand.CommandText = 'exec ocrworking'
$result = $qcommand.ExecuteReader()




#Build data table containing OCR machines working file paths
$table = New-Object System.Data.DataTable
$table.Load($result)

#Perform Robocopy action on all PDFand TXT files in source file paths
foreach($row in $table)
    {
    
    $path = $row.OCRPath
  
    $jpgs = [System.IO.Directory]::GetFiles("$path", "*.jpg", 1).Count
    $pdfs = [System.IO.Directory]::GetFiles("$path", "*.pdf", 1).Count
    $txts = [System.IO.Directory]::GetFiles("$path", "*.txt", 1).Count

    

     if ($jpgs -eq $pdfs)
    {
        if ($jpgs -eq $txts)
        {
       
        
            $connection.Close()
            $connection.Open()
            $ucommand = $connection.CreateCommand()
            $update = 'exec OCRDONE "' + "$path" +'"'

            $ucommand.CommandText = $update
            robocopy $path $destPath *.jpg *.txt *.pdf *.xml /e /mt:128
           
            $ucommand.ExecuteReader()
            Remove-Item –path $path –recurse -exclude *.ps1 -force
        }
    }
    $jpgs=0
    $pdfs=0
    $txts=0
    $connection.Close()
    }