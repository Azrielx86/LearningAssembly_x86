Get-ChildItem *.obj, *.exe, *.map | foreach { Remove-Item -Path $_.FullName; echo "Removed $_" }
