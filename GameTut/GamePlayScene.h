//
//  MyScene.h
//  GameTut
//

//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface GamePlayScene : SKScene <UIGestureRecognizerDelegate, SKPhysicsContactDelegate>
@property (nonatomic,weak) GameViewController *gameViewController;
@end
