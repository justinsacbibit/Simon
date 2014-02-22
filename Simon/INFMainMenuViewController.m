//
//  INFMainMenuViewController.m
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFMainMenuViewController.h"
#import "INFGameViewController.h"

@interface INFMainMenuViewController ()

@end

@implementation INFMainMenuViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"] == 0) {
        [_resumeButton setHidden:YES];
    }
    else [_resumeButton setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newGame"] || [segue.identifier isEqualToString:@"resumeGame"]) {
        
        INFGameViewController *destinationViewController = segue.destinationViewController;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        destinationViewController.pattern = [[NSMutableArray alloc] init];
        
        // start a new game
        if ([[sender currentTitle] isEqualToString:@"New Game"]) {
            
            destinationViewController.currentScore = 0;
            
            // generate a random number from 1 to 4
            int randomNumber = arc4random() % 4;
            [destinationViewController.pattern addObject:[NSNumber numberWithInt:randomNumber]];
            
        }
        
        // resume
        if ([[sender currentTitle] isEqualToString:@"Resume"]) {
            
            destinationViewController.currentScore = [defaults integerForKey:@"currentScore"];
            [destinationViewController.pattern addObjectsFromArray:[defaults objectForKey:@"pattern"]];
        }
        
        destinationViewController.highScore = [defaults integerForKey:@"highScore"];
    }
}

- (IBAction)unwindToMainMenu:(UIStoryboardSegue *)segue
{
    
}

@end
