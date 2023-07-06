function Test-Command($command) {
    $ErrorActionPreference = 'stop'
    try {
        Get-Command $command | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Install-Scoop() {
    Write-Output "Setup Scoop"

    if (!$ENV:HOME) {
        $ENV:HOME = "C:\Users\$ENV:USERNAME"
        [environment]::setEnvironmentVariable('HOME', $ENV:HOME, 'User')
        Write-Output "Set ENV:HOME = $ENV:HOME"
    }

    if (!$ENV:SCOOP) {
        $ENV:SCOOP = "$ENV:HOME\Scoop"
        [environment]::setEnvironmentVariable('SCOOP', $ENV:SCOOP, 'User')
        Write-Output "Set ENV:SCOOP = $ENV:SCOOP"
    }

    if (!(Test-Command "scoop")) {
        Write-Output "Installing Scoop to $ENV:SCOOP"
        Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
        scoop update
    }

    scoop install git sudo ln
    Write-Output "Add buckets"
    scoop bucket add extras
    scoop bucket add java
    scoop bucket add nerd-fonts
    scoop bucket add nonportable
    scoop bucket add poocs https://github.com/Liszt21/Poocs
    scoop bucket add dorado https://github.com/chawyehsu/dorado
    scoop bucket add scoopet https://github.com/ivaquero/scoopet
    scoop bucket add scoop-clojure https://github.com/littleli/scoop-clojure

    scoop install charm-gum
}

function Install-Roswell() {
    Write-Output "Install roswell"
    scoop install roswell
    ros setup
    ros install liszt21/aliya
    ros install likit clish ust
}

function Install-Basic() {
    winget install Rime.Weasel
    winget install Tencent.QQ
    winget install Yuanli.uTools
    winget install Google.Chrome
    winget install Tencent.WeChat
    winget install Thunder.Thunder
    winget install ZeroTier.ZeroTierOne
    winget install Fndroid.ClashForWindows

    # # Tools
    # winget install Alibaba.aDrive
    # winget install Alibaba.DingTalk
    winget install NetEase.MailMaster
    winget install Baidu.BaiduNetdisk

    # # Amuse
    # winget install iQIYI.iQIYI
    winget install Daum.PotPlayer
    # winget install Douyu.DouyuLive
    # winget install Bilibili.Bilibili
    winget install NetEase.CloudMusic

    # Study
    scoop install logseq

    sudo scoop install FiraCode LXGWWenKai SarasaGothic-SC SourceCodePro-NF

    # Develop
    sudo winget install Anaconda.Anaconda3
    winget install CoreyButler.NVMforWindows
    winget install Microsoft.VisualStudioCode

    scoop install vim neovim ffmpeg mpv yt-dlp starship vcredist2022
    sudo scoop install icaros-np
}

function setup() {
    Install-Scoop
    Install-Roswell
    Install-Basic
}

setup