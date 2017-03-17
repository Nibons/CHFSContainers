$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

Describe 'invokes pester tests' {
    Context 'it will pass'{
        docker system info | 2>&1
        $images = docker image ls -q microsoft/windowsservercore 
        it 'test client has the win2016 image we need'{
            $images | should be 'b4713e4d8bab'
        }        
    }    
}