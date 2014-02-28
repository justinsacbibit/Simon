//
//  INFHighScoreViewController.m
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFHighScoreViewController.h"
#import "INFHighScoreCell.h"

@interface INFHighScoreViewController ()
{
    NSUserDefaults *defaults;
    NSArray *highScores;
    NSArray *highScoreNames;
}
@end

@implementation INFHighScoreViewController

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
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.alpha = 1;
    
    defaults = [NSUserDefaults standardUserDefaults];
    highScores = [defaults objectForKey:@"highScores"];
    highScoreNames = [defaults objectForKey:@"highScoreNames"];
}

- (void)viewDidAppear:(BOOL)animated
{
    defaults = [NSUserDefaults standardUserDefaults];
    highScores = [defaults objectForKey:@"highScores"];
    highScoreNames = [defaults objectForKey:@"highScoreNames"];/*
    NSLog([NSString stringWithFormat:@"%d",[highScores count]]);
    if ([highScores count] > 0) {
        NSLog(highScoreNames[0]);
        NSLog([NSString stringWithFormat:@"%@",highScores[0]]);
    }*/
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [highScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HighScoreCell";
    INFHighScoreCell *cell = (INFHighScoreCell *)[self.highScoreTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameLabel.text = [highScoreNames objectAtIndex:[highScoreNames count]-indexPath.row-1];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[highScores objectAtIndex:[highScores count]-indexPath.row-1]];
    
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSArray *empty = [[NSArray alloc] init];
        [defaults setObject:empty forKey:@"highScores"];
        [defaults setObject:empty forKey:@"highScoreNames"];
        [defaults setInteger:0 forKey:@"highScore"];
        [self viewDidAppear:NO];
        [self.highScoreTableView reloadData];
    }
}

- (IBAction)resetButton:(id)sender {
    
    UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Reset High Scores" message:@"Are you sure you want to reset high scores?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [check show];
}
@end
