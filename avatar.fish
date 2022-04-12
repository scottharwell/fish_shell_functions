#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `avatar` functions will be available from your shell.

function avatar
    ###################################################
    # Function Definitions
    ###################################################

    function avatar_error -d "Print error and exit script" --argument e
        set_color red
        echo "❗️ $e"
        set_color white
    end

    function avatar_help
        echo "usage: avatar [-h | --help] [-e | --email] [-s | --size] [-d | --directory] [-n | --img] [--gravatar] [--url_only] [-v | --verbose]"
        echo ""
        echo "  Uses the Libravatar service to download an image file for the email provided."
        echo ""
        echo "Options:"
        echo "  -h/--help       Show this message and exit."
        echo "  -e/--email      Email address used to retrieve an avatar."
        echo "  -s/--size       The size of the avatar image in pixels. Defaults to 100."
        echo "  -d/--directory  Change the output directory from the current directory to the provided path."
        echo "  -n/--img        The output name of the image. Defaults to the email address provided with the .png suffix."
        echo "  --gravatar      Uses the Gravatar service instead of Libravatar."
        echo "  --url_only      Outputs the URL for the avatar but does not download the avatar."
        echo "  -v/--verbose    Verbose output during processing."
    end

    ###################################################
    # Argument Parsing
    ###################################################

    # For help with options https://fishshell.com/docs/current/cmds/fish_opt.html#cmd-fish-opt
    set -l options (fish_opt -s h -l help)
    set options $options (fish_opt -s e -l email --required-val)
    set options $options (fish_opt -s s -l size --required-val)
    set options $options (fish_opt -s d -l directory --required-val)
    set options $options (fish_opt -s n -l img_name --required-val)
    set options $options (fish_opt -s g -l gravatar --long-only)
    set options $options (fish_opt -s u -l url_only --long-only)
    set options $options (fish_opt -s v -l verbose)

    # For help with argparse https://fishshell.com/docs/current/cmds/argparse.html
    argparse --name avatar $options -- $argv

    if [ $status != 0 ]
        avatar_error "Could not parse flags. Ensure that you are using proper variables."
        return 1
    end

    if set -q _flag_help
        avatar_help
        return 1
    end

    if not set -q _flag_email
        avatar_error "Email address required."
        return 1
    end

    if not set -q _flag_size
        set -g _flag_size 100
    end

    set -g dir (pwd)
    if set -q _flag_directory
        set -g dir $_flag_directory
    end

    set -g img_name "$_flag_email.png"
    if set -q _flag_img_name
        set -g img_name $_flag_img_name
    end

    ###################################################
    # The business end
    ###################################################

    if set -q _flag_gravatar
        # If the gravatar flag is set
        set -g hashed_email (echo -n "$_flag_email" | md5sum |  sed 's/  -//')
        set -g url "https://s.gravatar.com/avatar/$hashed_email?s=$_flag_size"
    else
        # Use libravatar by default
        set -g hashed_email (echo -n "$_flag_email" | sha256sum |  sed 's/  -//')
        set -g url "https://cdn.libravatar.org/avatar/$hashed_email?s=$_flag_size"
    end

    if set -q _flag_verbose
        if set -q _flag_gravatar
            echo "Using Gravatar"
        else
            echo "Using Libravatar"
        end

        echo "Email: $_flag_email"
        echo "Hashed Email: $hashed_email"
        echo "Avatar URL: $url"
        echo "Saving Image To: $dir"
        echo "Image Name: $img_name"
    end

    if set -q _flag_url_only
        echo $url
        return 0
    end

    wget -q -O "$dir/$img_name" $url
end
