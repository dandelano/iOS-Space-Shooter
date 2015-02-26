//
//  ScrollingBackground.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePlayScene.h"
#import "CGPointMath.h"

@interface ScrollingBackground : NSObject
@property (readonly) CGPoint bgVelocity;
-(id)initWithScene:(GamePlayScene *)aScene andPointVelocity: (CGPoint) aPointVelocity;
-(void)scrollBackground:(CGFloat) byInterpolationAmount;
@end
