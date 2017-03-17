$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSContainerServerManagement"
import-module $module_Root -Force

Describe 'ServerImages' {
        $windowsServerCore = docker image ls -q microsoft/windowsservercore 
        it 'has microsoft/windowsserver core image'{
            $windowsServerCore | should not be $null
        }            

        $nanoServer = docker image ls -q microsoft/nanoserver
        it 'has microsoft/nanoserver image' {
            $nanoServer | should not be $null
        }
}