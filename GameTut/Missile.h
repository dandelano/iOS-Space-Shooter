//
//  Missile.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Asteroid.h"

@interface Missile : SKSpriteNode
@property (readonly) int ID;
@property (readonly) BOOL isHidden;

+(uint32_t)category;
-(id)initWithID:(int)aID;
-(void)hide;
-(void)show;
-(void)move:(CGPoint)aPoint;
@end
