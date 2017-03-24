Function invoke-makeImage {
    [cmdletbinding()]
    param(
        [string]$context,
        [string]$type,
        [string[]]$tagInfo,
        [string]$buildNumber,
        [switch]$force
    )

    if($docker_host){$env:docker_host = $docker_host}
    $makeImage = @{'context'=$context}
    if($tagInfo){
        $flag_tag = foreach($t in $tagInfo){
            $repo = get-BuildVariable -name DockerRepository
            " -t $repo/$($type):$t"
        }
        $makeImage.add('tagInfo',$flag_tag)        
    }

    if($buildNumber){
        $makeImage.add('buildNumber',$buildNumber)
    }
    if($force.IsPresent){
        $makeImage.add('force',[switch]::Present)
    }

    . "$context\make-image.ps1" @makeImage
}