//
//  Second.m
//  noExcuse
//
//  Created by Admin on 13/12/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import "Second.h"
#import "FirstClass.h"
@implementation Second
@synthesize string;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"entered data is:%@",string);
}
- (IBAction)goBackToFirst:(id)sender {
     FirstClass *tempView = [[FirstClass alloc] initWithNibName:@"First" bundle:nil];
    tempView.string = @"Wattabyte";
    //    NSLog(@"name : %@",self.nameTextField.text);
    //    tempView.strFullName = self.nameTextField.text;
    //  [self.view addSubview:tempView.view];
    NSLog(@"string2 is:%@",tempView);
    [self presentViewController:tempView animated:YES completion:nil];

}
@end
