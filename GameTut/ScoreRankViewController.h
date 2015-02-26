//
//  MenuViewController.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 9/10/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreKeeper.h"

@interface ScoreRankViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>
{
    IBOutlet UITableView *rankTableView;
    NSMutableArray *highScores;
}
@end
