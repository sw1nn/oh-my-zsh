function _dispatch_to_google_music {
    xdotool \
      search --classname "Google-chrome" \
      search --name "My Library - Google Play - Google Chrome" \
      key --clearmodifiers $1
}

function googleplayctl {
    case $1 in
        pause-play)
            _dispatch_to_google_music space
            ;;
        prev)
            _dispatch_to_google_music Left
            ;;
        next)
            _dispatch_to_google_music Right
            ;;
        thumbs-up)
            _dispatch_to_google_music alt+equal
            ;;
        thumbs-down)
            _dispatch_to_google_music alt+minus
            ;;
        currently-playing)
            xdotool \
                search --classname "Google-chrome" \
                search --name "My Library - Google Play - Google Chrome" \
                getwindowname | awk -F'-' '!/^(Listen Now|Artists|Radio|Featured|Queue|Thumbs up|Last Added|Free and Purchased|Shared with me)/{gsub(/(^ +| +$)/,"", $2); print $1 "\n" $2}'
            ;;
        *)
            echo "No Such command"
            ;;
    esac
}

function _googleplayctl_commands() {
    local ret=1 state
    _arguments ':subcommand:->subcommand' && ret=0

    case $state in
      subcommand)
        subcommands=(
          "pause-play:toggle playing of the current track"
          "prev:select the previous track"
          "next:select the next track"
          "thumbs-up:give the current track a thumbs up"
          "thumbs-down:give the current track a thumbs down"
          "currently-playing:echo the currently playing track"
        )
        _describe -t subcommands 'googleplay-ctl subcommands' subcommands && ret=0
    esac

    return ret
}

compdef _googleplayctl_commands googleplayctl
