//
//  ScrollingBackground.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/18/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "ScrollingBackground.h"

@implementation ScrollingBackground{
    GamePlayScene *_scene;
}

@synthesize bgVelocity = _bgVelocity;

-(id)initWithScene:(GamePlayScene *)aScene andPointVelocity: (CGPoint) aPointVelocity
{
    if (self = [super init])
    {
        _scene = aScene;
        _bgVelocity = aPointVelocity;
        for (int i = 0; i < 2; i++) {
            SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg-space.png"];
            bg.position = CGPointMake(i * bg.size.width, 0);
            bg.anchorPoint = CGPointZero;
            bg.name = @"bg";
            [_scene addChild:bg];
        }
    }
    return self;
}


- (void)scrollBackground: (CGFloat) byInterpolationAmount
{
    [_scene enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint amtToMove = [CGPointMath CGPointMultiplyScalar: _bgVelocity andScalar: byInterpolationAmount];
         bg.position = [CGPointMath CGPointAdd: bg.position andPointToAdd: amtToMove];
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.x <= -bg.size.width)
             bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y);
     }];
}

@end
