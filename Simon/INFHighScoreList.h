//
//  INFHighScoreList.h
//  Simon
//
//  Created by Justin Sacbibit on 2/22/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INFHighScore.h"

@interface INFHighScoreList : NSObject

@property (strong, nonatomic) INFHighScore *first;
@property (strong, nonatomic) INFHighScore *last;
@property (nonatomic) int numberOfHighScores;

- (id) init;
- (void) addNewHighScore:(int)score byPlayer:(NSString *)name;

@end
