//
//  FirstClass.m
//  noExcuse
//
//  Created by Admin on 13/12/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "FirstClass.h"
#import "Second.h"
@interface FirstClass ()

@end

@implementation FirstClass
@synthesize  string;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)justGoBoss:(id)sender
{
    
    Second *tempView = [[Second alloc] initWithNibName:@"Second" bundle:nil];
    tempView.string = @"Wattabyte";
    //    NSLog(@"name : %@",self.nameTextField.text);
    //    tempView.strFullName = self.nameTextField.text;
    //  [self.view addSubview:tempView.view];
    NSLog(@"string2 is:%@",tempView);
    [self presentViewController:tempView animated:YES completion:nil];
}
@end
