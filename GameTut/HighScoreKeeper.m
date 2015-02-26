//
//  HighScoreKeeper.m
//  GameTut
//
//  Created by Danny J. Delano Jr. on 10/7/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import "HighScoreKeeper.h"

@implementation HighScoreKeeper

static HighScoreKeeper *singletonInstance;
static NSString* const listID = @"ScoreList";

+(HighScoreKeeper*)getInstance
{
    if (singletonInstance == nil) {
        singletonInstance = [[super alloc] init];
        [singletonInstance setUp];
    }
    return singletonInstance;
}

-(void)setUp
{
    // Need to retrieve list of scores from defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:listID] != nil) {
        _HighScores = [defaults objectForKey:listID];
    }else
    {
        NSMutableArray* temp = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            [temp addObject:[NSNumber numberWithInt:i]];
        }
        
        _HighScores = temp.mutableCopy;
    }
}

-(void)setHighScores:(NSMutableArray*)highScores
{
    // Set the list of defaults and save
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:highScores forKey:listID];
    [defaults synchronize];
}

-(NSMutableArray*)getHighScores
{
    // Need to sort from high to low
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [_HighScores sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    return _HighScores;
}

-(bool)checkForHighScore:(NSNumber*)aScore
{
    // If is high score, add to end of list and return yes
    BOOL isHigherScore = NO;
    
    for (int i = 0; i < [_HighScores count]; i++) {
        if ([aScore intValue] > [[_HighScores objectAtIndex:i] intValue]) {
            
            // score was bigger
            isHigherScore = YES;
            // Add to end of list
            [_HighScores replaceObjectAtIndex: [_HighScores count] withObject:aScore];
        }
    }
    
    return isHigherScore;
}


@end
