//
//  GameStatistics.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Contsants.h"
#import "GamePlayScene.h"

@interface GameStatistics : NSObject
@property (readonly) int playerLives;
@property (readonly) int playerScore;
@property (readonly) CGPoint statLocation;

-(id)initWithScene:(GamePlayScene *)aScene andLocation: (CGPoint) aLocation;
-(void)subtractPlayerLife;
-(void)addPlayerPoint;
@end
