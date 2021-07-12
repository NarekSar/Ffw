## Français

### Ffw c'est quoi ?

Ffw ou FreeFramework est framework open source orienté objet, permettant un code plus lisible et des performances maximal.
 
### Quel est notre objectif ?

Nous avons pour but de créer une solution clefs en mains, permettant de prendre de bonne habitudes aux débutant et de perdre les mauvaises habitudes des intermédiaire (comme avoir par exemple 50/100/150 ressources leur serveur, ce qui est contre productifs).

### Qui peu utiliser le Ffw ? 

Ce framework est utilisable par n'importe qui du a sa faciliter de compréhension et à sa syntaxe revue, fini l'utilisation de native sans vraiment d'explication. Bonjour a la POO est à sa syntaxe simplifié.

#### Puisqu'un exemple est une flagrant que la théorie, voici deux exemple

__**Menus**__
```lua
local mainMenu = Menus.create({
    title = "Titre du menu", 
    pos = {x = 0, y = 0}, -- Définie la position du menu
    width = 435, -- Définie la largeur dy menu
    parent = nil, -- A définir si le menu est un sous menu, par le menu Parent
    canClose = false, -- Empêche la fermeture du menu
    onClose = function() -- S'active lorsque le menu se ferme
        print("On close")
    end, 
})
mainMenu:addButton({
  label = "Texte afficher",
  onClick = function()
      print("On click")
  end,
  submenu = nil, -- A définir si le bouton redirige vers un sous menu
})
mainMenu:open()  -- Ouvre le menu mainMenu
```
__**Zones**__
```lua
local TestPed = Peds.create("cbs_abigail", vector4(-1543.253, 830.0703, 182.1245, 0), false) -- Créer un peds a un positions précise
Test = Zones.create({
    ped = TestPed, -- Définie le ped de la zone
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}), -- Définie le blip de la zone
    marker = Markers.create({type = 2, radius = 15.0, pos = vector3(TestPed.pos.x, TestPed.pos.y, TestPed.pos.z + 1.18), width = 0.3, height = 0.3, colour = {r = 0, g = 245, b = 245, a = 185}, blowUp = true, faceCam = true, inversed = true}), -- Définie le marker de la zone
    pos = TestPed.pos, -- Définie la position de la zone (ici je prend la position du ped)
    radius = 2.0, -- Le rayon de déclenchement de la zone
    inputText = "Appuyer sur E pour discuter.", -- Le text afficher lorsque je suis dans la zone
    methode = function()
        E:onPress(function()
            mainMenu:open()
        end)
    end, -- L'action effectué lorsque je suis dans la zone
})
```

### Comment contribuer ? 

Ce framework étant open-source chacun peux y apportée sa contribution, pour cela il vous suffit de pull request, si je juge le pull intéressant celui ci seras ajouté au repositirie.

### Avancement

Le projet étant à ces début nous somme loin de nôtre objectuf, vous pouvez néanmoins suivre l'avancement et avoir quelques apercu du projet sur notre discord : https://discord.gg/Fj2txyK6nW


## English

### Ffw what is it?

Ffw or FreeFramework is an open source object oriented framework, allowing more readable code and maximum performance.
 
### What is our goal?

Our goal is to create a turnkey solution, allowing beginners to develop good habits and to lose the bad habits of intermediaries (such as having 50/100/150 resources on their server, which is counterproductive).

### Who can use the Ffw?

This framework can be used by anyone for easy understanding and its revised syntax, no more using native without really explaining it. Hello OOP is at its simplified syntax.

#### Since one example is a glaring than theory, here are two example

__**Menus**__
```lua
local mainMenu = Menus.create({
    title = "Titre du menu", 
    pos = {x = 0, y = 0}, -- Définie la position du menu
    width = 435, -- Définie la largeur dy menu
    parent = nil, -- A définir si le menu est un sous menu, par le menu Parent
    canClose = false, -- Empêche la fermeture du menu
    onClose = function() -- S'active lorsque le menu se ferme
        print("On close")
    end, 
})
mainMenu:addButton({
  label = "Texte afficher",
  onClick = function()
      print("On click")
  end,
  submenu = nil, -- A définir si le bouton redirige vers un sous menu
})
mainMenu:open()  -- Ouvre le menu mainMenu
```
__**Zones**__
```lua
local TestPed = Peds.create("cbs_abigail", vector4(-1543.253, 830.0703, 182.1245, 0), false) -- Créer un peds a un positions précise
Test = Zones.create({
    ped = TestPed, -- Définie le ped de la zone
    blip = Blips.create({label = "Test", sprite = 1, colour = 3, scale = 0.7,}), -- Définie le blip de la zone
    marker = Markers.create({type = 2, radius = 15.0, pos = vector3(TestPed.pos.x, TestPed.pos.y, TestPed.pos.z + 1.18), width = 0.3, height = 0.3, colour = {r = 0, g = 245, b = 245, a = 185}, blowUp = true, faceCam = true, inversed = true}), -- Définie le marker de la zone
    pos = TestPed.pos, -- Définie la position de la zone (ici je prend la position du ped)
    radius = 2.0, -- Le rayon de déclenchement de la zone
    inputText = "Appuyer sur E pour discuter.", -- Le text afficher lorsque je suis dans la zone
    methode = function()
        E:onPress(function()
            mainMenu:open()
        end)
    end, -- L'action effectué lorsque je suis dans la zone
})
```

### How to contribute?

This framework being open-source everyone can make their contribution, for that you just need to pull request, if I find the pull interesting, it will be added to the repository.

### Advancement

The project being at the beginning we are far from our objective, you can nevertheless follow the progress and have some overview of the project on our discord: https://discord.gg/Fj2txyK6nW
