//
//  Factory.m
//  secondDay
//
//  Created by alex on 30.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "Factory.h"

@implementation Factory



-(id)initWithMutableDictionary:(NSMutableDictionary *)dict{
    self = [super init];
    if(self){
        self.dictionary=dict;
    }
    return  self;
}
-(void)clearConveyor{
    self.charCode = nil;
    self.nominal = -1;
    self.valueMoney = -1;
}
-(void)addDictionary{
   
    [self.dictionary setObject:@(self.valueMoney/self.nominal) forKey:self.charCode ];
    [self clearConveyor];
}

@end
