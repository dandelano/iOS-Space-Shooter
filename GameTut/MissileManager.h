//
//  MissileManager.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GamePlayScene.h"
#import "Missile.h"

@interface MissileManager : NSObject

-(id)initWithScene:(GamePlayScene *)scene;

-(void)fireMissile:(CGPoint)aPoint;
-(void)moveMissile:(CGPoint)aPoint ID:(int)aID;
-(void)removeMissile:(int)aID;
-(void)removeAllMissiles;
@end
