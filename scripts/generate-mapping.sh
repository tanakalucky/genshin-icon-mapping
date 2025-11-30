#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Genshin Icon Mapping Generator ===${NC}\n"

mkdir -p data
mkdir -p output

echo -e "${YELLOW}[1/3] Downloading source data...${NC}"

if [ ! -f data/AvatarExcelConfigData.json ]; then
  echo "  - Downloading AvatarExcelConfigData.json..."
  curl -L -o data/AvatarExcelConfigData.json \
    "https://raw.githubusercontent.com/DimbreathBot/AnimeGameData/master/ExcelBinOutput/AvatarExcelConfigData.json"
  echo -e "${GREEN}  ✓ Downloaded${NC}"
else
  echo -e "${GREEN}  ✓ Already exists (skipping)${NC}"
fi

echo ""

echo -e "${YELLOW}[2/3] Checking dependencies...${NC}"
if ! command -v jq &> /dev/null; then
  echo -e "${RED}Error: jq is not installed${NC}"
  echo "Install with:"
  echo "  macOS:   brew install jq"
  echo "  Ubuntu:  sudo apt-get install jq"
  exit 1
fi
echo -e "${GREEN}  ✓ jq found${NC}\n"

echo -e "${YELLOW}[3/3] Generating mapping...${NC}"

jq -n \
  --slurpfile avatars data/AvatarExcelConfigData.json \
  '
  $avatars[0]
  | map(
      select(
        .useType == "AVATAR_FORMAL"
        and .iconName != null
        and .iconName != ""
      )
      | {
          (.id | tostring): {
            avatarId: .id,
            iconKey: .iconName,
            iconUrl: ("https://enka.network/ui/" + .iconName + ".png"),
            sideIconUrl: ("https://enka.network/ui/" + .sideIconName + ".png")
          }
        }
    )
  | add
  ' > output/mapping.json

ENTRY_COUNT=$(jq 'length' output/mapping.json)

echo -e "${GREEN}  ✓ Generated mapping with ${ENTRY_COUNT} playable characters${NC}\n"

echo -e "${YELLOW}Sample output (first 3 entries):${NC}"
jq 'to_entries | .[0:3]' output/mapping.json

echo ""
echo -e "${GREEN}✓ Done! Output: output/mapping.json${NC}"
