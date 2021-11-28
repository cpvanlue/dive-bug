# Final Project, Iteration 2: Dive Bug
A project by Caleb Van Lue.

## How to Play
Tug is being attacked by schools of fish! Using A and D or the left and right arrow keys, you can move left and right on the screen. To swim upwards, press Space. To move toward the surface, you can repeatedly swim to gain momentum and move upwards. To move slightly faster, hold Shift.

To attack the fish that are coming toward you, use fireballs. Press Enter to shoot a fireball in the direction that you are facing. The smaller, blue fish have a health of 1, and the larger, red fish have a health of 2, meaning they need to be shot one and two times respectively to be eliminated. Each enemy death increases the score by 100 points. You can get hit by enemies 3 times before being eliminated. You can also be eliminated by sinking too deep. See how long you can survive!


## Project Report
I was quite excited for this iteration. After fixing some errors and misunderstandings in the first iteration, I was ready to tackle a major component of this game, which is also the primary objective: enemies. There was a lot that I wanted to implement in regards to enemies, such as multiple types, different speeds, and progressive difficulty. I found solutions to each of these problems and feel that I created a good set of enemies with their abilities. I also utilized layers and masks to help with the collision scheme that I wanted, and that is documented later on. That was a lot of fun to experiment with and figure out what worked just right.

I was able to achieve everything that I wanted to for this iteration, which is encouraging. I felt that the enemy behavior would be one of the biggest parts of this game, but I seem to have made a manageable workload for myself. Essentially, I've established the core functionality of the game. For the next iteration, I'm going to add more flair, juice, and features to make the game feel more complete overall. I'm quite excited to see what the final product will look like.

I feel that I put forth some great work this iteration. To be honest, I probably spent a bit too much time playing the game both as testing and just for fun. I love the concept I've come up with and really feel that this will be a great complete project. 

- [X] D-1: The repository link is submitted to Canvas before the project deadline.
- [X] D-2: The repository contains a <code>README.md</code> file in its top-level directory.
- [X] D-3: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of M or less.
- [X] C-1: Your repository is well-formed, with an appropriate <code>.gitignore</code> file and no unnecessary files tracked.
- [X] C-2: Your release is tagged using <a href="https://semver.org/">semantic versioning</a> where the major version is zero, the minor version is the iteration number, and the patch version is incremented as usual for each change made to the minor version, and the release name matches the release tag.
- [X] C-3: You have a clear legal right to use all incorporated assets, and the licenses for all third-party assets are tracked in the <code>README.md</code> file.
- [X] C-4: The <code>README.md</code> contains instructions for how to play the game or such instructions are incorporated into the game itself.
- [X] C-5: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of T or less.
- [X] C-6: The release demonstrates the core gameplay loop: the player can take actions that move them toward a goal.
- [X] B-1: The <code>README.md</code> file contains a personal reflection on the iteration and self-evaluation, as defined above.
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
- [ ] ⭐ Incorporate smooth transitions between title, game, and end states, rather than jumping between states via <code>change_scene</code>
- [ ] ⭐ Support two of the following: touch input, mouse/keyboard input, and gamepad input
- [ ] ⭐ Allow the user to control the volume of music and sound effects independently.
- [ ] ⭐ Incorporate juiciness and document it in the <code>README.md</code>
- [X] ⭐ Use particle effects
- [X] ⭐ Use different layers and masks to manage collisions and document this in the <code>README.md</code>
- [X] ⭐ Incorporate pop into your HUD or title screen using <code>Tween</code> or <code>AnimationPlayer</code>
- [X] ⭐ Include an AI-controlled character
- [ ] ⭐ Add a pause menu that includes, at minimum, the ability to resume or return to the main menu
- [ ] ⭐ The game is released publicly on <code>itch.io</code>, with all the recommended accompanying text, screenshots, gameplay videos, <i>etc.</i>

I've earned an **A** on this submission.

## Layers and Masks
I wanted the collision scheme to be quite specific between the Player, the Enemies, the fireballs, and the TileMap for the level. In short, I wanted the player to be able to collide with the level and enemies, but keep the enemies from colliding with the level and other enemies. I wanted the fireballs to have a similar collision setup to the player. To do this, I configured the layers and masks of each of these scenes to exist and detect collision on certain layers. 

I began with the TileMap for the level, and figured it would be best for it to exist on layer 1, since it was the first scene I was configuring. Since the TileMap doesn't really detect collision, there was no need to set the mask. Next, I moved on to the Enemy scene. I didn't want there to be any collision whatsoever between the enemies and the level, so I started by setting the layer to 2. I removed all mask layers, since the Enemy scene isn't responsible for detecting collision with other bodies. Finally, I moved on to the Player and Fireball scenes. I knew that the Player needed to collide with both the Level and Enemy scenes, so I set the mask to layers 1 and 2. I knew that this was also the case for the Fireball scene, so I repeated the process with that scene. This resulted in the collision scheme that I required, so I was satisfied and grateful for the layers and masks features in Godot. 

## Third-Party Assets
All assets, except font, are licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/). 

### Font: 
Copyright 2018 The ZCOOL KuaiLe Project Authors (https://www.github.com/googlefonts/zcool-kuaile). This Font Software is licensed under the SIL Open Font License, Version 1.1.

### Images:
Artwork assets are from [Platformer Art Deluxe](https://kenney.nl/assets/platformer-art-deluxe), [Kenney's Fish Pack](https://kenney.nl/assets/fish-pack), and [Background Elements Redux](https://kenney.nl/assets/background-elements-redux). Created in 2016 by Kenney.nl.
