$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerImageManagement"
import-module $module_Root -Force

Describe 'invokes pester tests, failing' {    
        $false | should be $true    
}