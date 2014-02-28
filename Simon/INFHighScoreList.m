//
//  INFHighScoreList.m
//  Simon
//
//  Created by Justin Sacbibit on 2/22/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFHighScoreList.h"

@implementation INFHighScoreList

- (id) init
{
    self = [super init];
    self.highScores = [[NSMutableArray alloc] init];
    return self;
}

- (void) addNewHighScore:(int)score byPlayer:(NSString *)name
{
    NSLog(@"added %@",name);
    INFHighScore *newHighScore = [[INFHighScore alloc] init];
    newHighScore.name = name;
    newHighScore.score = score;
    
    // add to empty array
    if ([self.highScores count] == 0) {
        [self.highScores addObject:newHighScore];
    }
    
    // else need to sort
    else {
        
    }
}

@end
