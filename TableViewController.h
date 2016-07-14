//
//  TableViewController.h
//  secondDay
//
//  Created by alex on 13.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
