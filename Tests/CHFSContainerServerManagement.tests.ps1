$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

Describe 'invokes pester tests' {
    Context 'it will pass'{
        it 'passes the test'{
            $true | should be $true
        }        
    }    
}