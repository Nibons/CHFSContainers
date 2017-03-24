[cmdletbinding()]
Param(
    [string]$context,
    [string]$flag_tag,
    [string]$buildNumber, #irrelevant to this type of image
    [switch]$force
)
if($force.IsPresent){
    $flag_rebuild = "--no-cache=true"
}
docker build $flag_rebuild $flag_tag -t chfsrootcontainerimage $context | foreach-object {write-verbose -message $_}