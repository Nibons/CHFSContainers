$here = split-path -path $MyInvocation.MyCommand.path -parent
$sut = (split-path -path $MyInvocation.MyCommand.path -Leaf).replace('.tests','')


$dockerfileTest = @"
FROM microsoft/nanoserver
SHELL ["powershell.exe","-noprofile -command"]
ARGS buildArg1 buildArg2
CMD write-output "BuildArg1:$($env:buildArg1)`nBuildArg2:$($env:buildArg2)"
"@ 
Describe 'build-dockerImage'{
    $contextDirectory = new-item -path TestDrive:\ -name Context -ItemType Directory
    $dockerfileTest | Out-File -FilePath "$($contextDirectory.FullName)\dockerfile" -Encoding utf8
    . "$here\$sut"
    Context 'Builds a basic image, with host entry added'{
        build-dockerimage -dockerhost 'tcp://kyhbe-win2016-2:2375' -verbose
    }

    Context '2 Build Args' {
        
    }
}