//
//  SelectITTViewController.m
//  Estimater
//
//  Created by 力 邹 on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectITTViewController.h"

@interface SelectITTViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;

@end

@implementation SelectITTViewController
@synthesize userName;

- (IBAction)startEstimate:(UIButton *)sender 
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if(self.userName.text.length > 0)
    {
        [userDefault setObject:self.userName.text forKey:@"userName"];
        [self performSegueWithIdentifier:@"time" sender:self];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@" UserName Should Not Null!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)exitInput:(UITextField *)sender 
{
    [sender resignFirstResponder];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *uName = [userDefault objectForKey:@"userName"];
    if(uName)
    {
        [self performSegueWithIdentifier:@"time" sender:self];
    }
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
