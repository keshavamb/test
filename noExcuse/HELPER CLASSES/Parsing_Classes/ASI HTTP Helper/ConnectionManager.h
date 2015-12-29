//
//  ConnectionManager.h
//  ASISample
//
//  Created by smartData.
//  Copyright (c) 2013 smartData. All rights reserved.
//

#import <Foundation/Foundation.h>


// This Typed enum is used for all web services tag
typedef enum
{
    TASK_USER_LOGIN = 100,
    TASK_FORGOT_PASSWORD = 101,
    TASK_UPDATE_USER_SETTINGS = 102,
    TASK_GET_SHOP_LIST = 103,
    TASK_FEEDBACK_TO_SERVER = 104,
    TASK_SUBMIT_SHOPPING_LIST_UPDATE = 105,
    TASK_SUBMIT_INGREDIENTS_DATA_UPDATE = 106,
    TASK_LOGOUT_USER = 107,
    TASK_SUBMIT_SHOPPING_LIST_UPDATE_DESELECT = 108,
    TASK_ALLINGRE_SHOPPING_LIST = 109,
    TASK_GET_SUPPORT_URL = 110,

}CURRENT_TASK;


@protocol ConnectionManagerDelegate <NSObject>
@end

@interface ConnectionManager : NSObject
{
    NSMutableData *responseData;
    NSString *responseString;
    NSURLConnection *requestConnection;
    CURRENT_TASK currentTask;
}

@property (nonatomic, assign) CURRENT_TASK currentTask;
@property (nonatomic, assign) id<ConnectionManagerDelegate> delegate;
@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) NSString *responseString;



///This method is used for calling User Login Webservice
-(void)sendRequestWithURL:(NSString*)strURL andPostBodyForUserLogin:(id)diPcaram withTag:(CURRENT_TASK)task;

-(void)getInformationForURL:(NSString*)strURL withTag:(CURRENT_TASK)task;
-(void)uploadReportFileWithURL:(NSString*)strURL andDictionary:(NSMutableDictionary *)reportDict VideoData:(NSData *)video withTag:(CURRENT_TASK)task;
///This method is used for  audio File uploading
-(void)uploadAudioFile:(NSString *)filePath withURL:(NSString*)strURL withTag:(CURRENT_TASK)task withExercises:(NSString *)exercises_Id;
@end
