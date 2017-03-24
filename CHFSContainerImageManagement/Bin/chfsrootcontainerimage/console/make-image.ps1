[cmdletbinding()]
Param(
    [string]$flag_tag,
    [string]$buildNumber, #irrelevant to this type of image
    [switch]$force
)
$parentImage = 'iis'
if(!(docker image ls $parentImage -q)){
    . "..\make-image.ps1"
}
if($force.IsPresent){
    $flag_rebuild = "--no-cache=true"
}
docker build $flag_rebuild $flag_tag -t wp . | foreach-object {write-verbose -message $_}