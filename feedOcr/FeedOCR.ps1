
$server = 'SQL02'
$database = 'DISCO'
$Filepath = ''
$OCRPath = ''
$jobticket = ''

#Check DB for OCR Machines working
$connection = New-Object System.Data.SQLClient.SQLConnection
$connection.ConnectionString = "server='tcp:$server';database='$database';trusted_connection=true"
$connection.Open()
$qcommand = $connection.CreateCommand()
$qcommand.CommandText = 'exec ocrtodo'
$result = $qcommand.ExecuteReader()




#Build data table containing OCR machines working file paths
$table = New-Object System.Data.DataTable
$table.Load($result)

#Perform Robocopy action on all PDFand TXT files in source file paths
foreach($row in $table)
    {
    $qcommand2 = $connection.CreateCommand()
    $qcommand2.CommandText = 'exec OCRMACHINEIDLE'
    $result2 = $qcommand2.ExecuteReader()




    #Build data table containing OCR machines working file paths
    $table2 = New-Object System.Data.DataTable
    $table2.Load($result2)
    if ($row2.OCRPath -ne "None")
    {
        foreach($row2 in $table2){
        $ocrmachine = $row2.OCRPath
    
    
    
        $jobticket = $row.JobTicket
        $OCRPath = $row.OCRPATH
        $Foldername = $row.DateFolder
        $tifs = 0
        $jpgs = 0
        $tifs = [System.IO.Directory]::GetFiles("$ocrpath", "*.tif", 1).Count
        $jpgs = [System.IO.Directory]::GetFiles("$ocrpath", "*.jpg", 1).Count

        if ($jpgs -eq 0)
        {
            $sql = "exec OCRASSIGNED '$ocrpath', $tifs, '$ocrmachine'"
        }
        else
        {
            $sql = "exec OCRASSIGNED '$ocrpath', $jpgs, '$ocrmachine'"
        }
        $ocrmachinepath = "$ocrmachine"  +"$jobticket"+"\"+"$foldername"

        $ocrpath
        $tifs
        $ocrmachine
        $ocrmachinepath
        $sql

        robocopy $OCRPath $ocrmachinepath  *.tif *.txt *.pdf *.xml *.jpg /e /mt:128

        $desttifs = [System.IO.Directory]::GetFiles("$ocrpath", "*.tif", 1).Count
        $destjpgs = [System.IO.Directory]::GetFiles("$ocrpath", "*.jpg", 1).Count 
        if ($destjpgs -eq 0) {$destjpgs = -1}
        if ($desttifs -eq 0) {$desttifs = -1}
        $desttifs
        $destjpgs

        ($tif -eq $desttifs)
        { 
            Remove-Item –path $ocrpath –recurse -exclude *.ps1 -force
            $tifmessage = 'Tifs copied'
            $tifmessage
        }
         if ($jpgs -eq $destjpgs){Remove-Item –path $ocrpath –recurse -exclude *.ps1 -force
         $jpgmessage = 'JPGs copied'
        $jpgmessage}

     
  
   
        $ucommand = $connection.CreateCommand()
        $ucommand.CommandText = $sql
        $ucommand.ExecuteNonQuery()
    }

    }

   
    }