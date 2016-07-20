//
//  NewsTableViewCell.h
//  secondDay
//
//  Created by alex on 13.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface NewsTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsShortText;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fullTextLabel;

@end
