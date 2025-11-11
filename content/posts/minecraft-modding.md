---
title: "Creating Minecraft mods"
date: 2021-03-04T12:00:00Z
draft: false
description: "Migrated from Jekyll blog"
# Original Jekyll post from 2021-03-04
---


I've always been an avid
<abbr title="Minecraft">MC</abbr>
mod player and I've been recently trying [Endeavour](https://www.feed-the-beast.com/modpack/ftb_endeavour) one of the amazing modpacks by the [FTB](https://www.feed-the-beast.com/) group.  
Endeavour includes tech, QOL, magic, exploration, WTF mods and it's very complete. I love playing it and I explored < 1% of it, I think.  
Being a developer myself, I always wanted to delve into the mod making scene but Java... I never managed to wrap my head around it.

Let's try it again!

My idea for a simple and versatile mod (like [Tetra](https://www.curseforge.com/minecraft/mc-mods/tetra), for example) is about adding a **wickedness meter**.  
Don't Starve does that very well by incrementing a [hidden naughtyness level](https://dontstarve.fandom.com/wiki/Krampus) when killing certain creatures.  
Once the player reaches a specific threshold of naughtiness a monster, Krampus, spawns which breaks chests and steals items on the ground.

Krampus is a neutral creature and it will flee the player when approached but returns fire when attacked.  
It can drop a very rare item, the Krampus Sack, which is one of the biggest if not THE biggest backpack obtainable in the game.

The concept itself is simple but very interesting in a moral way. Most neutral creatures add less than 10 points of naughtyness and Krampus spawns at 31-50. Some creatures auto-spawn Krampus when killed and they're generally the cutest and most inoffensive animals (Glommer and the passive form of one of the Shipwrecked DLC bosses, Sealnado in its Seal form).

The naughtyness system has its exploits, of course, and you can create Krampus farms with a little bit of effort in order to maximize the chance of getting Krampus sacks.

Anyway, I think adding a wickedness meter to MC could work well and the concept can be expanded by adding tools, machines, resources (wickedness fluid?), blocks, etc.

This is the plan:

- Install JDK
- Choose an appropriate code writing environment (Visual Studio, Sublime Text, IntelliJ IDEA, Eclipse, etc.)
- Download Forge
- Write a _Hello, World!_ mod code snippet
- Create a Github repo for the mod
- Implement the wickedness meter and threshold for punishment
- Assign wickedness values for neutral creatures
- Maybe add a wickedness resource which is harvested from neutral creatures
- Increment wickedness when killing animals
- Decrease wickedness when time passes without killing animals
- Decrease wickedness when killing certain monsters (not sure about this)
- Make something happen when the wickedness threshold is reached: spawn monster(s), add effects
- Allow stashing wickedness to prepare for retribution

This will be fun !
