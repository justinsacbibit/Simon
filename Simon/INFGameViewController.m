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
    int currentIndex;
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
    
    /*
    // testing
        for (int i = 0; i < 8; i++){
        randomNumber = arc4random() % 4;
        [_pattern addObject:[NSNumber numberWithInteger:randomNumber]];
    }
    */
    
    // additional setup
    _patternPlaying = NO;
    _currentScore = 0;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",_currentScore];
    gameRunning = NO;
    currentIndex = 0;
    
    // initialize views array for use of changing "currentView"
    views = @[_viewOne,_viewTwo,_viewThree,_viewFour];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)lightUpView:(UIView *)view
{
    // store the old colour of the view to be lit up
    tempColour = [currentView backgroundColor];
    
    // depending on the current view, change the colour to something brighter
    if (currentView == _viewOne) [currentView setBackgroundColor:[UIColor greenColor]];
    if (currentView == _viewTwo) [currentView setBackgroundColor:[UIColor redColor]];
    if (currentView == _viewThree) [currentView setBackgroundColor:[UIColor yellowColor]];
    if (currentView == _viewFour) [currentView setBackgroundColor:[UIColor colorWithRed:0.0 green:(191/255.0) blue:1.0 alpha:1]];
    
    // go back to the old colour after a certain amount of time
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBackView:) userInfo:nil repeats:NO];
}

- (void)changeBackView:(UIView *)view
{
    // change back to the old colour
    [currentView setBackgroundColor:tempColour];
    
    // increase the current index for iterating over the patterns array
    currentIndex++;
    
    // if we are not at the end of the array, then light up the next view
    if (currentIndex < [_pattern count]) {
        currentView = [views objectAtIndex:[_pattern[currentIndex] integerValue]];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lightUpView:) userInfo:nil repeats:NO];
    }
    
    // if we are at the end of the array, then we are done, and the player can press the buttons
    else {
        _patternPlaying = NO;
        
        // set currentIndex to 0 for comparisons with the pattern array
        currentIndex = 0;
    }
}

- (void)beginSequence
{
    NSNumber *currentBoxNumber = _pattern[currentIndex];
    currentView = [views objectAtIndex:[currentBoxNumber integerValue]];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lightUpView:) userInfo:nil repeats:NO];
}

// the player has selected this button
- (IBAction)buttonUpInside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
        [currentView setBackgroundColor:tempColour];
        
        
    }
}

// the player has touched the button, so it must light up
- (IBAction)buttonDown:(id)sender {
    if (gameRunning && !_patternPlaying) {
        // change the currentView
        if ([[sender currentTitle] isEqualToString:@"buttonOne"]) currentView = [views objectAtIndex:0];
        if ([[sender currentTitle] isEqualToString:@"buttonTwo"]) currentView = [views objectAtIndex:1];
        if ([[sender currentTitle] isEqualToString:@"buttonThree"]) currentView = [views objectAtIndex:2];
        if ([[sender currentTitle] isEqualToString:@"buttonFour"]) currentView = [views objectAtIndex:3];
        
        tempColour = [currentView backgroundColor];
        if (currentView == _viewOne) [currentView setBackgroundColor:[UIColor greenColor]];
        if (currentView == _viewTwo) [currentView setBackgroundColor:[UIColor redColor]];
        if (currentView == _viewThree) [currentView setBackgroundColor:[UIColor yellowColor]];
        if (currentView == _viewFour) [currentView setBackgroundColor:[UIColor colorWithRed:0.0 green:(191/255.0) blue:1.0 alpha:1]];
        
    }
}

// the lpayer has not selected the button, so it must revert colour with no further logic
- (IBAction)buttonUpOutside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
        [currentView setBackgroundColor:tempColour];
        
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
