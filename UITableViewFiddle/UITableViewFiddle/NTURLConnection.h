//
//  NTURLConnection.h
//  UITableViewFiddle
//
//  Created by Tom Elliott on 16/12/2013.
//
//

#import <Foundation/Foundation.h>

@interface NTURLConnection : NSURLConnection

@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, copy) void (^onComplete)();
@property(nonatomic, copy) void (^onError)(NSError *error);

@end
