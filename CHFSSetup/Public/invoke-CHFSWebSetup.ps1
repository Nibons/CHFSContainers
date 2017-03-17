#the below function is run within the container, and hosts the main process for setting up all IIS resources
Function invoke-CHFSWebSetup {
    [cmdletbinding()]
    Param(
        [string]$logicalEnvironment,
        [string]$track #this tells us what kind of site/application we are looking to install
    )
    Begin{
        import-module WebAdministration
    }
    Process{

    }
    End{
        
    }

}