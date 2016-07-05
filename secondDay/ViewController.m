//
//  ViewController.m
//  secondDay
//
//  Created by alex on 29.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "ViewController.h"
#import "XMLParserResult.h"

@interface ViewController ()
@property (strong,nonatomic) XMLParserResult *parserResult;
@property (strong,nonatomic) NSXMLParser *xmlParser;
@property (weak, nonatomic) IBOutlet UITextField *leftValuteTextField;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.parserResult=[[XMLParserResult alloc]init];
    UIDatePicker * dataPicker = [[UIDatePicker alloc]init];

    dataPicker.backgroundColor=[UIColor lightGrayColor];
    
    self.leftValuteTextField.inputAccessoryView=dataPicker;
    [self sendGetExchangeRequest];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//метод вызывается  перед заполнением  объекта  контроллера


- (void)sendGetExchangeRequest{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.cbr.ru/scripts/XML_daily.asp?date_req=28/06/2016"];
    NSURLSessionDataTask *task =[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.xmlParser= [[NSXMLParser alloc]initWithData:data];
        NSString *result = [[NSString alloc] initWithData: data encoding:NSWindowsCP1251StringEncoding];
        NSLog(@"recieved response : %@ ", result);
        
        self.xmlParser.delegate = self.parserResult;
        BOOL res= [self.xmlParser parse];
        
        NSLog(@" Parse Result  %c",res);
        
    }];
    
    
    [task resume];
}



//- (void)printResultDictionary {
//    [self.valutes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"key: %@, value: %@", key, [obj stringValue]);
//    }];
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awake from  nib");
}



@end
