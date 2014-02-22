//
//  INFHighScoreViewController.m
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import "INFHighScoreViewController.h"
#import "INFHighScore.h"
#import "INFHighScoreList.h"
#import "INFHighScoreCell.h"

@interface INFHighScoreViewController ()
{
    INFHighScoreList *highScoreList;
    NSUserDefaults *defaults;
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
    
    // testing, populate high scores
}

- (void)viewDidAppear:(BOOL)animated
{
    defaults = [NSUserDefaults standardUserDefaults];
    INFHighScoreList *temp = [defaults objectForKey:@"highScoreList"];
    highScoreList = temp;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HighScoreCell";
    INFHighScoreCell *cell = (INFHighScoreCell *)[self.highScoreTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    INFHighScore *temp = highScoreList.first;
    for (int i = 0; i < indexPath.row; i++) {
        temp = temp.next;
    }
    cell.nameLabel.text = temp.name;
    cell.scoreLabel.text = [NSString stringWithFormat:@"%d",temp.score];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return highScoreList.numberOfHighScores;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
