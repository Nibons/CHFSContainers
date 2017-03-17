Function invoke-xmlPreprocess {
    [cmdletbinding()]
    Param(
        [parameter(mandatory)]
        [string[]]$inFile,

        [parameter(mandatory)]
        [string]$logicalenvironment,

        [parameter(mandatory)]
        [string]$settingsSpreadsheet,

        [string]$outfile = 'NULL',
        
        [switch]$validate = [switch]::present,
        [switch]$quiet = [switch]::present,
        [switch]$noLogo = [switch]::present
    )
    Begin{
        if($validate.IsPresent){
            $flag_validate = "/validate"
        }
        if($quiet.IsPresent){
            $flag_quiet = "/quiet"
        }
        if($noLogo.IsPresent){
            $flag_noLogo = "/noLogo"
        }
    }
    Process{
        foreach($f in $inFile){      
            if($outfile -eq 'NULL'){
                $outfile = $f
            }
            write-verbose "Running xmlPreprocess on $f as $logicalenvironment using $settingsSpreadsheet"      
            & "$psscriptroot\xmlPreprocess.exe" /input:$f /spreadsheet:$settingsSpreadsheet /environment:$logicalenvironment /output:$outfile $flag_validate $flag_quiet $flag_noLogo

            if($outfile -eq $inFile){
                $outfile = 'NULL'
            }
        }
    }
}