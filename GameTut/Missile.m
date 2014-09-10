//
//  Missile.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "Missile.h"

@implementation Missile

// Define the category for physics
static const uint32_t _category = 0x1 << 1;
+(uint32_t)category {@synchronized(self){return _category;}}

@synthesize ID = _ID;
@synthesize isHidden = _isHidden;

-(id)initWithID:(int)aID
{
    if (self = [super init]) {
        // Initialize Object
        self = [Missile spriteNodeWithImageNamed:@"red-missile.png"];
        [self setScale:0.15];
        
        //Adding SpriteKit physicsBody for collision detection
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = [Missile category];
        self.physicsBody.dynamic = YES;
        self.physicsBody.contactTestBitMask = [Asteroid category];
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.position = CGPointMake(0, 0);
        self.name = @"missile";
        self.hidden = YES;
        
        // Initialize class properties
        _ID = aID;
        _isHidden = YES;
    }
    return self;
}

-(void)hide
{
    self.hidden = YES;
    _isHidden = YES;
}

-(void)show
{
    self.hidden = NO;
    _isHidden = NO;
}

-(void)move:(CGPoint)aPoint
{
    self.position = aPoint;
}

@end
