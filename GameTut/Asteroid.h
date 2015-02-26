//
//  Asteroid.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Contsants.h"
#import "PlayerShip.h"

@interface Asteroid : SKSpriteNode
+(uint32_t)category;

@property (readonly) int rotationDirection;
@property (readonly) int velocity;

-(id)initWithScene:(GamePlayScene *)aScene;
-(void)moveAsteroid:(NSTimeInterval)delayTime;
-(void)rotate;
@end
