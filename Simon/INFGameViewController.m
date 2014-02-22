//
//  INFGameViewController.m
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFGameViewController.h"
#import "INFHighScore.h"
#import "INFHighScoreList.h"

@interface INFGameViewController ()
{
    UIColor *tempColour;
    NSArray *views;
    UIView *currentView;
    BOOL gameRunning;
    BOOL highScoreAchieved;
    int currentIndex;
    int buttonPressed;
    NSUserDefaults *defaults;
    INFHighScoreList *highScoreList;
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
    
    
    /*
    // testing
        for (int i = 0; i < 8; i++){
        randomNumber = arc4random() % 4;
        [_pattern addObject:[NSNumber numberWithInteger:randomNumber]];
    }
    */
    
    // additional setup
    //_currentScore = 0;
    defaults = [NSUserDefaults standardUserDefaults];
    highScoreList = [defaults objectForKey:@"highScoreList"];
    _patternPlaying = NO;
    highScoreAchieved = NO;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",_currentScore];
    _highScoreLabel.text = [NSString stringWithFormat:@"%d",_highScore];
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
    [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(changeBackView:) userInfo:nil repeats:NO];
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
        [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(lightUpView:) userInfo:nil repeats:NO];
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
    [NSTimer scheduledTimerWithTimeInterval:.25 target:self selector:@selector(lightUpView:) userInfo:nil repeats:NO];
}

// the player has selected this button
- (IBAction)buttonUpInside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
        [currentView setBackgroundColor:tempColour];
        
        // check if the button corresponds to the pattern
        if (buttonPressed == [_pattern[currentIndex] integerValue]) {
            // check if sequence is completed
            if (currentIndex + 1 == [_pattern count]) {
                [_gameButton setEnabled:YES];
                
                // increase score
                _currentScore++;
                _scoreLabel.text = [NSString stringWithFormat:@"%d", _currentScore];
                // check if new score is greater than high score
                if (_currentScore >= _highScore) {
                    _highScore = _currentScore;
                    [_highScoreLabel setText:[NSString stringWithFormat:@"%d",_highScore]];
                    highScoreAchieved = YES;
                }
                
                // save state
                [defaults setInteger:_currentScore forKey:@"currentScore"];
                [defaults setInteger:_highScore forKey:@"highScore"];
                [defaults synchronize];
                
                currentIndex=0;
                gameRunning = NO;
                
                // generate a random number from 1 to 4
                int randomNumber = arc4random() % 4;
                [_pattern addObject:[NSNumber numberWithInt:randomNumber]];
                [[NSUserDefaults standardUserDefaults] setObject:_pattern forKey:@"pattern"];
            }
            else currentIndex++;
        }
        
        // if not, it's wrong
        else {
            // wrong popup
            UIAlertView *wrong = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You pressed the wrong button!" delegate:self cancelButtonTitle:@"Okay :(" otherButtonTitles:nil, nil];
            [wrong show];
            
            // reset
            gameRunning = NO;
            [_gameButton setEnabled:YES];
            [_gameButton setTitle:@"Start Over" forState:UIControlStateNormal];
            
            // reflect changes in userdefaults
            [defaults setInteger:0 forKey:@"currentScore"];
            [_pattern removeAllObjects];
            [defaults setObject:_pattern forKey:@"pattern"];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // if high score
    if (highScoreAchieved) {
        UIAlertView *addHighScore = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You just got a new high score! Enter your name." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
        addHighScore.alertViewStyle = UIAlertViewStylePlainTextInput;
        [addHighScore show];
        [highScoreList addNewHighScore:self.currentScore byPlayer:[addHighScore textFieldAtIndex:0].text];
        [defaults setObject:highScoreList forKey:@"highScoreList"];
        [defaults synchronize];
        highScoreAchieved = NO;
    }
}

// the player has touched the button, so it must light up
- (IBAction)buttonDown:(id)sender {
    if (gameRunning && !_patternPlaying) {
        // change the currentView
        if ([[sender currentTitle] isEqualToString:@"buttonOne"]) {
            currentView = [views objectAtIndex:0];
            buttonPressed = 0;
        }
        if ([[sender currentTitle] isEqualToString:@"buttonTwo"]) {
            currentView = [views objectAtIndex:1];
            buttonPressed = 1;
        }
        if ([[sender currentTitle] isEqualToString:@"buttonThree"]) {
            currentView = [views objectAtIndex:2];
            buttonPressed = 2;
        }
        if ([[sender currentTitle] isEqualToString:@"buttonFour"]) {
            currentView = [views objectAtIndex:3];
            buttonPressed = 3;
        }
        
        tempColour = [currentView backgroundColor];
        if (currentView == _viewOne) [currentView setBackgroundColor:[UIColor greenColor]];
        if (currentView == _viewTwo) [currentView setBackgroundColor:[UIColor redColor]];
        if (currentView == _viewThree) [currentView setBackgroundColor:[UIColor yellowColor]];
        if (currentView == _viewFour) [currentView setBackgroundColor:[UIColor colorWithRed:0.0 green:(191/255.0) blue:1.0 alpha:1]];
        
    }
}

// the player has not selected the button, so it must revert colour with no further logic
- (IBAction)buttonUpOutside:(id)sender {
    if (gameRunning && !_patternPlaying) {
        
        [currentView setBackgroundColor:tempColour];
        
    }
}

- (IBAction)startButtonPressed:(id)sender {
    // start game if game is not running
    if ([_gameButton.titleLabel.text  isEqual: @"Start"]) {
        
        // check if pattern array is empty
        if ([_pattern count] == 0) {
            int randomNumber = arc4random() % 4;
            [_pattern addObject:[NSNumber numberWithInt:randomNumber]];
        }
        
        highScoreAchieved = NO;
        gameRunning = YES;
        _patternPlaying = YES;
        [self beginSequence];
        [sender setTitle:@"Next Round" forState:UIControlStateNormal];
        [sender setEnabled:NO];
    }
    // start next round
    else if (_currentScore != 0 && [_gameButton.titleLabel.text isEqual: @"Next Round"]) {
        
        // use pattern array to light up the sequence
        [self beginSequence];
        [sender setEnabled:NO];
        _patternPlaying = YES;
        gameRunning = YES;
        
    }
    // reset
    else if ([_gameButton.titleLabel.text isEqualToString:@"Start Over"]) {
        highScoreAchieved = NO;
        currentIndex = 0;
        _currentScore = 0;
        _scoreLabel.text = [NSString stringWithFormat:@"%d",_currentScore];
        //[_pattern removeAllObjects];
        
        // generate a random number from 1 to 4
        int randomNumber = arc4random() % 4;
        [_pattern addObject:[NSNumber numberWithInt:randomNumber]];
        [[NSUserDefaults standardUserDefaults] setObject:_pattern forKey:@"pattern"];
        
        
        // automatically start new round
        /*
        gameRunning = YES;
        _patternPlaying = YES;
        
        [self beginSequence];
        [sender setTitle:@"Next Round" forState:UIControlStateNormal];
        [sender setEnabled:NO];
         */
        
        // need to click start
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}
@end
