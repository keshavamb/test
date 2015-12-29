//
//  NSObject+FBJSON.h
//  MyLiveTrainer
//
//  Created by Kuldeep Saini on 13/09/13.
//  Copyright (c) 2013 smartData Enterprizes . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FBJSON)

/**
 @brief Returns a string containing the receiver encoded as a JSON fragment.
 
 This method is added as a category on NSObject but is only actually
 supported for the following objects:
 @li NSDictionary
 @li NSArray
 @li NSString
 @li NSNumber (also used for booleans)
 @li NSNull
 
 @deprecated Given we bill ourselves as a "strict" JSON library, this method should be removed.
 */
- (NSString *)JSONFragment;

/**
 @brief Returns a string containing the receiver encoded in JSON.
 
 This method is added as a category on NSObject but is only actually
 supported for the following objects:
 @li NSDictionary
 @li NSArray
 */
- (NSString *)JSONRepresentation;

@end
