$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue | where-object -property Name -notmatch 'tests')
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue  | where-object -property Name -notmatch 'tests')

foreach($import in @($Public + $Private))
{
    try
    {
        . $import.fullname
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

#set the docker host to our docker build server
$env:docker_host = (get-buildvariable -name 'docker_host')

Export-ModuleMember -Function $Public.Basename