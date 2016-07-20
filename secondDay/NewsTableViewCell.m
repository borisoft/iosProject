//
//  NewsTableViewCell.m
//  secondDay
//
//  Created by alex on 13.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(void)prepareForReuse{
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
}
-(void)setModel:(CellModel *)model{
    [super setModel:model];
    self.newsShortText.text=model.text;
    self.previewImageView.image = model.image;
}
@end
