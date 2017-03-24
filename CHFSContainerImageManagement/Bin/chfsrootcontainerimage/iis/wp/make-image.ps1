[cmdletbinding()]
Param(
    [string]$context,
    [string]$flag_tag,
    [string]$buildNumber,
    [string]$logicalEnvironment = 'Dev1',    
    [switch]$force
)
$parentImage = 'iis'
if(!(docker image ls -q $parentImage)){
    . "..\make-image.ps1"
}
$dockerbuild = ""


<#
if($force.IsPresent){
    $dockerBuild = "$dockerBuild --no-cache=true"
}

$flag_BuildArg = ""
foreach($arg in ($buildArgs | select-object -ExpandProperty keys)){    
    $flag_BuildARg = "$flag_BuildArg --build-arg $arg='$($buildArgs.$arg)'"
}
$dockerbuild = "$dockerBuild $flag_BuildArg"
#>

#create the staging directory
$stagingDirectory = New-Item -Path $env:TEMP -Name ([guid]::NewGuid() | select-object -ExpandProperty guid) -ItemType Directory

#copy items from the context to the staging directory
Get-ChildItem -path $context | Copy-Item -Destination $stagingDirectory.fullname

#copy the build items
find-BuildArtifacts -buildNumber $buildNumber -type Package | Copy-Item -Destination $stagingDirectory.FullName

#build the image
$context_Directory = "$(split-path -parent $stagingDirectory.fullname)\$($stagingDirectory.name)"
docker build --build-arg logicalEnvironment=$logicalEnvironment --build-arg track=wp -t wp $context_Directory | foreach-object {write-verbose -Message $_}