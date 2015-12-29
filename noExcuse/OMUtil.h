//
//  OMUtil.h
//  Oompfh
//
//  Created by jmohammed on 9/19/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface OMUtil : NSObject

+ (void)showAlertMessageAs:(NSString *)strMsg titleAs:(NSString *)title cancelBtnTitle:(NSString *)str_Cancel;
+ (void)showAlertMessageAs:(NSString *)strMsg withDel:(id)del titleAs:(NSString *)title cancelBtnTitle:(NSString *)str_Cancel;

+ (void)showHUDLoader:(UIView *)onView;
+ (void)removeHUDLoader:(UIView *)onView;
+ (void)setRightArrowFor:(UITextField *)txt;
+ (void)setRightAccViewFor:(UITextField *)txt imageIs:(UIImage *)img;
+ (void)sortDateValuesOnKey:(NSString *)strKey sortOrder:(BOOL)isAsce inList:(NSMutableArray *)arr_List;
+ (void)sortValuesOnKey:(NSString *)strKey sortOrder:(BOOL)isAsce inList:(NSMutableArray *)arr_List;

+ (void)setBackgroundImageForButton:(UIButton *)btn;

+ (NSDate *)getDateFromString:(NSString *)strDate;

@end
