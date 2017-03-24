[cmdletbinding()]
param([switch]$rebuildDependencies)
$here = if($myinvocation.MyCommand.Path ){split-path -Parent -path $MyInvocation.MyCommand.path}else{$pwd.path}
$repositoryRoot = Split-Path -parent -Path $here
$script_start = (get-date)



$module_Root = "$repositoryRoot\CHFSContainerImageManagement\CHFSContainerImageManagement.psd1"
import-module $module_Root -Force -Verbose:$false

Describe 'Creates base Images' {    
        Context 'builds the root image' {
            New-ContainerImage -imageType 'chfsrootcontainerimage' -force:$rebuildDependencies.IsPresent
        
            $json_containerImageInfo = docker image inspect chfsrootcontainerimage | ConvertFrom-Json            
            it 'builds the chfsrootcontainerimage' {            
                $json_containerImageInfo.architecture | should be 'amd64'
            }

            it 'copies the CHFSDeploy PSModule to C:\\' {
                $image_directory = $json_containerImageInfo.graphdriver.data.dir #difficult to do, considering windowsfilter is on the docker_host computer!
            }
        }

                
        Context 'IIS Image' {
            New-ContainerImage -imageType iis -force:$rebuildDependencies.IsPresent
            $json_containerImageInfo = docker image inspect iis | ConvertFrom-Json

            it 'exposes web ports' {
                $array_exposedPorts = $json_containerImageInfo.config.ExposedPorts | get-member -MemberType NoteProperty | select-object -ExpandProperty Name | Sort-Object
                $array_exposedPorts | select-object -first 1 | should be '443/tcp'
                $array_exposedPorts | select-object -Last 1 | should be '80/tcp'
            }
        }    
}

Describe 'Builds a WP Image'{ 
    Context 'Finds a build using criteria' {
        MOCK get-buildvariable {"$here\Tests.Content\WP"} -ParameterFilter {$name -eq 'buildDrops'} -ModuleName CHFSContainerImageManagement


    }

    Context 'Given a supplied WP build artifact'{
        $buildNumber = 'PrdM_WP_20170312.1'


        MOCK new-item -MockWith {get-item TestDrive:\} -ParameterFilter {$ItemType -eq 'Directory' -and $Path -eq $env:TEMP} #use the TestDrive:\ as the staging location
        MOCK find-BuildArtifacts -mockWith {Get-ChildItem -path "$here\Tests.Content\WP"} -ModuleName CHFSContainerImageManagement
        New-ContainerImage -imageType 'wp' -buildNumber $buildName -verbose

        It 'Copies the Build Artifacts to the staging directory' {
            Assert-MockCalled find-BuildArtifacts -Times 1 -ModuleName CHFSContainerImageManagement
            @('deploy.cmd','deploy-readme.txt','setParameters.xml','SourceManifest.xml','zip') | foreach-object{
                Test-Path -Path "TestDrive:\ky.Hbe.WorkerPortal.Web.$_" | Should be $true
            }
        }

        $json_containerimageInfo = docker image inspect wp | ConvertFrom-Json
        It 'Creates an image' {
            #checks the timestamp
            (get-date $json_containerimageInfo.created) -gt $script_start | should be $true
        }
    }
}