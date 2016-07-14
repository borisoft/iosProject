//
//
//  secondDay
//
//  Created by alex on 07.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "MankeyViewController.h"
typedef void (^CustomBlock)();
@interface MankeyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageMy;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageViewConstraint;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (copy,nonatomic) CustomBlock block;
@end
@implementation MankeyViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    __weak MankeyViewController *weakSelf = self;
    self.block = ^void(){
        
        __strong MankeyViewController *strongSelf = weakSelf;
        if(strongSelf==nil)
            return;
       weakSelf.imageMy.backgroundColor = [UIColor blackColor];
    };
    
}
-(void)dealloc{
    NSLog(@"view controller  is  dealloced  ");
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    dispatch_async(dispatch_get_main_queue(), ^{
//         self.imageMy.frame = CGRectMake(0, 0, 100, 100);
//    });
   
    
    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect frame = self.imageMy.frame;
    float resultHeigth = self.imageMy.superview.frame.size.height-frame.size.height;
    [UIView animateWithDuration:5.0f animations:^{
        
        self.imageMy.frame = CGRectMake(frame.origin.x, resultHeigth, frame.size.width, frame.size.height);
    }completion:^(BOOL finished) {
        self.topImageViewConstraint.constant=resultHeigth;
        [self.imageMy setNeedsLayout];
        [self.imageMy layoutIfNeeded];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.imageMy.frame = CGRectMake(0, 0, 100, 100);

}

@end
