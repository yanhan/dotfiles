# Install prerequisites for neovim

# From https://devblogs.microsoft.com/scripting/use-a-powershell-function-to-see-if-a-command-exists/
function Test-CommandExists {
  param (
    [string]$command
  )
  $oldPreference = $ErrorActionPreference
  $ErrorActionPreference = "stop"
  try {
    if (Get-Command $command) {
      return $true
    }
  } catch {
    return $false
  } finally {
    $ErrorActionPreference = $oldPreference
  }
}

choco install -y neovim git fzf

if (-Not (Test-CommandExists "node")) {
  choco install -y nodejs --version 16.17.0
}
