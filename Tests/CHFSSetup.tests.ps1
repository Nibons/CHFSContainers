$here = split-path -Parent -path $MyInvocation.MyCommand.path
$repositoryRoot = Split-Path -parent -Path $here

$module_Root = "$repositoryRoot\CHFSSetup\CHFSSetup.psd1"
import-module $module_Root -Force

Describe 'CHFSSetup' {        
        Context 'invoke-xmlPreProcess' {
            $infile = get-item -path "$here\Tests.Content\WP\Ky.Hbe.WorkerPortal.Web.SetParameters.xml" | Copy-Item -Destination TestDrive:\ -PassThru | select-object -ExpandProperty Fullname
            $settingsSpreadsheet = "$here\Tests.Content\SettingsSpreadsheet.xml"
            
            $invokeXmlPreProcess = @{
                infile =$inFile
                logicalEnvironment='Prod'
                settingsSpreadsheet=$settingsSpreadsheet
                outfile="$(split-path -path $infile -parent)\Web.OutParameters.xml"
            }
            invoke-xmlPreProcess @invokexmlPreProcess -Verbose

            [xml]$post_data = get-content -path TestDrive:\Web.OutParameters.xml
            It 'creates the outfile'{
                Test-Path -path "TestDrive:\Web.OutParameters.xml" | Should be $true
            }
        }
        
        Context 'invoke-CHFSWebSetup' {

        }

        Context 'msDeploy' {

        }
}