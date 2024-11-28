
import os

# File path
file_path = os.path.expanduser("~/.weather_locations")

# Initialize the file if it doesn't exist
if not os.path.exists(file_path):
    with open(file_path, "w") as f:
        f.write("current_location=\nprevious_locations=\n")

# Read the file and parse its contents
with open(file_path, "r") as f:
    lines = f.readlines()

current_location = ""
previous_locations = ""

for line in lines:
    if line.startswith("current_location="):
        current_location = line.split("=", 1)[1].strip()
    elif line.startswith("previous_locations="):
        previous_locations = line.split("=", 1)[1].strip()

# Split previous locations using the '|' separator
previous_locations_list = previous_locations.split("|") if previous_locations else []

# Prepare options for the user
options = []
if current_location:
    options.append(current_location)
options.extend(previous_locations_list)

# Display the options using rofi
import subprocess

result = subprocess.run(
    ["rofi", "-dmenu", "-p", "Select or enter location"],
    input="\n".join(options),
    text=True,
    stdout=subprocess.PIPE,
)

choice = result.stdout.strip()

if choice:
    # Update current location
    new_current_location = choice

    # Remove the new current location from previous locations to avoid duplicates
    updated_previous_locations = [loc for loc in previous_locations_list if loc != new_current_location]

    # Add the old current location to the previous locations
    if current_location and current_location not in updated_previous_locations:
        updated_previous_locations.insert(0, current_location)

    # Write the new data back to the file
    with open(file_path, "w") as f:
        f.write(f"current_location={new_current_location}\n")
        f.write(f"previous_locations={'|'.join(updated_previous_locations)}\n")
