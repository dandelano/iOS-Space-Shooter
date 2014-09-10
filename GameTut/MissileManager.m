//
//  Missiles.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "MissileManager.h"

static const int MAX_MISSILES = 5;

@implementation MissileManager{
    NSArray *_missiles;
    GamePlayScene *_scene;
}

-(id)initWithScene:(GamePlayScene *)scene
{
    if (self = [super init]) {
        // Initialize
        _scene = scene;
        NSMutableArray *missiles = [NSMutableArray array];
        for (int i = 0; i < MAX_MISSILES; i++) {
            Missile *missile = [[Missile alloc] initWithID:i];
            [missiles addObject:missile];
            [_scene addChild:missile];
        }
        _missiles = missiles;
    }
    return self;
}

-(void)fireMissile:(CGPoint)aPoint
{
    int availableID = -1;
    
    for (id missile in _missiles){
        // find an unused missile
        if ([missile isHidden] == YES)
        {
            availableID = [missile ID];
            break; // found our missile
        }
    }
    if (availableID != -1) {
        [self moveMissile:aPoint ID: availableID];
        [_missiles[availableID] show];
    }
    return;
}

-(void)moveMissile:(CGPoint)aPoint ID:(int)aID
{
    [_missiles[aID] move:aPoint];
}

-(void)removeMissile:(int)aID
{
    [_missiles[aID] hide];
}

-(void)removeAllMissiles
{
    for (int i = 0; i < MAX_MISSILES; i++) {
        [_missiles[i] hide];
    }
}

@end
