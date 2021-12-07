# Final Project, Iteration 3: Dive Bug
A project by Caleb Van Lue.

## How to Play
Tug is being attacked by schools of fish! Using A and D or the left and right arrow keys, you can move left and right on the screen. To swim upwards, press Space. To move toward the surface, you can repeatedly swim to gain momentum and move upwards. To move slightly faster, hold Shift.
To attack the fish that are coming toward you, use fireballs. Press Enter to shoot a fireball in the direction that you are facing. Each enemy hit increases the score by 100 points. 

There are three difficulty settings that this game can be played at. Each difficulty level has its own level design, and the statistics of the enemies vary depending on the difficulty. Shown below are the statistics for each difficulty level:

### Easy
- Player Health: 3
- Blue Enemy Health: 1
- Red Enemy Health: 2
- Enemy speed is initialized at a low range, but increases with time.
### Medium
- Player Health: 4
- Blue Enemy Health: 2
- Red Enemy Health: 3
- Enemy speed is initialized at a slightly higher range than Easy, but still increases with time.
### Hard
- Player Health: 5
- Blue Enemy Health: 2
- Red Enemy Health: 4
- Enemy speed is initialiezd at a slightly higher range than Medium, and still increases with time. 
  
Each enemy collision with a fireball reduces their health by 1, and once their health reaches 0, they will be eliminated. If enemies collide with the player a number of times greater than the player's health, then the player will be eliminated. The player can also be eliminated by sinking too deep. To pause the game, press Escape at any time while in the game. Sound settings can be adjusted here as well as the main menu. See how long you can survive!

## Project Report
- [X] D-1: The repository link is submitted to Canvas before the project deadline.
- [X] D-2: The repository contains a <code>README.md</code> file in its top-level directory.
- [X] D-3: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of M or less.
- [X] C-1: Your repository is well-formed, with an appropriate <code>.gitignore</code> file and no unnecessary files tracked.
- [X] C-2: Your release is tagged using <a href="https://semver.org/">semantic versioning</a> where the major version is zero, the minor version is the iteration number, and the patch version is incremented as usual for each change made to the minor version, and the release name matches the release tag.
- [X] C-3: You have a clear legal right to use all incorporated assets, and the licenses for all third-party assets are tracked in the <code>README.md</code> file.
- [X] C-4: The <code>README.md</code> contains instructions for how to play the game or such instructions are incorporated into the game itself.
- [X] C-5: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of T or less.
- [X] C-6: The release demonstrates the core gameplay loop: the player can take actions that move them toward a goal.
- [ ] B-1: The <code>README.md</code> file contains a personal reflection on the iteration and self-evaluation, as defined above.
- [X] B-2: The game runs without errors or warnings.
- [X] B-3: The source code and project structure comply with our adopted style guides.
- [X] B-4: Clear progress has been made on the game with respect to the project plan.
- [X] A-1: The source code contains no warnings. All warnings are properly addressed, not just ignored.
- [X] A-2: The game includes the conventional player experience loop of title, gameplay, and ending.
- [X] A-3: Earn <em>N</em>*&lceil;<em>P</em>/2&rceil; stars, where <em>N</em> is the iteration number and <em>P</em> is the number of people on the team.
- [X] ⭐ Include a dynamic (non-static) camera
- [X] ⭐ Incorporate parallax background scrolling
- [ ] ⭐ Use paper doll animations
- [ ] ⭐ Use an <code>AnimationTree</code> with either blend spaces (3D) or an animation state machine (2D)
- [X] ⭐ Incorporate smooth transitions between title, game, and end states, rather than jumping between states via <code>change_scene</code>
- [ ] ⭐ Support two of the following: touch input, mouse/keyboard input, and gamepad input
- [X] ⭐ Allow the user to control the volume of music and sound effects independently.
- [X] ⭐ Incorporate juiciness and document it in the <code>README.md</code>
- [X] ⭐ Use particle effects
- [X] ⭐ Use different layers and masks to manage collisions and document this in the <code>README.md</code>
- [X] ⭐ Incorporate pop into your HUD or title screen using <code>Tween</code> or <code>AnimationPlayer</code>
- [X] ⭐ Include an AI-controlled character
- [X] ⭐ Add a pause menu that includes, at minimum, the ability to resume or return to the main menu
- [ ] ⭐ The game is released publicly on <code>itch.io</code>, with all the recommended accompanying text, screenshots, gameplay videos, <i>etc.</i>

I've earned an **___** on this submission.

## Layers and Masks
I wanted the collision scheme to be quite specific between the Player, the Enemies, the fireballs, and the TileMap for the level. In short, I wanted the player to be able to collide with the level and enemies, but keep the enemies from colliding with the level and other enemies. I wanted the fireballs to have a similar collision setup to the player. To do this, I configured the layers and masks of each of these scenes to exist and detect collision on certain layers. 

I began with the TileMap for the level, and figured it would be best for it to exist on layer 1, since it was the first scene I was configuring. Since the TileMap doesn't really detect collision, there was no need to set the mask. Next, I moved on to the Enemy scene. I didn't want there to be any collision whatsoever between the enemies and the level, so I started by setting the layer to 2. I removed all mask layers, since the Enemy scene isn't responsible for detecting collision with other bodies. Finally, I moved on to the Player and Fireball scenes. I knew that the Player needed to collide with both the Level and Enemy scenes, so I set the mask to layers 1 and 2. I knew that this was also the case for the Fireball scene, so I repeated the process with that scene. This resulted in the collision scheme that I required, so I was satisfied and grateful for the layers and masks features in Godot. 

## Juice
One of the biggest elements of juice incorporated in this game so far is the screen shake when colliding with enemies. This is a practice that we discussed earlier in the semester, and I feel that it adds a lot of value to the game for the player. When playing on a PC, most mice don't vibrate like controllers do. A screen shake, to me, feels almost like a visual vibration, and produces the same effect of impact that I was trying to accomplish. I spent quite some time researching the best way to implement a screen shake in Godot, and I think this particular algorithm looks great.

## Third-Party Assets
All assets, except font, are licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/). 

### Font: 
Copyright 2018 The ZCOOL KuaiLe Project Authors (https://www.github.com/googlefonts/zcool-kuaile). This Font Software is licensed under the SIL Open Font License, Version 1.1.

### Images:
Artwork assets are from [Platformer Art Deluxe](https://kenney.nl/assets/platformer-art-deluxe), [Kenney's Fish Pack](https://kenney.nl/assets/fish-pack), and [Background Elements Redux](https://kenney.nl/assets/background-elements-redux). Created in 2016 by Kenney.nl.

### Sounds
All sounds are retrieved from [freesound.org](freesound.org) and are licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/). 
- [swim.wav](https://freesound.org/people/jeckkech/sounds/391666/) by [jeckkech](https://freesound.org/people/jeckkech/)
- [Water_Paddle_impact_001.wav](https://freesound.org/people/EpicWizard/sounds/316572/) by [EpicWizard](https://freesound.org/people/EpicWizard/)
- [Retro Video Game 'Damaged' Effect](https://freesound.org/people/SRJA_Gaming/sounds/544887/) by [SRJA_Gaming](https://freesound.org/people/SRJA_Gaming/)
- [Playground Runaround](https://freesound.org/people/shortiefoeva2/sounds/405220/) by [shortiefoeva2](https://freesound.org/people/shortiefoeva2/)
- [Bơi Xuyên San Hô](https://freesound.org/people/SieuAmThanh/sounds/431801/) by [SieuAmThanh](https://freesound.org/people/SieuAmThanh/)
