//
//  Factory.h
//  secondDay
//
//  Created by alex on 30.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

-(id)initWithMutableDictionary:(NSMutableDictionary *) dict;
@property (nonatomic,strong) NSMutableDictionary *dictionary;
@property (nonatomic,strong) NSString *charCode;
@property (nonatomic) float nominal;
@property (nonatomic) float valueMoney;

-(void)addDictionary;
-(void)clearConveyor;
@end
