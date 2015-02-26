//
//  GameViewController.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/9/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "GameViewController.h"
#import "GamePlayScene.h"
#import "GameOverScene.h"
#import "GHContextMenuView.h"

@interface GameViewController ()<GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GameViewController{
    SKView *_skView;
    GHContextMenuView* overlay;
}

@synthesize isGamePlaying = _isGamePlaying;

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    _skView = (SKView *)self.view;
    
    if (!_skView.scene) {
        _skView.showsFPS = NO;
        _skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        GamePlayScene *gameScene = [GamePlayScene sceneWithSize:_skView.bounds.size];
        [gameScene setGameViewController: self];
        
        SKScene *scene = (SKScene *) gameScene;
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [_skView presentScene:scene];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set game playing to yes
    [self setIsGamePlaying: YES];
    
    // now create context menu
    overlay = [[GHContextMenuView alloc] init];
    [overlay setDataSource:self];
    [overlay setDelegate:self];
    
    UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    [self.imageView setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:_longPressRecognizer];
}

-(void)startGame
{
    [self setIsGamePlaying:YES];
    
        _skView.showsFPS = NO;
        _skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        GamePlayScene *gameScene = [GamePlayScene sceneWithSize:_skView.bounds.size];
        [gameScene setGameViewController: self];
        
        SKScene *scene = (SKScene *) gameScene;
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKTransition *reveal = [SKTransition fadeWithDuration:0.3];
        // Present the scene.
        [_skView presentScene:scene transition: reveal];
}
-(void)gameEnded
{
    [self setIsGamePlaying:NO];
    
        _skView.showsFPS = NO;
        _skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        GameOverScene *gameOverScene = [GameOverScene sceneWithSize:_skView.bounds.size];
        [gameOverScene setGameViewController: self];
        
        SKScene *scene = (SKScene *) gameOverScene;
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:0.5];
        // Present the scene.
        [_skView presentScene:scene transition: reveal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfMenuItems
{
    return 2;
}

-(BOOL) shouldShowMenuAtPoint:(CGPoint) point
{
    point = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    return YES;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            if ([self isGamePlaying]) {
                imageName = @"pause-white";
            }else{
                imageName = @"play-white";
            }            
            break;
        case 1:
            imageName = @"power-white";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    NSString* msg = nil;
    switch (selectedIndex) {
        case 0:
            if ([self isGamePlaying]) {
                msg = @"Game Paused";
                [self setIsGamePlaying:NO];
            }else{
                [self setIsGamePlaying:YES];
            }
            break;
        case 1:
            msg = @"You quit the game!";
            [self.navigationController popViewControllerAnimated:TRUE];
            break;
        default:
            break;
    }
    
    if (msg != nil) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
