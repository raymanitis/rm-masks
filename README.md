# RM-Masks Script For Peds

A lightweight FiveM script for **attaching custom masks** to peds using [ox_lib](https://overextended.dev/ox_lib) menus.

### ✨ Features

* Simple `/pedmask` command to open the mask menu.
* Add or remove masks dynamically.
* Customizable mask list in `config.lua`.
* Uses **ox_lib** for menus and notifications.
* Automatically cleans up entities on resource stop.

### ⚙️ Configuration

Edit `config.lua` to adjust:

* Command name (`Config.Command`)
* Menu title (`Config.MenuTitle`)
* Notification type (`Config.NotifyType`)
* Masks list with model, offsets, and rotations

Example:

```lua
{ label = 'Gas Mask', model = 'prop_player_gasmask', offset = { x = 0, y = 0.005, z = -0.015 }, rotation = { x = 0.0, y = -90, z = 180 } }
```

### 📖 Usage

1. Install the resource into your `resources` folder.
2. Add to your `server.cfg`:

   ```
   ensure qbox-masks
   ```
3. In-game, use:

   ```
   /pedmask
   ```
4. Select a mask from the menu (only works on custom ped models, not freemode).

### 🛠️ Dependencies

* [ox_lib](https://github.com/overextended/ox_lib)

### 📝 Notes

* Only **one mask at a time** is supported (old mask is removed before attaching new).
* Works best with non-freemode ped models.

---

💡 *Made for Qbox framework – easy to expand with your own mask props.*
