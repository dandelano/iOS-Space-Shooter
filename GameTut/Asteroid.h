//
//  Asteroid.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlayerShip.h"

@interface Asteroid : SKSpriteNode
+(uint32_t)category;
-(id)initWithScene:(GamePlayScene *)scene;
@end
