//
//  BaseTableViewCell.h
//  secondDay
//
//  Created by alex on 14.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"
@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong) CellModel * model;
@end
