//
//  ViewController.m
//  noExcuse
//
//  Created by Admin on 13/12/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "FirstClass.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize string2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"it is working fine");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToSecondPage:(id)sender

{
    FirstClass *tempView = [[FirstClass alloc] initWithNibName:@"First" bundle:nil];
    tempView.string = @"keshav";
//    NSLog(@"name : %@",self.nameTextField.text);
//    tempView.strFullName = self.nameTextField.text;
  //  [self.view addSubview:tempView.view];
    NSLog(@"string is:%@",tempView);
    [self presentViewController:tempView animated:YES completion:nil];
}

@end
