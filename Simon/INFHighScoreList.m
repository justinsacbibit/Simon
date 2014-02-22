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
    self.first = NULL;
    self.numberOfHighScores = 0;
    return self;
}

- (void) addNewHighScore:(int)score byPlayer:(NSString *)name
{
    INFHighScore *newHighScore = [[INFHighScore alloc] init];
    newHighScore.name = name;
    newHighScore.score = score;
    newHighScore.next = NULL;
    if (self.first == NULL) {
        self.first = newHighScore;
        self.last = newHighScore;
    }
    else {
        INFHighScore *temp = self.first;
        
        // handle 3 cases: beginning, end, middle
        
        // beginning
        if (newHighScore.score > self.first.score) {
            newHighScore.next = self.first;
            self.first = newHighScore;
        }
        
        // end
        else if (newHighScore.score < self.last.score) {
            self.last.next = newHighScore;
            self.last = newHighScore;
        }
        
        // middle
        else {
            while ( newHighScore.score < temp.next.score && temp.next != NULL ) {
                temp = temp.next;
            }
            newHighScore.next = temp.next;
            temp.next = newHighScore;
        }
    }
    self.numberOfHighScores++;
}

@end
