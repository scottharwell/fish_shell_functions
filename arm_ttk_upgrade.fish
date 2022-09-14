#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `arm_ttk_upgrade` functions will be available from your shell.

function arm_ttk_upgrade
    echo "👏🏻 Fetching latest arm-ttk build"
    curl -s -L https://api.github.com/repos/Azure/arm-ttk/releases/latest | grep "browser_download_url" | cut -d : -f 2,3 | tr -d \" | tr -d "[:blank:]" | wget -O /tmp/arm-ttk.zip -qi -

    echo "✅ Unzipping arm-ttk archive to tmp directory"
    unzip -o -q /tmp/arm-ttk.zip -d /tmp/arm-ttk

    echo "✅ Removing old arm-ttk version"
    rm -rf $HOME/.local/share/powershell/Modules/arm-ttk

    echo "✅ Moving new arm-ttk version to Powershell modules folder"
    mv /tmp/arm-ttk/arm-ttk $HOME/.local/share/powershell/Modules/

    set_color green
    echo "🏁 Finished!"
end
