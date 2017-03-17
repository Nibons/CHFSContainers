$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

Describe 'invokes pester tests' {
    Context 'it will pass'{
        $true | should be $true    
    }    
    Context 'it will fail' {
        $false | should be $true
    }

}