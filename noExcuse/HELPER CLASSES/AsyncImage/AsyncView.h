//
//  AsyncView.h
//  Bing
//
//  Created by Suhas on 05/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AsynImageViewDelegate

-(void) imageViewCilicked;
@end

@interface AsyncView : UIView

@property (nonatomic,retain) NSMutableData *imageData;
@property (nonatomic,retain) UIActivityIndicatorView *loadingView;
@property (nonatomic,retain) NSURLConnection *imageUrl;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,assign) id <AsynImageViewDelegate> delegate;
@property (nonatomic,assign) int tagValue;

/*!
 \internal
 @function loadImageWithSitring
 @discussion loads the data from server and assign to image
 @param imageUrlString is the string from where image need to fetch.
 */
-(void) loadImageWithSitring:(NSString*)imageUrlString;
@end
