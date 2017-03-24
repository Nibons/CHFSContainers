$here = split-path -path $MyInvocation.MyCommand.path -parent
$sut = (split-path -path $MyInvocation.MyCommand.path -Leaf).replace('.tests','')

. "$here\$sut"

Describe "get-buildVariable" {
    Context "Read data correctly" {
        It 'Reads data from the data file correctly' {
            get-buildvariable -name 'Package.SearchPath' | should be "{buildDrops}\{branch}\{branch}_{track}\{branch}_{track}_{id}\*.zip"
        }
    }

    Context "can be overridden correctly" {
        $newString = "correctTest"
        MOCK get-buildvariable {$newString} -ParameterFilter {$name -eq 'test2'}
        it 'can be MOCKED' {
            get-buildVariable -name 'test2' | SHOULD be $newString
        }
    }
}