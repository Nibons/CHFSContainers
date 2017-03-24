Function get-BuildVariable {    
    Param(
        [string]$Name = 'Package.SearchPath'
    )

    $path_ModuleData = "$(split-path -parent $psscriptroot)\Bin\moduleData.ps1"
    $dataSource = . $path_ModuleData
    
    #use the name to search through the data file
    $split_name = $name.split('.')
    $currentItem=$dataSource
    for($i=0; $i -lt $split_name.Count;$i ++){
        $currentKey = $split_Name[$i]
        $currentItem = $currentItem."$currentKey"
    }

    Write-Output $currentItem
}