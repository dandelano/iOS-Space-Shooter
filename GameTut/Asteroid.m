//
//  Asteroid.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid

// Define the category for physics
static const uint32_t _category = 0x1 << 2;
+(uint32_t)category {@synchronized(self){return _category;}}

-(id)initWithScene:(GamePlayScene *)scene
{
    if (self = [super init]) {
        // Initialize
        self = [Asteroid spriteNodeWithImageNamed:@"asteroid.png"];
        [self setScale:0.12];
        
        //Adding SpriteKit physicsBody for collision detection
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = [Asteroid category];
        self.physicsBody.dynamic = YES;
        self.physicsBody.contactTestBitMask = [PlayerShip category];
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = NO;
        self.name = @"asteroid";
        
        //selecting random y position for missile
        int r = arc4random() % 300;
        self.position = CGPointMake(scene.frame.size.width + 20,r);
    }
    return self;
}

@end
