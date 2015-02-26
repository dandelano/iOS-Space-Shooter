//
//  PlayerShip.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Contsants.h"
#import "GamePlayScene.h"
#import "Asteroid.h"

@interface PlayerShip : SKSpriteNode
+(uint32_t)category;
@property (readonly) int playerLives;
@property (readonly) int playerScore;
@property CGPoint shipLocation;

-(id)initWithScene:(GamePlayScene *)aScene;
-(void)move:(CGPoint)aPoint;

@end
