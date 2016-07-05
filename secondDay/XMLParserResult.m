//
//  XMLParserResult.m
//  secondDay
//
//  Created by alex on 30.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "XMLParserResult.h"
@interface XMLParserResult ()
@property (nonatomic,strong) NSString * lastCharCode;
@property (nonatomic,strong)NSString *  lastElementName;

@end

@implementation XMLParserResult
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result=[[NSMutableDictionary alloc]init];
    }
    return self;
}
//-(instancetype)init
//{
//   self=[super init];
//    if(self){
//        self.result=[[NSMutableDictionary alloc]init];
//    }
//    return  self;
//}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    self.lastElementName=elementName;
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([self.lastElementName isEqualToString:@"CharCode"]){
        self.lastCharCode = string;
    }else if([self.lastElementName isEqualToString:@"Nominal"]){
        NSNumber * temp = [NSNumber numberWithFloat:[string floatValue]];
        [self.result setObject:temp forKey:self.lastCharCode];
    }else if([self.lastElementName isEqualToString:@"Value"]){
        float value = [string floatValue];
        NSNumber * nominal = [self.result objectForKey:self.lastCharCode];
        int  simpleNominal = [nominal intValue];
        float  result = value/simpleNominal;
        
        [self.result setObject:@(result) forKey:self.lastCharCode];
    }

}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"DidEndElenemt");
    self.lastElementName=nil;
}

@end
