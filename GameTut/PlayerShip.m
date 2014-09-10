//
//  PlayerShip.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "PlayerShip.h"

@implementation PlayerShip{
    GamePlayScene *_scene;
}
// Define the category for physics
static const uint32_t _category = 0x1 << 0;
+(uint32_t)category {@synchronized(self){return _category;}}

@synthesize playerLives = _playerLives;
@synthesize playerScore = _playerScore;
@synthesize shipLocation = _shipLocation;

-(id)initWithScene:(GamePlayScene *)scene
{
    if (self = [super init]) {
        
        // Initialize Object
        self = [PlayerShip spriteNodeWithImageNamed:@"Spaceship"];
        [self setScale:0.5];
        self.zRotation = - M_PI / 2;
        
        //Adding SpriteKit physicsBody for collision detection
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width - 20, self.size.height - 30)];
        self.physicsBody.categoryBitMask = [PlayerShip category];
        self.physicsBody.dynamic = YES;
        self.physicsBody.contactTestBitMask = [Asteroid category];
        self.physicsBody.collisionBitMask = 0;
        self.name = @"ship";
        [self setShipLocation: CGPointMake(100,scene.frame.size.height/2)];
        self.position = [self shipLocation];
        [scene addChild:self];
        
        // Initialize class properties
        _scene = scene;
        _playerLives = 3;
        _playerScore = 0;
    }
    return self;
}

-(void)move:(CGPoint)aPoint
{
    float shipMid = self.size.height/2;
    float newY = aPoint.y;
    
    if(newY > _scene.frame.size.height - shipMid)
        newY = _scene.frame.size.height - shipMid;
    else if(newY < shipMid)
        newY = shipMid;
    
    [self setShipLocation: CGPointMake([self shipLocation].x, newY)];
    self.position = [self shipLocation];
}

-(void)lostLife { _playerLives--;}
-(void)scoredPoint { _playerScore++;}

@end
