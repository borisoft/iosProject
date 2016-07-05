//
//  XMLParserResult.h
//  secondDay
//
//  Created by alex on 30.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParserResult : NSObject <NSXMLParserDelegate>
@property (nonatomic,strong)NSMutableDictionary <NSString *,NSNumber *> *result;
@end
