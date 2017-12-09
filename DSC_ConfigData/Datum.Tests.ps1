$datumConfig = Get-Content -raw $PSScriptRoot\datum.yml | ConvertFrom-Yaml

Describe "Datum" {
    Context "DEV/SRV01/Role1" {
        BeforeAll {
            $node = [PSCustomObject]@{
                Environment = "DEV"
                Name        = "SRV01"
                Role        = "Role1"
            }
            $datum = New-DatumStructure  -Structure $datumConfig
        }

        It "Description" {
            Resolve-Datum -searchPaths $datumConfig.ResolutionPrecedence -DatumStructure $datum -PropertyPath 'Description' -Node $node | Should Be 'This is the DEV environment'
        }

        It "ExampleProperty1" {
            Resolve-Datum -searchPaths $datumConfig.ResolutionPrecedence -DatumStructure $datum -PropertyPath 'ExampleProperty1' -Node $node | Should Be 'From Node'
        }
    }
}