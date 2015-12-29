//
//  NSObject+FBJSON.m
//  MyLiveTrainer
//
//  Created by Kuldeep Saini on 13/09/13.
//  Copyright (c) 2013 smartData Enterprizes . All rights reserved.
//

#import "NSObject+FBJSON.h"
#import "FBSBJsonWriter.h"
@implementation NSObject (FBJSON)

 
- (NSString *)JSONFragment {
    FBSBJsonWriter *jsonWriter = [FBSBJsonWriter new];
    NSString *json = [jsonWriter stringWithFragment:self];
    if (!json)
        NSLog(@"-JSONFragment failed. Error trace is: %@", [jsonWriter errorTrace]);
    return json;
}

- (NSString *)JSONRepresentation {
    FBSBJsonWriter *jsonWriter = [FBSBJsonWriter new];
    NSString *json = [jsonWriter stringWithObject:self];
    if (!json)
        NSLog(@"-JSONRepresentation failed. Error trace is: %@", [jsonWriter errorTrace]);
     return json;
}

@end
