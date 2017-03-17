$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

<<<<<<< HEAD
Describe 'invokes pester tests, passing' {    
        $true | should be $true    
=======
Describe 'invokes pester tests' {
    Context 'running in pester' {
        $true | should be $true
    }
>>>>>>> 9f4906257269de44b9c2af03284a26e16457c686
}