Function new-containerimage {
    [cmdletbinding()]
    Param(
        [string]$imagetype = 'chfsrootcontainerimage',
        [string]$buildNumber,
        [string[]]$tagInfo,
        [string]$docker_host = (get-buildvariable -name docker_host),
        [switch]$force
    )
    Begin{
        function getcontextpath($imagetype){
            Get-ChildItem -path "$PSScriptRoot\..\Bin" -Recurse | 
                where-object -property Name -eq $imagetype |
                select-object -ExpandProperty Fullname
        }
    }
    Process {
        foreach($type in $imagetype){
            $contextPath = getcontextpath -imageType $type
            $invokeMakeImage = @{
                context = $contextPath 
                type = $type                 
            }
            if($tagInfo){
                $invokeMakeImage.add('tagInfo',$tagInfo)
            }
            if($force.IsPresent){
                $invokeMakeImage.add('force',[switch]::Present)
            }
            invoke-makeimage @invokeMakeImage
        }
    }
    End{
        if($buildJob){
            $buildJob | Wait-Job
        }
    }
}