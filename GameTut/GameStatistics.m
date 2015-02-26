//
//  GameStatistics.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "GameStatistics.h"

@implementation GameStatistics{
    GamePlayScene *_scene;
    SKLabelNode *_lives;
    SKLabelNode *_score;
}

@synthesize statLocation = _statLocation;
@synthesize playerLives = _playerLives;
@synthesize playerScore = _playerScore;


-(id)initWithScene:(GamePlayScene *)aScene andLocation: (CGPoint) aLocation
{
    if (self = [super init]) {
        _scene = aScene;
        _playerLives = STARTING_NUM_LIVES;
        _playerScore = 0;
        
        _lives = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _lives.text = [NSString stringWithFormat:@"Lives: %d",[self playerLives]];
        _lives.fontSize = 16;
        _lives.fontColor = [SKColor whiteColor];
        _lives.position = CGPointMake(aLocation.x, aLocation.y);
        _lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        
        _score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _score.text = [NSString stringWithFormat:@"Score: %d",[self playerScore]];
        _score.fontSize = 16;
        _score.fontColor = [SKColor whiteColor];
        _score.position = CGPointMake(aLocation.x + 80, aLocation.y);
        _score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        
        [_scene addChild:_lives];
        [_scene addChild:_score];
    }
    return self;
}

-(void)subtractPlayerLife { _playerLives--; _lives.text = [NSString stringWithFormat:@"Lives: %d",[self playerLives]];}
-(void)addPlayerPoint { _playerScore++; _score.text = [NSString stringWithFormat:@"Score: %d",[self playerScore] * 100];}

@end
