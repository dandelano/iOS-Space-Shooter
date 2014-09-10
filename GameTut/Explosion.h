//
//  Explosion.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GamePlayScene.h"
@interface Explosion : SKSpriteNode

-(id)initWithScene:(GamePlayScene *)scene;
-(void)showExplosion:(CGPoint)location;
@end
