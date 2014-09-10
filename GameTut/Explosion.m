//
//  Explosion.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/4/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "Explosion.h"

@implementation Explosion{
    NSArray *_explosionFrames;
    GamePlayScene *_scene;
}

-(id)initWithScene:(GamePlayScene *)scene
{
    if (self = [super init]) {
        // Initialize Object
        NSMutableArray *explosionFrames = [NSMutableArray array];
        SKTextureAtlas *explosionAtlas = [SKTextureAtlas atlasNamed:@"explosion"];
        for (int i=0; i < 5; i++) {// rows 0-4 = 5
            for (int j=0; j < 6; j++) {// columns 0-5 = 6
                NSString *textureName = [NSString stringWithFormat:@"explosion-%d-%d",i,j];
                SKTexture *temp = [explosionAtlas textureNamed:textureName];
                [explosionFrames addObject:temp];
            }
        }
        _explosionFrames = explosionFrames;
        // Initialize class variables
        _scene = scene;
        
    }
    return self;
}

-(void)showExplosion:(CGPoint)location
{
    SKTexture *temp = _explosionFrames[0];
    SKSpriteNode *_explosion;
    _explosion = [SKSpriteNode spriteNodeWithTexture:temp];
    _explosion.position = location;
    _explosion.name = @"explosion";
    [_scene addChild:_explosion];
    // show explosion animation and remove node when completed
    [_explosion runAction:[SKAction animateWithTextures:_explosionFrames timePerFrame:0.025f] completion:^{
        [_explosion removeFromParent];
    }];
    return;
}

@end
