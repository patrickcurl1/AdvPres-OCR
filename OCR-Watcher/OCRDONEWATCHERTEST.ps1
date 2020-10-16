
$server = 'SQL02'
$database = 'DISCO'
$destpath = '\\hvcro03\Data\Complete\'

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
    $path = '\\hvcro03\OCR\Minion22-c\'
    $tifs = [System.IO.Directory]::GetFiles("$path", "*.tif", 1).Count
    $pdfs = [System.IO.Directory]::GetFiles("$path", "*.pdf", 1).Count
    $txts = [System.IO.Directory]::GetFiles("$path", "*.txt", 1).Count

    

    if ($tifs=$pdfs)
    {
        if ($tifs = $txts)
        {
       
        
            $connection.Open()
            $ucommand = $connection.CreateCommand()
            $update = 'exec OCRDONE "' + "$path" +'"'

            $ucommand.CommandText = $update
            robocopy $path $destPath *.tif *.txt *.pdf *.xml /e /mt:128 /mov
           $update
            $ucommand.ExecuteReader()
            Remove-Item –path $path –recurse -exclude *.ps1 -force
        }
    }
    $connection.Close()
    }