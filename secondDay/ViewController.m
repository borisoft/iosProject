//
//  ViewController.m
//  secondDay
//
//  Created by alex on 29.06.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "ViewController.h"
#import "XMLParserResult.h"


 NSString *const kParserURL = @"http://www.cbr.ru/scripts/XML_daily.asp?date_req=%@";
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelUSD;
@property (strong,nonatomic) XMLParserResult *parserResult;
@property (weak, nonatomic) IBOutlet UILabel *labelEUR;
@property (weak, nonatomic) IBOutlet UITextField *dataTextField;
@property (strong,nonatomic) NSXMLParser *xmlParser;
@property (strong,nonatomic) NSDate * currentDate;
@property (weak, nonatomic) IBOutlet UITextField *leftValuteTextField;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.parserResult=[[XMLParserResult alloc]init];
    self.currentDate= [NSDate date];
    [self configureDatePicker];
    [self sendGetExchangeRequest];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NSString *) stringFromDate:(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    return [dateFormatter stringFromDate:date];
}
-(void) configureDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc ] init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    self.dataTextField.inputAccessoryView=datePicker;
    [datePicker addTarget:self action:@selector(onDateValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//метод вызывается  перед заполнением  объекта  контроллера


- (void)sendGetExchangeRequest{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString * urlString = [NSString stringWithFormat:kParserURL,[self stringFromDate:self.currentDate]];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
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
-(void) onDateValueChanged:(id)sender{
    self.currentDate=[(UIDatePicker *)sender date];
    
    
    [self sendGetExchangeRequest];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awake from  nib");
}



@end
