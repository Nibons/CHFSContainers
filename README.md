# This is the root PSModule for managing Docker in the KYHBE environment.

## Notes:
### there are a few NTFS links used in this process:
Link | Points to | Type
------ | --------- | ----
/CHFSContainerImageManagement/Bin/chfsrootcontainerimage/CHFSSetup | /CHFSSetup | directory link
/CHFSContainerImageManagement/Bin/chfsrootcontainerimage/iis/wp/WindowsFeatureSources.tar.gz | /CHFSContainerImageManagement/lib/WindowsFeatureSources.tar.gz | file link


## CHFSContainerImageManagement PSModule:
### The module file structure follows this pattern:
    /bin ## non-powershell script support objects
        /chfsrootcontainerimage ##used to hold all dockerfiles for the chfs container images
            -dockerfile ##describes the root container image
            -.dockerignore ##tells the docker engine which files/folders to ignore on BUILD
            /iis ##used to hold the dockerfiles for all images dependent on iis to function
                -dockerfile ##describes the root-iis image for all dependent functions
                /wp ##used to create the worker portal base image (this is an example to follow)
                    -dockerfile ##describes the worker portal image
                    -WindowsFeatureSources.tar.gz ##the worker portal image requires the use of additional windows features, beyond what iis needs
            /console ##used to hold all dockerfiles for images that follow a console methodology (ie, batch)
            /sql ##used to hold all dockerfiles for images based on mssql and the like
            /CHFSSetup ##a directory link to the CHFSSetup module, which is used to 'deploy' CHFS artifacts
    /en-us ##used to give help documents
    /Private ##functions available for the module to use internally (not imported with import-module)
    /Public ##functions available for end user use (imported with import-module)
    /lib ##used for externally-provided resources
    -CHFSContainerImageManagement.psd1 ##used to assist in defining the CHFSContainerImageManagement PSModule
    -CHFSContainerImageManagement.psm1 ##used to load all functions in the CHFSContainerImageManagement PSModule