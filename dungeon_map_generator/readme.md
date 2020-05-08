source: Ian Douglas (https://iandouglas.com/)

# Dungeon Map Generator

We're going to generate a 2-dimensional dungeon map for a game.

PART ONE:

Write a method that takes in a parameter `size` which builds and returns a
two-dimensional square grid where each side of the grid is `size` cells.

Next, your method should populate the dungeon with one of four markers:
- 'M' indicates a monster
- 't' indicates treasure
- '#' indicates a rock pile
- ' ' indicates empty space

All markers on the map should have an approximately equal chance of appearing
on the map.

We want to avoid an overrun of monsters in our game world. Your map should not
contain any cells where a monster exists in any cells around another monster
(including diagonally).

Output of the map should look something like this, depending on your programming
language, where `size` is 4:
```
['M','t','#','M']
['t','#',' ','t']
[' ','#',' ','M']
['#','M','t',' ']
```

PART TWO:

Make your map 3-dimensional, with the same restrictions. The `size` attribute
will also indicate the depth of your dungeon as well.

Your player will need a way to travel to/from other layers, so you will need to
introduce the idea of stairs to your dungeon. Use a 'd' to mark where steps will go
down to the next level, and a 'u' to mark stairs going back up to the previous level. 
The first dungeon level will not need stairs going up, nor will the bottom level need
stairs going further down.

Wherever you choose to place your downward-facing stairs, the same x,y coordinates on
the level below will be where you will place your upward-facing stairs. For example,
if your downward ('d') stairs are at position (0,3) on one level, then (0,3) of the
next lower level must have upward ('u') stairs at the same position (0,3).

You do NOT need to avoid monster adjacency on other levels of the dungeon.