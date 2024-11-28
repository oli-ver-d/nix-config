FILE="$HOME/.weather_locations"
loc=$(grep '^current_location=' "$FILE" | cut -d '=' -f 2- | tr -d '\n')
response=$(curl -s v2d.wttr.in/$loc?format=%t\(%f\)+%c^%l)
text=${response%%^*}
text=$(echo "$text" | sed 's/[[:space:]]*$//')
tooltip=${response#*^}

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
