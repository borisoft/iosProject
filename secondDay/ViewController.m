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
@property (strong,nonatomic) UITextField *activeTextField;
@property (weak, nonatomic) IBOutlet UITextField *leftValuteTextField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *volutesPickersTextField;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.parserResult=[[XMLParserResult alloc]init];
    self.currentDate= [NSDate date];
    self.dataTextField.text=[self stringFromDate:self.currentDate];
    [self configureDatePicker];
    [self sendGetExchangeRequest];
    [self configureVolutePicker];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NSString *) stringFromDate:(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    return [dateFormatter stringFromDate:date];
}
-(void)configureVolutePicker{
    for (UITextField *textField in  self.volutesPickersTextField){
        UIPickerView * picker = [[UIPickerView alloc]init];
        picker.delegate = self;
        picker.backgroundColor = [UIColor lightGrayColor];
        
        textField.inputAccessoryView=picker;
        textField.delegate =self;
    }
}
-(void) configureDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc ] init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    self.dataTextField.inputAccessoryView=datePicker;
    [datePicker addTarget:self action:@selector(onDateValueChanged:) forControlEvents:UIControlEventValueChanged];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.parserResult.result.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *keys = [self.parserResult.result allKeys];
    
    return keys[row];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeTextField=textField;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *keys = [self.parserResult.result allKeys];
    self.activeTextField.text =keys[row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//метод вызывается  перед заполнением  объекта  контроллера

-(void)updatePopularRates{
    self.labelUSD.text=[NSString stringWithFormat:@"USD: %@",[[self.parserResult.result objectForKey:@"USD"] stringValue]];
    self.labelEUR.text = [NSString stringWithFormat:@"EUR: %@",[self.parserResult.result[@"EUR"] stringValue]];
}
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updatePopularRates];

        });
    }];
    
    
    [task resume];
}
-(void) onDateValueChanged:(id)sender{
    self.currentDate=[(UIDatePicker *)sender date];
    [self sendGetExchangeRequest];
    self.dataTextField.text=[self stringFromDate:self.currentDate];
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
