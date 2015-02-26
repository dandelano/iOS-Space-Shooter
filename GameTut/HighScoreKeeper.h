//
//  HighScoreKeeper.h
//  GameTut
//
//  Created by Danny J. Delano Jr. on 10/7/14.
//  Copyright (c) 2014 Danny J. Delano Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreKeeper : NSObject
{
    NSMutableArray* _HighScores;
}

+(HighScoreKeeper*)getInstance;

-(void)setHighScores:(NSMutableArray*)highScores;
-(NSMutableArray*)getHighScores;
-(bool)checkForHighScore:(NSNumber*)aScore;
@end
