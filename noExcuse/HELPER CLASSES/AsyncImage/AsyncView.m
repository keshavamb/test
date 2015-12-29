//
//  AsyncView.m
//  Bing
//
//  Created by Suhas on 05/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AsyncView.h"

@implementation AsyncView

@synthesize imageData,loadingView,imageUrl,imageView;
@synthesize delegate;
@synthesize tagValue;
#define ActivityIndicatorWidth 40
#define ActivityIndicatorHeight 40

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIActivityIndicatorView *tempLoadingView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width/2)-(ActivityIndicatorWidth/2), (frame.size.height/2)-(ActivityIndicatorHeight/2),ActivityIndicatorWidth ,ActivityIndicatorHeight)]; 
        self.loadingView=tempLoadingView;
        
        
        UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView=tempImageView;
        
        NSMutableData *tempImageData=[[NSMutableData alloc] init];
        self.imageData=tempImageData;
        
        
        [self addSubview:self.loadingView];
        [self.loadingView startAnimating];
        [self addSubview:self.imageView];
        
    }
    return self;
}

#pragma mark- Function
/*!
 @function loadImageWithSitring
 @discussion loads the data from server and assign to image
 @param imageUrlString is the string from where image need to fetch.
 @result No.
 */

-(void) loadImageWithSitring:(NSString*)imageUrlString
{
    if (self.loadingView==nil)
    {
        
        UIActivityIndicatorView *tempLoadingView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(ActivityIndicatorWidth/2), (self.frame.size.height/2)-(ActivityIndicatorHeight/2),ActivityIndicatorWidth ,ActivityIndicatorHeight)];
        
        self.loadingView=tempLoadingView;
        
        
        UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView=tempImageView;
        
        
        NSMutableData *tempImageData=[[NSMutableData alloc] init];
        self.imageData=tempImageData;
        
        
        [self addSubview:self.loadingView];
        [self.loadingView startAnimating];
        [self addSubview:self.imageView];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrlString]];
    NSURLConnection *tempUrlConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.imageUrl=tempUrlConnection;
    
    
}

#pragma mark- NSURLConnection Delegate Method
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
 
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.loadingView stopAnimating];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.loadingView stopAnimating];
    [self.loadingView removeFromSuperview];
    self.imageView.image=[UIImage imageWithData:self.imageData];
    }
#pragma mark-TouchBegain mehtod

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.delegate imageViewCilicked:self.tagValue];
}


@end
