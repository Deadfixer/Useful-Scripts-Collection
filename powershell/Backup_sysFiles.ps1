#this script backup system inportants file.
  
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`

        [Security.Principal.WindowsBuiltInRole] "Administrator")) #test user is Administrator or not

    {

        Write-Warning "You are not Admin user on the system."

        Break

    }
    else
    {
                  
                   mkdir Backup #create folder Backup
                  #system importants files are
                  Copy-Item -Path C:\WINDOWS\system32\Ntoskrnl.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Hal.dll -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Csrss.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Smss.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Winlogon.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Services.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\Lsass.exe -Destination Backup\
                  Copy-Item -Path C:\WINDOWS\system32\drivers\etc -Destination Backup\ -Recurse -Force
                  
                  Write-Output "Ziping all files.................."
                  
                Start-Sleep -s 5 #delay 5 secends
                
                cd Backup #change directories
                #Archive as Zip of all files and folders
                $Directory = Get-Item .
                $ParentDirectory = Get-Item ..
                $ZipFN = $ParentDirectory.FullName + "\" + $Directory.Name + ".zip"

                if (test-path $ZipFN) {
                  echo "Zip file already exists at $ZipFileName"
                  cd ..
                  return 
                }

                set-content $ZipFN ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
                (dir $ZipFN).IsReadOnly = $false

                $ZipFile = (new-object -com shell.application).NameSpace($ZipFN)

                $ZipFile.CopyHere($Directory.FullName)
               
                
                cd ..
               
               Start-Sleep -s 5
               
               rmdir Backup -Recurse -Force #Remove directory Backup
               Write-Host "Backup Completed successfully.The file is saved in current execution path."
                
                       
        
            
    }
    
    Read-Host "Press any key to continue............"
