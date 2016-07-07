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
@property (weak, nonatomic) IBOutlet UITextField *rigthValuteTextField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *volutesPickersTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentSummTextField;

@property (weak, nonatomic) IBOutlet UITextField *resultSummTextField;
-(void)configureDatePicker;
-(void) sendGetExchangeRequest;
-(void) configureTextField;
-(void) calculatedResult;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.parserResult=[[XMLParserResult alloc]init];
    self.currentDate= [NSDate date];
    self.dataTextField.text=[self stringFromDate:self.currentDate];
    [self configureDatePicker];
    [self configureTextField];
    [self sendGetExchangeRequest];
    [self configureVolutePicker];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"0" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    self.currentSummTextField.attributedPlaceholder = str;
    

    
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)leftCurrentSummChanged:(id)sender{
    [self calculatedResult];
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
-(void) configureTextField{
    self.leftValuteTextField.text = @"RUB";
    self.rigthValuteTextField.text= @"RUB";
    self.currentSummTextField.text= @"1";
    self.resultSummTextField.text = @"1";
}
-(void) calculatedResult{
    
    NSString *currentValute = self.leftValuteTextField.text;
    NSString *preferredValute= self.rigthValuteTextField.text;
    float currentSumm = [self.currentSummTextField.text floatValue];
    float resultSumm = ([[self.parserResult.result objectForKey:currentValute] floatValue]/[[self.parserResult.result objectForKey:preferredValute] floatValue])*currentSumm;
    self.resultSummTextField.text= [@(resultSumm) stringValue];
   
}
-(void) configureDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc ] init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor lightGrayColor];
    self.dataTextField.inputAccessoryView = datePicker;
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
    [self sendGetExchangeRequest];
    
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
        [self calculatedResult];
        });
    }];
    
    
    [task resume];
}
-(void) onDateValueChanged:(id)sender{
    self.currentDate=[(UIDatePicker *)sender date];
    [self sendGetExchangeRequest];
    self.dataTextField.text=[self stringFromDate:self.currentDate];
    [self calculatedResult];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self calculatedResult];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awake from  nib");
}



@end
