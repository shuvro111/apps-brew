#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# Log Function for Clear Logging in Terminal
log() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Function to categorize apps dynamically based on name or description
categorize_app() {
  local app_name=$1
  # Dynamic categorization based on known keywords
  if [[ "$app_name" =~ (zoom|google-chrome|slack|teams|notion|figma|postman|raycast) ]]; then
    echo "Productivity"
  elif [[ "$app_name" =~ (spotify|iina|whatsapp|lightshot) ]]; then
    echo "Media"
  elif [[ "$app_name" =~ (postgresql|docker|mongodb-compass|transmission) ]]; then
    echo "Developer Tools"
  elif [[ "$app_name" =~ (arc|ice|alttab|the-unarchiver) ]]; then
    echo "Fun"
  elif [[ "$app_name" =~ (hubstaff|beekeeper-studio|traefik|upwork|cursor|surfshark) ]]; then
    echo "Dev Tools"
  else
    # Fallback for apps that don't fit any predefined category
    echo "Miscellaneous"
  fi
}

# Function to check if an app is available as a cask or formula
check_app_availability() {
  local app_name=$1

  # Check if the app is available as a cask
  if brew search --cask "$app_name" &>/dev/null; then
    echo "cask"
  # Check if the app is available as a formula
  elif brew search "$app_name" &>/dev/null; then
    echo "formula"
  else
    echo "not_found"
  fi
}

# Function to install an app
install_app() {
  local app_name=$1
  local category

  # Dynamically categorize the app
  category=$(categorize_app "$app_name")
  log "Processing app: $app_name (Category: $category)"

  # Check if the app is available in Homebrew (cask or formula)
  availability=$(check_app_availability "$app_name")

  if [ "$availability" == "cask" ]; then
    # Installing as a cask
    if brew list --cask "$app_name" &>/dev/null; then
      log "$app_name is already installed (Cask)."
    else
      log "Installing $app_name (Cask)..."
      brew install --cask "$app_name"
      if [ $? -eq 0 ]; then
        log "$app_name (Cask) installed successfully."
      else
        error "Failed to install $app_name (Cask)."
      fi
    fi
  elif [ "$availability" == "formula" ]; then
    # Installing as a formula
    if brew list "$app_name" &>/dev/null; then
      log "$app_name is already installed (Formula)."
    else
      log "Installing $app_name (Formula)..."
      brew install "$app_name"
      if [ $? -eq 0 ]; then
        log "$app_name (Formula) installed successfully."
      else
        error "Failed to install $app_name (Formula)."
      fi
    fi
  else
    warn "$app_name not found as a cask or formula. Skipping installation."
  fi
}

# Main installation script
echo -e "${GREEN}Starting app installation...${NC}"

# Read through the apps listed in brew-apps.txt
log "Reading apps from brew-apps.txt..."
while IFS= read -r app; do
  # Skip empty lines or comments
  if [[ -z "$app" || "$app" =~ ^# ]]; then
    continue
  fi

  install_app "$app"
done < brew-apps.txt

log "Installation process complete!"
