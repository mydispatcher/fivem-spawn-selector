# FiveM Spawn Selector

A fully custom standalone spawn selector for FiveM servers with a stunning fullscreen NUI interface.

## ✨ Features

✅ **Fullscreen NUI Interface** - Dual-panel layout with beautiful cyan/orange neon styling
✅ **Multiple Spawn Locations** - Easily configurable spawn points with detailed categories
✅ **Real-time Search** - Instantly filter spawn locations
✅ **Job-Based System** - Integration with job systems for restricted spawns
✅ **Smooth Animations** - Loading screens and transition effects
✅ **Admin Commands** - Full admin control system
✅ **Database Support** - Optional spawn history tracking
✅ **Responsive Design** - Works on all screen resolutions
✅ **Keyboard Shortcuts** - ESC to close, ENTER to spawn
✅ **Customizable** - Easy config system for all settings

## 📦 Installation

1. Clone or download this resource into your `resources` folder
2. Add the following line to your `server.cfg`:
   ```
   ensure spawn-selector
   ```
3. Restart your server or use `refresh && start spawn-selector`

## ⚙️ Configuration

All configuration is done in `shared/config.lua`. Key settings:

### Spawn Locations
```lua
Config.SpawnLocations = {
    {
        id = 1,
        name = 'Location Name',
        description = 'Location Description',
        coords = vector3(x, y, z),
        heading = 0.0,
        jobs = {'job_name'},
        allowedRanks = {1, 2, 3},
    },
}
```

### General Settings
- `Config.EnableSpawner` - Enable/disable the spawner
- `Config.EnableDatabase` - Track spawn history
- `Config.SpawnAnimation` - Show spawn animation
- `Config.AnimationDuration` - Animation duration in ms
- `Config.UseJobSystem` - Require jobs for spawning

### UI Customization

Edit `web/style.css` to customize colors:

```css
:root {
    --primary: #00d4ff;        /* Main cyan color */
    --accent: #ff6b00;          /* Orange accent */
    --dark: #0a0e27;            /* Dark background */
}
```

## 🎮 Usage

### For Players

**Opening the spawner:**
- Press `E` (default, configurable)
- Or use command: `/openspawner`

**Selecting a spawn:**
1. Search or scroll through locations
2. Click a location to select it
3. View details in the right panel
4. Click "SPAWN HERE" to spawn

**Keyboard controls:**
- `ESC` - Close spawner
- `ENTER` - Spawn at selected location

### For Admins

```
/spawner open          - Open spawn selector
/spawner list          - List all spawn locations
/spawner tp <id>       - Teleport to spawn location by ID
```

## 📁 File Structure

```
spawn-selector/
├── fxmanifest.lua          # Resource manifest
├── shared/
│   ├── config.lua          # Main configuration
│   └── utils.lua           # Utility functions
├── server/
│   ├── main.lua            # Server logic
│   ├── database.lua        # Database handlers
│   └── commands.lua        # Admin commands
├── client/
│   ├── main.lua            # Client initialization
│   ├── ui.lua              # UI management
│   └── spawning.lua        # Spawn mechanics
└── web/
    ├── index.html          # NUI HTML
    ├── style.css           # UI styling
    └── script.js           # UI logic
```

## 🎨 UI Features

### Dual Panel Layout
- **Left Panel**: Spawn location list with search functionality
- **Right Panel**: Detailed spawn information and spawn button

### Visual Effects
- Neon glow effects on text and borders
- Smooth hover animations
- Loading screen with progress bar
- Gradient backgrounds and transitions

### Responsive Breakpoints
- Desktop (1400px+) - Dual panel side-by-side
- Tablet (1024px - 1400px) - Optimized spacing
- Mobile (768px - 1024px) - Vertical stacking

## 🔧 Customization Examples

### Add Custom Spawn Location

Edit `shared/config.lua`:
```lua
table.insert(Config.SpawnLocations, {
    id = 6,
    name = 'Custom Location',
    description = 'My Custom Spawn',
    coords = vector3(100.0, 200.0, 50.0),
    heading = 45.0,
    jobs = {'any_job'},
    allowedRanks = {1, 2, 3, 4, 5},
})
```

### Change UI Colors

Edit `web/style.css`:
```css
:root {
    --primary: #ff00ff;        /* Magenta */
    --accent: #00ff00;         /* Green */
}
```

### Modify Search Behavior

Edit `web/script.js` in the `filterSpawns()` function:
```javascript
const filterSpawns = (event) => {
    const searchTerm = event.target.value.toLowerCase();
    // Add your custom filtering logic
};
```

## 🛠️ Requirements

- FiveM Server
- (Optional) mysql-async for database features
- (Optional) ESX Framework for job integration

## 🚀 Performance

- Lightweight and optimized
- No external dependencies required (for basic functionality)
- Efficient database queries
- Smooth 60 FPS animations

## 📝 License

MIT License - Feel free to modify and distribute

## 🤝 Support

For issues or feature requests, please create an issue or contact the developer.

---

**Made for FiveM** | Customize to match your server's style
