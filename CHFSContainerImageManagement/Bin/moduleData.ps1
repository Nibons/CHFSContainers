@{
    buildDrops = "\\hfsne121-037013\BuildDrops"
    buildConfiguration = 'Release'
    guid = $([guid]::NewGuid() | select-object -ExpandProperty guid)
    DockerRepository = 'USLOUCHAERTZEN1:5000'
    Docker_host = if(test-connection -computername 'kyhbe-win2016-2' -Count 1 -Quiet){$env:docker_host = 'tcp://kyhbe-win2016-2:2375';$env:docker_host }
                    else{$null}

    #package search variables
    Package = @{
        SearchPath = "{buildDrops}\{branch}\{branch}_{track}\{branch}_{track}_{id}\*.zip"
        SearchWhereScriptblock = {
            $buildConfiguration = (get-variable -name BuildConfiguration)
            $currentObject.fullname -match $buildConfiguration -and 
            $currentObject.fullname -match 'Package' -and
            (test-path -path $currentObject.fullname.toLower().replace('zip','deploy.cmd'))
        } 
    }
    
    ConsoleApp = @{
        SearchPath = "{buildDrops}\{branch}\{branch}_{track}\{branch}_{track}_{id}\*.cmd"
        SearchWhereScriptblock = {}
    }
}