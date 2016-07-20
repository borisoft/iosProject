//
//  Cell.m
//  secondDay
//
//  Created by alex on 17.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "Cell.h"

@implementation Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
@end
