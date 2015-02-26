//
//  Contsants.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/9/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

// Examples of global variables
//extern NSString* const MY_WORD;
//extern float const MY_NUMBER;

// Defines the number of lives a player has when starting the game
extern int const STARTING_NUM_LIVES;

// Defines the max number of missiles on the screen at one time
extern int const MAX_MISSILES;

// Define the speed at which missile objects move each frame
extern float const MISSILE_VELOCITY;

// Define the amount an asteroid will rotate per frame
extern float const ASTEROID_ROTATION_AMNT;

// Define the speed at which asteroid objects move each frame
extern float const ASTEROID_MAX_VELOCITY;
extern float const ASTEROID_MIN_VELOCITY;

// Defines the bit masks for the game objects used by physics for collisions
typedef NS_OPTIONS(NSUInteger,GameObjectMask) {
    GOShip = 0x1 << 0,
    GOMissile = 0x1 << 1,
    GOAsteroid = 0x1 << 2
};