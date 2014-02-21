//
//  INFGameViewController.h
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INFGameViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *pattern;      // array for the pattern
@property (nonatomic) BOOL patternPlaying;                  // is the pattern being displayed?
@property (nonatomic) int currentScore;                     // current score/round
@property (nonatomic) int highScore;                        // all time high score of all users

// pointers to views in order to change their colours
@property (strong, nonatomic) IBOutlet UIView *viewOne;
@property (strong, nonatomic) IBOutlet UIView *viewTwo;
@property (strong, nonatomic) IBOutlet UIView *viewThree;
@property (strong, nonatomic) IBOutlet UIView *viewFour;

// IBActions used for inputting the pattern
- (IBAction)buttonUpInside:(id)sender;
- (IBAction)buttonDown:(id)sender;
- (IBAction)buttonUpOutside:(id)sender;

// IBAction for the start / next round button
- (IBAction)startButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;     // label for current score
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel; // label for high score
@property (strong, nonatomic) IBOutlet UIButton *gameButton;    // pointer for changing button text

@end
