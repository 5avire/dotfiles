--> Defaults

terminal         = "kitty"
fileManager      = "nautilus"
appPicker        = "rofi -show drun -config application.rasi"

controlPanel     = ""

volumeUp         = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
volumeDown       = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
volumeMuteToggle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

brightnessUp     = "brightnessctl -e4 -n2 set 5%+"
brightnessDown   = "brightnessctl -e4 -n2 set 5%-"

emojiPicker      = "rofimoji"
clipboard        = "~/dots/scripts/clipboard.sh"
screenShot       = "hyprshot -m region"
