//
//  OMUtil.m
//  Oompfh
//
//  Created by jmohammed on 9/19/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "OMUtil.h"
//#import "MBProgressHUD.h"

@implementation OMUtil

+ (void)showAlertMessageAs:(NSString *)strMsg titleAs:(NSString *)title cancelBtnTitle:(NSString *)str_Cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:strMsg
                                                   delegate:nil
                                          cancelButtonTitle:str_Cancel
                                          otherButtonTitles:nil];
    [alert show];
}

+ (void)showAlertMessageAs:(NSString *)strMsg withDel:(id)del titleAs:(NSString *)title cancelBtnTitle:(NSString *)str_Cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:strMsg
                                                   delegate:del
                                          cancelButtonTitle:str_Cancel
                                          otherButtonTitles:nil];
    [alert show];
}

+ (void)showHUDLoader:(UIView *)onView
{
  //  [MBProgressHUD showHUDAddedTo:onView animated:YES];
}

+ (void)removeHUDLoader:(UIView *)onView
{
   // [MBProgressHUD hideAllHUDsForView:onView animated:YES];
}

+ (void)setRightArrowFor:(UITextField *)txt
{
    //CGRect frame1 = CGRectMake(0,0,30, 30);
    UIImage *img_Arrow = [UIImage imageNamed:@"downbutton1.png"];
   // textField = [[UITextField alloc] initWithFrame:frame1];
    //UIImageView * img_Right =[[UIImageView alloc]initWithFrame:frame1];
   UIImageView *img_Right = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 28,35)];
    
    [img_Right setImage:img_Arrow];
    
    [txt setRightViewMode:UITextFieldViewModeAlways];
    [txt setRightView:img_Right];
}

+ (void)setRightAccViewFor:(UITextField *)txt imageIs:(UIImage *)img
{
    UIImageView *img_Right = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
    [img_Right setImage:img];
    
    [txt setRightViewMode:UITextFieldViewModeAlways];
    [txt setRightView:img_Right];
}

+ (void)sortDateValuesOnKey:(NSString *)strKey sortOrder:(BOOL)isAsce inList:(NSMutableArray *)arr_List
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:strKey ascending:isAsce selector:@selector(compare:)];
    NSArray *arr_Sort = [arr_List sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    [arr_List removeAllObjects];
    [arr_List addObjectsFromArray:arr_Sort];
}

+ (void)sortValuesOnKey:(NSString *)strKey sortOrder:(BOOL)isAsce inList:(NSMutableArray *)arr_List;
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:strKey ascending:isAsce];
    NSArray *arr_Sort = [arr_List sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    [arr_List removeAllObjects];
    [arr_List addObjectsFromArray:arr_Sort];
}

//+ (void)setBackgroundImageForButton:(UIButton *)btn
//{
//    UIImageView *imageView   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
//    imageView.backgroundColor = getColor(40, 158, 159);
//    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = imageView.bounds;
//    UIColor *startColour =[UIColor colorWithWhite:1.0 alpha:0.3];//[UIColor colorWithRed:251.0/255 green:230.0/255 blue:135.0/255 alpha:0.3];
//    UIColor *endColour = [UIColor colorWithWhite:0.0 alpha:0.3];////[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
//    gradient.colors = [NSArray arrayWithObjects:(id)[startColour CGColor], (id)[endColour CGColor], nil];
//    [imageView.layer insertSublayer:gradient atIndex:0];
//    
//    UIGraphicsBeginImageContext(imageView.bounds.size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextFillRect(ctx, imageView.frame);
//    [imageView.layer renderInContext:ctx];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    [btn setBackgroundImage:image forState:UIControlStateNormal];
//    
//    btn.layer.cornerRadius=8.0f;
//    btn.layer.borderColor=[[UIColor colorWithWhite:0.0 alpha:0.2] CGColor];
//    btn.layer.borderWidth=2.0f;
//    btn.clipsToBounds=YES;
//    
//    imageView=nil;
//}

+ (NSDate *)getDateFromString:(NSString *)strDate
{
    NSDateFormatter *dForm = [[NSDateFormatter alloc] init];
    [dForm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dForm dateFromString:strDate];
}

@end
