//
//  ConnectionManager.m
//  ASISample
//
//  Created by Kuldeep Saini on 24/06/13.
//  Copyright (c) 2013 Kuldeep Saini. All rights reserved.
//

#import "ConnectionManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSObject+FBJSON.h"
@implementation ConnectionManager
@synthesize delegate;
@synthesize responseData;
@synthesize responseString;
@synthesize currentTask;

// This is used for giving limit of web service responce
#define kTimeOutInterval 1800


///This method is used for calling event Login Webservice
-(void)sendRequestWithURL:(NSString*)strURL andPostBodyForUserLogin:(id)diPcaram withTag:(CURRENT_TASK)task
{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
    [request setDelegate:self];
    [request setTag:task];
    NSMutableData *myRequestData;
    
    if(diPcaram)
    {
        NSString* jsonString;
        if ([diPcaram isKindOfClass:[NSDictionary class]])
        {
            jsonString = [diPcaram JSONRepresentation];
            myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonString length]];
        }
        else
        {
            NSError *error=nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:diPcaram options:NSJSONWritingPrettyPrinted error:&error];
            [request appendPostData:jsonData];
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonData length]];
        }
        NSLog(@"json data = %@",jsonString);
        [request setPostBody:myRequestData];
        [request setPostLength:[jsonString length]];
    }
    
    [request addRequestHeader:@"Content-Type" value:@"Application/json"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}



///This method is used for  audio File uploading
-(void)uploadAudioFile:(NSString *)filePath withURL:(NSString*)strURL withTag:(CURRENT_TASK)task withExercises:(NSString *)exercises_Id
{
    NSString *audioFilePath = filePath; // local path where audio stored
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:audioFilePath];
    NSString *audioName =@"sound.caf";

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
    [request addData:audioData withFileName:audioName andContentType:@"audio/caf" forKey:@"voice_recorder"];
    [request setPostValue:exercises_Id forKey:@"exercise_id"];
    [request setDelegate:self];
    [request setTag:task];
    [request setRequestMethod:@"POST"];
    [request setDownloadProgressDelegate:self];
    request.showAccurateProgress = YES;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}
-(void)uploadReportFileWithURL:(NSString*)strURL andDictionary:(NSMutableDictionary *)reportDict VideoData:(NSData *)video withTag:(CURRENT_TASK)task
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
    if ([video length]) {
        [request setData:video withFileName:@"ReportVideo.mov" andContentType:@"multipart/form-data" forKey:@"video"];
        [[[reportDict objectForKey:@"ReportDetails"] objectAtIndex:0] removeObjectForKey:@"video"];
    }
    NSString *jsonString = [reportDict JSONRepresentation];
    NSMutableData* myRequestData = [ NSMutableData dataWithBytes: [ jsonString UTF8String ] length: [ jsonString length]];
    NSLog(@"json data = %@",jsonString);
    [request setPostBody:myRequestData];
    [request setPostLength:[jsonString length]];
    [request setDelegate:self];
    [request setTag:task];
    [request setRequestMethod:@"POST"];
    [request setDownloadProgressDelegate:self];
    request.showAccurateProgress = YES;
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];
}

-(void)getInformationForURL:(NSString*)strURL withTag:(CURRENT_TASK)task{
    NSLog(@"url-->%@",strURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
    [request setRequestMethod:@"GET"];
    [request setTag:task];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setDelegate:self];
    [request setTimeOutSeconds:kTimeOutInterval];
    [request startAsynchronous];

}

- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength
{
    NSLog(@"newLength: %lld", newLength);
}

-(void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes {
    NSLog(@"Received bytes:%lld",bytes);
    
}
//-(void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
//{
//    NSLog(@"dsfas");
//}

//This Connection delegate will invoked when responce get Success
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
//This is converts audio File to Base64Encode
- (NSString*)base64forData:(NSData*)theData {
	
	const uint8_t* input = (const uint8_t*)[theData bytes];
	NSInteger length = [theData length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
	NSInteger i,i2;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
		for (i2=0; i2<3; i2++) {
            value <<= 8;
            if (i+i2 < length) {
                value |= (0xFF & input[i+i2]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}

@end
