Function find-buildArtifacts{
    [cmdletbinding()]
    Param(        
        [string]$buildNumber,

        [validateset('package','consoleapp','rules')]
        [string]$type
    )
    Begin {
        $buildArgs = $buildNumber.split('_')
        $branch = $buildArgs[0]
        $track = $buildArgs[1]
        $id = $buildArgs[2]

        $buildDrops = get-buildVariable -name 'buildDrops'
    }
    Process{
        #find packages
        if($type -eq 'package'){
            $searchPath = (get-buildVariable -name Package.SearchPath).replace('{buildDrops}',$buildDrops).replace('{branch}',$branch).replace('track',$track).replace('{id}',$id)
            $package = Get-ChildItem -path $searchPath -recurse |
                where-object -FilterScript $(get-buildVariable -name Package.SearchWhereScriptblock) 
            $packageDirectory = split-path -path $package -Parent
            Get-ChildItem -Path $packageDirectory
        }
    }

}
