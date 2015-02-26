//
//  MenuViewController.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/10/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "ScoreRankViewController.h"

@interface ScoreRankViewController ()

@end

@implementation ScoreRankViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    highScores = [[HighScoreKeeper getInstance] getHighScores];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Table View Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [highScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    NSString *stringForRank = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    NSString *stringForScore = [NSString stringWithFormat:@"%@",(NSNumber*)[highScores objectAtIndex:indexPath.row]];
    
    [cell.textLabel setText:stringForRank];
    [cell.detailTextLabel setText:stringForScore];
    
    return cell;
}

@end
