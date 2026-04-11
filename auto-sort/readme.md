# AK Auto Sort

Automatically sort your inventory into chests that you configure.
Should work with any container, even if it's modded.
Does not modify the container itself.

### Features

- Sort items into chests with the press of a button
- Pick from a large selection of keywords
- Don't sort equipped items
- Sort "exact" chests to equip mannequins etc


### Exact Sort Items

### Other
- Mass Mark items as favorite
- Exclusion Lists


## Setup
- On game load you'll receive a "Sort Tool" (check apparel).
- The sort tool has two functions
  - On "equip", it sorts your items
  - On add to a chest, it opens the chest configuration terminal and returns to your inventory
- It's recommended to favorite it for one button sorting
- Add the tool to a chest you want to sort
- Track the chest for keyword or exact sorting

### Keyword Sorting
- Use "Add Keywords" to add a keyword. Choose as many as you want for a chest (they function as OR, so if you choose ammo and food, both will be sorted into that chest).
- When you sort items, every item in your inventory is examined. For each item
  - Look at each tracked chest in the current cell
  - If a chest has room for the item and
  - If the chest has a sort word that matches a keyword on the item
  - The item is moved to that chest

### Exact Match Sorting
- Use "Track Exact Match" on a chest.
  - This trumps keyword matching. A chest cannot be both
- All items currently in the chest will be saved to a list
- During sorting, items that match that list will be deposited in that chest

### Drain Sorting
- The slowest part of the mod is going through a large inventory. To speed that up, you can use a Drain Chest
- Mark a chest as a "Drain Chest" with the sort tool
- Now when you sort, the tool finds the first Drain Chest that is loaded and has items
- It then sorts items from that chest instead of the player
- If no chests with items found, it still sorts from player inventory
- Use this to quickly dump items and then have them sorted into your desired tag and exact chests

### Other
- You can add items to an exclusion list. These items will be ignored for sorting
- you can mass favorite items (even if you're out of favorite buttons)
  - To do so, add items you want favorited to a chest, then add the sort tool to the chest and "favorite items"

## Limitations
- Only 20 sort chests and 20 exact chests
- Currently sorts favorites (use exclude lists to not store your favorites)
- It can take a while, depending by number of items!

## Troubleshooting
- Not sorting an item? Make sure it's not a favorite and not on the exclude list
- Viewing keywords can potentially fix issues as I reset some cache variables when it's clicked