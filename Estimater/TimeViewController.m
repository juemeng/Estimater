//
//  TimeViewController.m
//  Estimater
//
//  Created by 力 邹 on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeViewController.h"
#import "ServiceHelper.h"

@interface TimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userInfo;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UIPickerView *dataSelecter;

@property (weak, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (weak, nonatomic) IBOutlet UIButton *sendEstimate;

@property (strong, nonatomic) NSMutableArray* dataArray;
@end

@implementation TimeViewController
@synthesize userInfo;
@synthesize time;
@synthesize dataSelecter;
@synthesize doneToolbar;
@synthesize sendEstimate;
@synthesize dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closePicker:(UIBarButtonItem *)sender 
{
    [self.time endEditing:YES];
    self.sendEstimate.enabled = YES;
}

- (IBAction)sendEstimateTime:(UIButton *)sender 
{
    ServiceHelper* helper = [ServiceHelper getServiceHelper];

    NSMutableDictionary *dic = [@{@"Voter":[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"],@"Point":self.time.text} mutableCopy];
    
    [helper sendPost:@"http://estimate.offshore3.com/api/point" sendData:dic onCompetion:^(MKNetworkOperation *op) {
    NSString* str = [op responseString];
        if ([str isEqualToString:@"\"Success\""]) {
            [[[UIAlertView alloc] initWithTitle:@"OK" message:@"Send Time Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Server Exception,Please Try Again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
    } onError:^(NSError *error) {
            NSLog(@"%@",error);
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{  
    return 1;  
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{  
    return [self.dataArray count];  
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{  
    return [self.dataArray objectAtIndex:row];  
}  

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // NSLog(@"font %@ is selected.",row);
    self.time.text = [self.dataArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{  
    NSInteger row = [self.dataSelecter selectedRowInComponent:0];  
    self.time.text = [self.dataArray objectAtIndex:row];  
}  

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uName = [userDefault objectForKey:@"userName"];
    self.userInfo.text = [uName stringByAppendingString:@" Please Select Hour"];
    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24", nil];
    self.time.delegate = self;
    self.dataSelecter.delegate = self;
    self.dataSelecter.dataSource = self;
    self.time.inputView = self.dataSelecter;
    self.time.inputAccessoryView = self.doneToolbar;
    self.dataSelecter.frame = CGRectMake(0, 480, 320, 216);
    self.sendEstimate.enabled = NO;
}

- (void)viewDidUnload
{
    [self setUserInfo:nil];
    [self setTime:nil];
    [self setDataSelecter:nil];
    [self setDoneToolbar:nil];
    [self setSendEstimate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
