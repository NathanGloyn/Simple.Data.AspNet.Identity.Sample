param ([string]$w)

function LoopThroughFolders($path)
{
	foreach($item in Get-ChildItem $path)
	{
		if (Test-Path $item.fullname -pathType container) 
		{
			LoopThroughFolders $item.fullname
		}
		
		NameSpaceReplacement $item.fullname
	}
}

function NameSpaceReplacement($fileDirectory)
{
	foreach($file in Get-ChildItem $fileDirectory -Include *.pp)
	{
		ReplaceText $file.fullname
	}
}

function ReplaceText($filePath)
{
	write-host $filePath
	(Get-Content $filePath) | ForEach-Object { $_ -replace $w, '$rootnamespace$' } | Set-Content $filePath
}

LoopThroughFolders ".\Nuget"