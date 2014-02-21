//
//  INFGameViewController.m
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFGameViewController.h"

@interface INFGameViewController ()
{
    UIColor *tempColour;
    NSArray *views;
    UIView *currentView;
    BOOL gameRunning;
}
@end

@implementation INFGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // generate a random number from 1 to 4
    int randomNumber = arc4random() % 4;
    _pattern = [[NSMutableArray alloc] init];
    [_pattern addObject:[NSNumber numberWithInt:randomNumber]];
    
    randomNumber = arc4random() % 4;
    [_pattern addObject:[NSNumber numberWithInteger:randomNumber]];
    
    // additional setup
    _patternPlaying = NO;
    _currentScore = 0;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",_currentScore];
    views = @[_viewOne,_viewTwo,_viewThree,_viewFour];
    gameRunning = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)lightUpView:(UIView *)view
{
    tempColour = [currentView backgroundColor];
    if (currentView == _viewOne) [currentView setBackgroundColor:[UIColor greenColor]];
    if (currentView == _viewTwo) [currentView setBackgroundColor:[UIColor redColor]];
    if (currentView == _viewThree) [currentView setBackgroundColor:[UIColor yellowColor]];
    if (currentView == _viewFour) [currentView setBackgroundColor:[UIColor colorWithRed:0.0 green:(191/255.0) blue:1.0 alpha:1]];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBackView:) userInfo:nil repeats:NO];
}

- (void)changeBackView:(UIView *)view
{
    [currentView setBackgroundColor:tempColour];
}

- (void)beginSequence
{
    for (int i = 0; i < [_pattern count]; i++) {
        
        NSNumber *currentBoxNumber = _pattern[i];
        currentView = [views objectAtIndex:[currentBoxNumber integerValue]];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lightUpView:) userInfo:nil repeats:NO];
    }
    NSLog(@"gg");
    _patternPlaying = NO;
}

- (IBAction)buttonUpInside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
    }
}

- (IBAction)buttonDown:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
    }
}

- (IBAction)buttonUpOutside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
    }
}

- (IBAction)startButtonPressed:(id)sender {
    // start game if game is not running
    if (_currentScore == 0 && [_gameButton.titleLabel.text  isEqual: @"Start"]) {
        gameRunning = YES;
        _patternPlaying = YES;
        [self beginSequence];
        [sender setTitle:@"Next Round" forState:UIControlStateNormal];
        [sender setEnabled:NO];
    }
    // start next round
    else if (_currentScore != 0 && [_gameButton.titleLabel.text isEqual: @"Next Round"]) {
        
        
        
    }
}
@end
