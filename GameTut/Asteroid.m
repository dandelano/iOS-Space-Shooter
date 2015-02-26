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
static const uint32_t _category = GOAsteroid;
+(uint32_t)category {@synchronized(self){return _category;}}

@synthesize rotationDirection = _rotationDirection;
@synthesize velocity = _velocity;

-(id)initWithScene:(GamePlayScene *)aScene
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
        int randomY = arc4random_uniform(300);
        
        // Pick a rotation direction randomly
        _rotationDirection = (arc4random_uniform(10) > 5 ? 1 : -1);
        
        // Get random value between min and max velocity, then set to negative to move to the left
        _velocity = -(ASTEROID_MIN_VELOCITY + arc4random_uniform(ASTEROID_MAX_VELOCITY - ASTEROID_MIN_VELOCITY + 1));
        
        self.position = CGPointMake(aScene.frame.size.width + 20,randomY);
    }
    return self;
}

-(void)moveAsteroid:(NSTimeInterval)delayTime
{
    // Get velocity and interpolation amount
    CGPoint amtToMove = [CGPointMath CGPointMultiplyScalar:CGPointMake(_velocity, 0) andScalar: delayTime];
    self.position = [CGPointMath CGPointAdd: self.position andPointToAdd: amtToMove];
}

-(void)rotate
{
    self.zRotation += ASTEROID_ROTATION_AMNT * _rotationDirection;
}
@end
