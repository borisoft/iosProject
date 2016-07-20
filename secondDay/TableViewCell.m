//
//  TableViewCell.m
//  secondDay
//
//  Created by alex on 14.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse{
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
}
-(void)setModel:(CellModel *)model{
    [super setModel:model];
    self.newsText.text= model.text;
}

@end
