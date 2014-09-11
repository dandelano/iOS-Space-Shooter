//
//  GameViewController.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/9/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "GameViewController.h"
#import "GamePlayScene.h"
#import "GHContextMenuView.h"

@interface GameViewController ()<GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GameViewController

@synthesize isGamePlaying = _isGamePlaying;

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        SKScene * scene = [GamePlayScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
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
    GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
    [overlay setDataSource:self];
    [overlay setDelegate:self];
    
    UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    [self.imageView setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:_longPressRecognizer];
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
                msg = @"Pause selected";
                [self setIsGamePlaying:NO];
            }else{
                msg = @"Play selected";
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
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}

@end
