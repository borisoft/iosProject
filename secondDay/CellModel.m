//
//  CellModel.m
//  secondDay
//
//  Created by alex on 14.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

-(instancetype)initWithHeight:(CGFloat)height
                   identifier:(NSString *)identifier
                        image:(UIImage *)image
                         text:(NSString *)text
                   stateColor:(UIColor *)stateColor{
    self = [super init];
    if(self){
        self.height=height;
        self.identifier=identifier;
        self.image=image;
        self.text=text;
        self.stateColor=stateColor;
        
    }
    return  self;
}
+(instancetype)modelWithHeight:(CGFloat)height
                    identifier:(NSString *)identifier
                         image:(UIImage *)image
                          text:(NSString *)text
                    stateColor:(UIColor *)stateColor{
    return [[self alloc]initWithHeight:height identifier:identifier image:image text:text stateColor:stateColor];
}

@end
