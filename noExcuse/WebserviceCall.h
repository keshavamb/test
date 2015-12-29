//
//  WebserviceCall.h
//  WellRight
//
//  Created by Trilok on 06/03/15.
//  Copyright (c) 2014 Trilok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "SVProgressHUD.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "NSObject+SBJSON.h"

#define kTimeOutInterval 60

@interface WebserviceCall : NSObject
{

}
+(id)sharedInstance;

//ASIHTTP Methods
//  POST
-(void)callWebserviceWithIdentifier:(NSString *)urlIdentifier andArguments :(NSDictionary *)arguments tokenValue:(NSString *)tokenId;

//  GET
-(void)callGetWebserviceWithIdentifier:(NSString *)urlString tokenForAuthentication:(NSString *)tokenId;

//DELETE
-(void)callDeleteWebserviceWithIdentifier:(NSString *)urlString tokenForAuthentication:(NSString *)tokenId;

//  PUT
-(void)callPutServiceWithIdentifier:(NSString *)urlIdentifier andArguments :(NSDictionary *)arguments tokenValue:(NSString *)tokenId;


@property (nonatomic,assign) int tag;
@property (nonatomic,strong) id delegate;

@end
