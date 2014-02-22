//
//  INFHighScore.h
//  Simon
//
//  Created by Justin Sacbibit on 2/22/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INFHighScore : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int score;
@property (strong, nonatomic) INFHighScore *next;

@end