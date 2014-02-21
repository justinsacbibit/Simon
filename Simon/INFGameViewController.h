//
//  INFGameViewController.h
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INFGameViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *pattern;
@property (nonatomic) BOOL patternPlaying;
@property (nonatomic) int currentScore;
@property (nonatomic) int highScore;
@property (strong, nonatomic) IBOutlet UIView *viewOne;
@property (strong, nonatomic) IBOutlet UIView *viewTwo;
@property (strong, nonatomic) IBOutlet UIView *viewThree;
@property (strong, nonatomic) IBOutlet UIView *viewFour;

- (IBAction)buttonUpInside:(id)sender;
- (IBAction)buttonDown:(id)sender;
- (IBAction)buttonUpOutside:(id)sender;


- (IBAction)startButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *gameButton;

@end
