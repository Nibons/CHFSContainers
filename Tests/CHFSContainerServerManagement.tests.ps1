$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

Describe 'invokes pester tests' {
    Context 'running in pester' {
        $true | should be $true
    }
}