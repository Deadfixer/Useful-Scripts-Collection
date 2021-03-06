#this script backup system inportants file 

                    
                 
                  
                   mkdir Backup
                  
                  ## Set profile root path based on OS.
                   $version = gwmi win32_operatingsystem | select version
                   $version = $version.version.substring(0,4)
                    
                    if ($version -ge "6.0."){
                     [STRING]$source = "C:\Users\"
                    }else{
                     [STRING]$source = "C:\Documents and Settings\"
                    }
                  #importants directories
                  $Name = $env:username
                  $source +=$Name
                  $src1=$source+"\Desktop\"
                  $src2=$source+"\Pictures"
                  $src3=$source+"\Music"
                  $src4=$source+"\Videos"
                  $src5=$source+"\Documents"
                  $src6 =$source+"\Downloads"
                 Write-Output " Coping all files......... "
                 
                 #end section
                  
                #copy files.
                  Copy-Item -Path $src1 -Destination Backup\ -Recurse -Force
                  Copy-Item -Path $src2 -Destination Backup\ -Recurse -Force
                  Copy-Item -Path $src3 -Destination Backup\ -Recurse -Force
                  Copy-Item -Path $src4 -Destination Backup\ -Recurse -Force
                  Copy-Item -Path $src5 -Destination Backup\ -Recurse -Force
                  Copy-Item -Path $src6 -Destination Backup\ -Recurse -Force
                  
                 
                Write-Output " Archiving all files......... "
                
                Start-Sleep -s 5
                
                cd Backup #change directory
                
                #archiving files........
                
                $Directory = Get-Item .
                $ParentDirectory = Get-Item ..
                $ZipFileName = $ParentDirectory.FullName + "\" + $Directory.Name + ".zip"

                if (test-path $ZipFileName) {
                  echo "Zip file already exists at $ZipFileName"
                  cd ..
                  return 
                }

                set-content $ZipFileName ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
                (dir $ZipFileName).IsReadOnly = $false

                $ZipFile = (new-object -com shell.application).NameSpace($ZipFileName)

                $ZipFile.CopyHere($Directory.FullName)
               
                
                cd ..
               
               Start-Sleep -s 5
               rmdir Backup -Recurse -Force
               Write-Host "All user files are archived successfully. Archive file is saved on current execution folder."
                
                       
        
        Read-Host "Press any key to continue.........."     
