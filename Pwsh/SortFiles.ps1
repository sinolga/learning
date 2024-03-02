param(
    [Parameter(Mandatory=$true)][string]$sourcePath,
    [Parameter(Mandatory=$true)][string]$targetPath
    )

function Process-By-Name
{
    Get-ChildItem $sourcePath -File -Recurse | ForEach-Object -Process  {
        Write-Output "Processing" $_.Name

        $childPathName = "{0}.{1}" -f $_.Name.Substring(0, 4), $_.Name.Substring(4, 2)
        $copyPathName = Join-Path -Path $targetPath -childPath $childPathName
        New-FolderIfNecessary $copyPathName

        $unsortedPath = Join-Path -Path $targetPath -childPath "Unsorted"
        New-FolderIfNecessary $unsortedPath

        $fullPath = Join-Path -Path $copyPathName -ChildPath $_.Name
        if (-not (Test-Path -Path $fullPath -PathType Leaf)) {
            Copy-Item $_ -Destination $copyPathName
            Write-Output "Sorted successfully"
        }
        else {
            Copy-Item $_ -Destination $unsortedPath
            Write-Output "Put to unsorted"
        }
    }
}


function New-FolderIfNecessary{
    param (
        [string] $fullPath
    )
    if (-not (Test-Path -Path $fullPath -PathType Container)) {
            New-Item -Path $fullPath -ItemType Directory -Force
    }
}

Process-By-Name