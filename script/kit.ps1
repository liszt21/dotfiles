$env:DOTFILES_HOME = "$env:HOME\Dotfiles"

function Set-Proxy {
    $proxy = "http://localhost:7890"
    $env:HTTP_PROXY = "$proxy"
    $env:HTTPS_PROXY = "$proxy"
}

function Remove-Proxy {
    Remove-Item Env:/HTTP_PROXY
    Remove-Item Env:/HTTPS_PROXY
}

Set-Alias -Name proxy-on -Value Set-Proxy
Set-Alias -Name proxy-off -Value Remove-Proxy
