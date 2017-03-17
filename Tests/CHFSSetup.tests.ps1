$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSSetup"
import-module $module_Root -Force

Describe 'CHFSSetup' {        
        
}