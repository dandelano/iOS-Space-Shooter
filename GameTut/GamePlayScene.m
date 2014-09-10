//
//  MyScene.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 8/26/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "GamePlayScene.h"
#import "PlayerShip.h"
#import "MissileManager.h"
#import "Asteroid.h"
#import "Explosion.h"
#import "GameOverScene.h"

static const float BG_VELOCITY = 100.0;
static const float OBJECT_VELOCITY = 160.0;



static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

@implementation GamePlayScene{
    // Ship
    PlayerShip *_ship;
    // Stats label
    SKLabelNode *_game_stats_label;
    // Explosions
    Explosion *_explosion;
    // Missiles
    MissileManager *_missileManager;
    // GestureRecognizer
    UITapGestureRecognizer *_tapRecog;
    // Timing
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSTimeInterval _lastMissileAdded;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Initialize background
        self.backgroundColor = [SKColor whiteColor];
        [self initalizingScrollingBackground];
        // Initialize ship
        _ship = [[PlayerShip alloc] initWithScene:self];
        // Initialize missiles
        _missileManager = [[MissileManager alloc] initWithScene:self];
        // Initialize explosion
        _explosion = [[Explosion alloc] initWithScene:self];
        
        // add game stats to screen
        [self initGameStatistics];

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

-(void)initalizingScrollingBackground
{
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg-space.png"];
        bg.position = CGPointMake(i * bg.size.width, 0);
        bg.anchorPoint = CGPointZero;
        bg.name = @"bg";
        [self addChild:bg];
    }
    
}

-(void)initGameStatistics
{
    _game_stats_label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _game_stats_label.text = [NSString stringWithFormat:@"Lives: %d Score: %d",[_ship playerLives],[_ship playerScore]];
    _game_stats_label.fontSize = 16;
    _game_stats_label.fontColor = [SKColor whiteColor];
    _game_stats_label.position = CGPointMake(80, 5);
    [self addChild:_game_stats_label];
}

-(void)updateGameStatistics
{
    _game_stats_label.text = [NSString stringWithFormat:@"Lives: %d Score: %d",[_ship playerLives],[_ship playerScore]];
}

-(void)addAsteroid
{
    [self addChild:[[Asteroid alloc] initWithScene:self]];
}

-(void)fireMissile:(UITapGestureRecognizer *)gesture
{
    [_missileManager fireMissile:[_ship shipLocation]];
}

-(void)removeMissile:(Missile *)missile
{
    [_missileManager removeMissile:[missile ID]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    CGPoint newLocation = CGPointMake(0, ([_ship shipLocation].y + touchLocation.y)/2);
    [_ship move:newLocation];
}

- (void)moveBg
{
    [self enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.x <= -bg.size.width)
             bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
     }];
}

- (void)moveGameObjects
{
    NSArray *nodes = self.children;//1
    for(SKNode *node in nodes){
        // Get velocity and interpolation amount
        CGPoint obVelocity = CGPointMake(OBJECT_VELOCITY, 0);
        CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt);
 
        if ([node.name  isEqual: @"asteroid"]) {
            SKSpriteNode *asteroid = (SKSpriteNode *) node;
            amtToMove.x *= -1; // Asteroids move to the left
            asteroid.position = CGPointAdd(asteroid.position, amtToMove);
            if(asteroid.position.x < -100)
                [asteroid removeFromParent];
        }
        
        if ([node.name  isEqual: @"missile"]) {
            Missile *missile = (Missile *) node;

            if ([missile isHidden] == NO) {
                [missile move: CGPointAdd(missile.position, amtToMove)];
            
                if(missile.position.x >= self.frame.size.width )
                {
                    [_missileManager removeMissile:[missile ID]];
                }
            }
        }
    }
}

/*
 This is the timer loop that calls the updating methods.
 */
-(void)update:(CFTimeInterval)currentTime {
    
    if (_lastUpdateTime)
        _dt = currentTime - _lastUpdateTime;
    else
        _dt = 0;
    
    _lastUpdateTime = currentTime;
    
    if (currentTime - _lastMissileAdded > 1) {
        _lastMissileAdded = currentTime + 1;
        [self addAsteroid];
    }
    
    [self moveBg];
    [self moveGameObjects];
    [self updateGameStatistics];
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
        [_ship lostLife];
        if ([_ship playerLives] <= 0) {
            //[_ship removeFromParent];
            SKTransition *reveal = [SKTransition fadeWithDuration:0.3];
            SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
            [self.view presentScene:gameOverScene transition: reveal];
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
            [_ship scoredPoint];        }
    }
}

@end