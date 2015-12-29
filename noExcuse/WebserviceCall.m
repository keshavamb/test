
//
//  WebserviceCall.m
//  WellRight
//
//  Created by Trilok on 06/03/15.
//  Copyright (c) 2014 Trilok. All rights reserved.
//

#import "WebserviceCall.h"
#import "AppDelegate.h"
//#import "LogInViewController.h"
//#import "OMUtil.h"

static WebserviceCall *sharedInstance = nil;
UIActivityIndicatorView *activityIndicator;

@implementation WebserviceCall
@synthesize delegate;
@synthesize tag;

NSMutableData *globalData;
NSURLResponse *getResponse;
NSDictionary *getResponseDict;

+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)callWebserviceWithIdentifier:(NSString *)urlIdentifier andArguments :(NSDictionary *)arguments tokenValue:(NSString *)tokenId
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlIdentifier]];
    [request setTag:tag];
    NSMutableData *myRequestData;
    
    if(arguments)
    {
        NSString* jsonString;
        if ([arguments isKindOfClass:[NSDictionary class]]) {
            jsonString = [arguments JSONRepresentation];
            myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonString length]];
        }else
        {
            NSError *error=nil;
            
            
             //   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arguments options:0 error: &error];
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:&error];
                        //[request appendPostData:jsonData];
            NSLog(@"no Comments\n");
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonData length]];
            
        }
        NSLog(@"json data = %@",jsonString);
        NSLog(@"request data:%@",myRequestData);
        [request setPostBody:myRequestData];
        [request setPostLength:[jsonString length]];
    }
    NSLog(@"url-->%@",urlIdentifier);
    if (tokenId != nil)
    {
        [request addRequestHeader:@"Authorization" value:tokenId];
    }
    
    [request addRequestHeader:@"Content-Type" value:@"Application/json"];
    [request setRequestMethod:@"POST"];
    request.delegate = delegate;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}

-(void)callGetWebserviceWithIdentifier:(NSString *)urlString tokenForAuthentication:(NSString *)tokenId
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setRequestMethod:@"GET"];
    [request setTag:tag];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    NSLog(@"Getting response is working fine");
    if (tokenId != nil)
    {
        [request addRequestHeader:@"Authorization" value:tokenId];
    }
    NSLog(@"No words to explain\n");
    request.delegate = delegate;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}


-(void)callPutServiceWithIdentifier:(NSString *)urlIdentifier andArguments :(NSDictionary *)arguments tokenValue:(NSString *)tokenId
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlIdentifier]];
    [request setTag:tag];
    NSMutableData *myRequestData;
    
    if(arguments)
    {
        NSString* jsonString;
        if ([arguments isKindOfClass:[NSDictionary class]]) {
            jsonString = [arguments JSONRepresentation];
            myRequestData = [NSMutableData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
        }else{
            NSError *error=nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:&error];
            //            [request appendPostData:jsonData];
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonData length]];
        }
        NSLog(@"json data = %@",jsonString);
        [request setPostBody:myRequestData];
        [request setPostLength:[jsonString length]];
    }
    NSLog(@"url-->%@",urlIdentifier);
    if (tokenId != nil)
    {
        [request addRequestHeader:@"Authorization" value:tokenId];
    }
    
    [request addRequestHeader:@"Content-Type" value:@"Application/json"];
    [request setRequestMethod:@"PUT"];
    request.delegate = delegate;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}


-(void)callDeleteWebserviceWithIdentifier:(NSString *)urlString tokenForAuthentication:(NSString *)tokenId
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setRequestMethod:@"DELETE"];
    [request setTag:tag];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    if (tokenId != nil)
    {
        [request addRequestHeader:@"Authorization" value:tokenId];
    }
    request.delegate = delegate;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}


#pragma mark - ASIHTTP DELEGATE
-(void)requestFinished:(ASIHTTPRequest*)response
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(requestFinished:)])
    {
        [self.delegate performSelector:@selector(requestFinished:) withObject:response];
    }
    
}
//This Connection delegate will invoked when responce get Failure
-(void)requestFailed:(ASIHTTPRequest*)response
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(requestFailed:)]){
        [self.delegate performSelector:@selector(requestFailed:) withObject:response];
    }
}



@end
