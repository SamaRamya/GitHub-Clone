Function Deploy-Files-s3bucket {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$Files
	)
	
	begin {
        Write-Host "Deployment for Python files into s3 bucket begins"
    }
    process {
        try {
		
	        #uploads  All Python Files into s3bucket
			
			#Uploads only the modified files into s3 bucket
			aws s3 cp ./$i s3://$S3Bucket/	
			
			
		}
        catch {
            $exceptionMessage = $Error[0].Exception
            Write-Error -Message $exceptionMessage -ErrorAction Stop
            exit $LASTEXITCODE
        }
    }
}

$commit_ID = $(git log --format="%H" -n 1) 
$files = (git log -m -1 --name-only --pretty="" $commit_ID)
	
foreach($i in $Files) { 
	[System.IO.Path]::GetExtension($i)
       if ([System.IO.Path]::GetExtension($i) -contains '.py') {
	      Deploy-Files-s3bucket -Files $Files  -ErrorAction Stop
	   }
	   else {
	      Write-Error -Message "Supported FileExtension Should be .py" -ErrorAction Stop
          exit $LASTEXITCODE
	   }
}
