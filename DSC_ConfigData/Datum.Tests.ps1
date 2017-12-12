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

        It "has AllNodes.SRV01" {
            $datum.AllNodes.SRV01 | Should Not Be Null
        }

        It "has AllNodes.SRV01.Description" {
            $datum.AllNodes.DEV.SRV01.Description | Should Be 'Dev version of SRV01'
        }

        It "Resolves Description" {
            Resolve-Datum -searchPaths $datumConfig.ResolutionPrecedence -DatumStructure $datum -PropertyPath 'Description' -Node $node | Should Be 'Dev version of SRV01'
        }

        It "Resolves ExampleProperty1" {
            Resolve-Datum -searchPaths $datumConfig.ResolutionPrecedence -DatumStructure $datum -PropertyPath 'ExampleProperty1' -Node $node | Should Be 'From Node'
        }
    }
}