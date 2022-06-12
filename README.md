# Roblox Game Starter Pack

Included are a collection of data management systems to build the foundation of a game, which are the result of research and learning about the state-of-the-art best practices for Roblox Game Development. 
This is still a work-in-progress and by no means exhaustive. 

Each piece of functionality is separated using a module pattern through an "install" script stolen from Roblox's own Dev Modules installer. 
This allows pieces of functionality to be separated into their own folders within your dev environment, and then scattered into their respective `ReplicatedStorage`, `ServerStorage`, `ServerScriptService`, etc at runtime. At also allows a piece of functionality to be easily dropped into a new game. 

While these modules directly reference pieces from each other at present, it would be easy to make the dependencies indirect through configurations so that modules could be interchangeable while conforming to some interface. This hasn't been done yet, but should be done before publishing them for broader use. For now see them as somewhat-finished reference code meant to be modified directly as part of their usage. 

The modules are all in [ServerScriptService](https://github.com/chasemc67/Shipwrecked/tree/master/src/ServerScriptService) and include the following:

## RoactRoduxRootModule
Sets up a root Roact Component connected to a root client Rodux store. Also sets up a root server Rodux store. 
Reducers from other modules like the InventoryModule are imported directly
Components from other modules like the HarvestingModule are imported directly

## DataModule 
Interacts with Roblox's DataStore to persist user data across sessions

## HarvestingModule
Allows parts to be tagged as "Harvestable" using Roblox's CollectionService. Attaches logic to any tagged parts including managing proximityPrompts based on equipped items, updating users inventory, and destorying parts after being harvested. 

## InventoryModule
Inventory UI and data management, backed by synced client and server side Rodux reducers. The server-side reducer is persisted to Roblox's Datastore using the DataModule
