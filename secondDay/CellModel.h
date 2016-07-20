//
//  CellModel.h
//  secondDay
//
//  Created by alex on 14.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.H>

@interface CellModel : NSObject
@property CGFloat height;
@property (nonatomic,strong) NSString *identifier;

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIColor *stateColor;
@property (nonatomic,strong) NSString *text;
-(instancetype)initWithHeight:(CGFloat)height
                   identifier:(NSString *)identifier
                        image:(UIImage *)image
                         text:(NSString *)text
                   stateColor:(UIColor *)stateColor;

+(instancetype)modelWithHeight:(CGFloat)height
                    identifier:(NSString *)identifier
                         image:(UIImage *)image
                          text:(NSString *)text
                    stateColor:(UIColor *)stateColor;
@end
