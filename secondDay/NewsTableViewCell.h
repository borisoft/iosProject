//
//  NewsTableViewCell.h
//  secondDay
//
//  Created by alex on 13.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsShortText;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end
