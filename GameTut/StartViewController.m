//
//  StartViewController.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 8/26/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "StartViewController.h"
#import "GameStartScene.h"

@implementation StartViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startGame:(id)sender
{
    [self performSegueWithIdentifier:@"segueGameView" sender:self];
}

-(IBAction)gameMenu:(id)sender
{
    [self performSegueWithIdentifier:@"segueGameMenu" sender:self];
}

@end