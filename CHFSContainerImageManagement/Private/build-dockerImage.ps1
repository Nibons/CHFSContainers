#this function is a wrapper for 'docker build'
Function build-dockerImage {
[cmdletbinding()]
Param(
    [validatescript({test-path -path $_})]
    [string]$context = '.',

    [string]$file,

    [hashtable]$buildArg,
    [string[]]$tag,
    [string[]]$label,

    [string]$network = 'default',
    [validateset('hyperv','process','default')]
    [string]$isolation = 'default',
    [alias('host','H')]
    [string]$dockerHost = $(get-buildVariable -name docker_host),
    [validateset('debug','info','warn','fatal')]
    [string]$logLevel='info',

    [Alias('q')]
    [switch]$quiet,
    [switch]$compress,
    [switch]$forceRemove,
    [switch]$noCache,
    [switch]$squash
)
Begin{
    push-location
}
Process {
#region set switch-based Flags
    $fDebug=$fQuiet=$fCompress=$fForceRemove=$fNoCache=$fSquash="" #set the flags to a null string
    if($quiet.ispresent){
        $fQuiet="--quiet"
    }
    if($compress.IsPresent){
        $fCompress="--compress"
    }
    if($forceRemove.IsPresent){
        $fForceRemove="--force-rm"
    }
    if($noCache.IsPresent){
        $fNoCache="--no-cache"
    }
    if($squash.IsPresent){
        $fSquash="--squash"
    }
    
#endregion

#region set single-string flags
    <#$fIsolation="--isolation $isolation"
    $fNetwork="--network $network"#>
    $fLogLevel="--log-level '$logLevel'"
    if($file){
        $fFile="--file $file"
    }

    $fHost = ""
    if(![string]::IsNullOrEmpty($dockerHost)){
        $fHost = "-h '$dockerHost'"
    }

#endregion

#region set multi-valued flags
    $fBuildArg=""
    if($buildArg){
        $fBuildArg="--build-args"
        foreach($key in $buildArg.keys){
            $fBuildArg="$fBuildArg $key=$($buildArg.$key)"
        }
    }

    $fTag=""
    if($tag){
        foreach($t in $tag){
            $fTag="-t $t "
        }
    }

    $fLabel=""
    if($label){
        $fLabel="--label"
        foreach($l in $label){
            $fLabel="$fLabel $l"
        }
    }
#endregion
write-verbose -message "Command: docker $fHost $fLogLevel build $fQuiet $fCompress $fForceRemove $fNoCache $fSquash $fIsolation $fNetwork $fBuildArg $fTag $fLabel $fFile $context"
if($context -ne '.'){set-location -path $context}
docker build $fQuiet $fCompress $fForceRemove $fNoCache $fSquash $fIsolation $fNetwork $fBuildArg $fTag $fLabel $fFile . |
    foreach-object {write-verbose $_}

}
End {
    pop-location
}
}