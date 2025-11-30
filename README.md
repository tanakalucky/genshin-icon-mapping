# Genshin Impact Character Icon Mapping

Static JSON mapping of Genshin Impact character IDs to icon URLs.

## 📦 Usage
```javascript
const MAPPING_URL = 'https://raw.githubusercontent.com/tanakalucky/genshin-icon-mapping/main/output/mapping.json';

const response = await fetch(MAPPING_URL);
const mapping = await response.json();

// Get Hu Tao's icon
const hutao = mapping['10000046'];
console.log(hutao.iconUrl);
// → https://enka.network/ui/UI_AvatarIcon_Hutao.png
```

## 📋 Data Structure
```json
{
  "10000046": {
    "avatarId": 10000046,
    "iconKey": "UI_AvatarIcon_Hutao",
    "iconUrl": "https://enka.network/ui/UI_AvatarIcon_Hutao.png",
    "sideIconUrl": "https://enka.network/ui/UI_AvatarIcon_Side_Hutao.png"
  }
}
```

## 🔄 Updates

- **Frequency**: Weekly (every Monday at 00:00 UTC)
- **Manual trigger**: Available via GitHub Actions
- **Filter**: Playable characters only (`UseType == "AVATAR_FORMAL"`)

## 🛠️ Local Development
```bash
# Generate mapping locally
./scripts/generate-mapping.sh

# Output will be in output/mapping.json
```

## 📊 Data Source

- [DimbreathBot/AnimeGameData](https://github.com/DimbreathBot/AnimeGameData)

## 📄 License

Data extracted from game files. Not affiliated with HoYoverse.
