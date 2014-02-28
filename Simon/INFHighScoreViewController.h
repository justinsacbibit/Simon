//
//  INFHighScoreViewController.h
//  Simon
//
//  Created by Justin Sacbibit on 2/20/2014.
//  Copyright (c) 2014 influxd software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INFHighScoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *highScoreTableView;
- (IBAction)resetButton:(id)sender;

@end
