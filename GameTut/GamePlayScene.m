//
//  MyScene.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 8/26/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "GamePlayScene.h"
#import "ScrollingBackground.h"
#import "PlayerShip.h"
#import "MissileManager.h"
#import "Asteroid.h"
#import "Explosion.h"
#import "GameStatistics.h"
#import "GameOverScene.h"

@implementation GamePlayScene{
    // Game Objects
    ScrollingBackground *_background;
    GameStatistics *_game_stats_label;
    PlayerShip *_ship;
    Explosion *_explosion;
    MissileManager *_missileManager;
    // GestureRecognizer
    UITapGestureRecognizer *_tapRecog;
    // Timing
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _delayTime;
    NSTimeInterval _lastAsteroidAdded;
}

@synthesize gameViewController = _gameViewController;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {        
        // Initialize background
        self.backgroundColor = [SKColor whiteColor];
        
        // Initialize game background
        _background = [[ScrollingBackground alloc] initWithScene:self andPointVelocity:CGPointMake(-100, 0)];
        
        // Initialize game statistics
        _game_stats_label = [[GameStatistics alloc] initWithScene:self andLocation:CGPointMake(10, 5)];
        
        // Initialize ship
        _ship = [[PlayerShip alloc] initWithScene:self];
        
        // Initialize missiles
        _missileManager = [[MissileManager alloc] initWithScene:self];
        
        // Initialize explosion
        _explosion = [[Explosion alloc] initWithScene:self];
        
        //Making self delegate of physics World
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    // gestureRecognizers
    _tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(fireMissile:)];
    [_tapRecog setNumberOfTapsRequired:1];
    [_tapRecog setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:_tapRecog];
    _tapRecog.delegate = self;
}


-(void)fireMissile:(UITapGestureRecognizer *)gesture
{
    if ([_gameViewController isGamePlaying]) {
        [_missileManager fireMissile:[_ship shipLocation]];
    }
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_gameViewController isGamePlaying]) {
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self.scene];
        CGPoint newLocation = CGPointMake(0, ([_ship shipLocation].y + touchLocation.y)/2);
        [_ship move:newLocation];
    }
}


- (void)moveGameObjects
{
    NSArray *nodes = self.children;//1
    for(SKNode *node in nodes){
 
        if ([node.name  isEqual: @"asteroid"]) {
            Asteroid *asteroid = (Asteroid *) node;                       
            [asteroid moveAsteroid: _delayTime];
            [asteroid rotate];
            if(asteroid.position.x < -100)
                [asteroid removeFromParent];
        }
        
        if ([node.name  isEqual: @"missile"]) {
            Missile *missile = (Missile *) node;

            if ([missile isHidden] == NO) {
                [missile moveMissile: _delayTime];
            
                if(missile.position.x >= self.frame.size.width )
                    [_missileManager removeMissile:[missile ID]];
            }
        }
    }
}

/*
 This is the timer loop that calls the updating methods.
 */
-(void)update:(CFTimeInterval)currentTime {
    
    if (_lastUpdateTime)
        _delayTime = currentTime - _lastUpdateTime;
    else
        _delayTime = 0;
    
    _lastUpdateTime = currentTime;
    
    if ([_gameViewController isGamePlaying]) {
        
        if (currentTime - _lastAsteroidAdded > 1) {
            _lastAsteroidAdded = currentTime + 1;
            [self addChild:[[Asteroid alloc] initWithScene:self]];
        }
        
        [_background scrollBackground: _delayTime];
        [self moveGameObjects];        
    }
}

/*
 This is when the physics library receives a contact event.
 */
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // If ship and asteroid collided
    if ((firstBody.categoryBitMask & [PlayerShip category]) != 0 &&
        (secondBody.categoryBitMask & [Asteroid category]) != 0)
    {
        CGPoint loc = secondBody.node.position;
        [secondBody.node removeFromParent];
        [_explosion showExplosion:loc];
        [_game_stats_label subtractPlayerLife];
        if ([_game_stats_label playerLives] <= 0) {
            [[self gameViewController] gameEnded];
        }
    }
    
    // If missile and asteroid collided
    if ((firstBody.categoryBitMask & [Missile category]) != 0 &&
        (secondBody.categoryBitMask & [Asteroid category]) != 0)
    {
        if (firstBody.node.hidden == NO) {
            CGPoint loc = secondBody.node.position;
            // remove the missile
            [_missileManager removeMissile:[(Missile *)firstBody.node ID]];
            // remove asteroid from scene
            [secondBody.node removeFromParent];
            [_explosion showExplosion:loc];
            // Add to score
            [_game_stats_label addPlayerPoint];        }
    }
}

@end