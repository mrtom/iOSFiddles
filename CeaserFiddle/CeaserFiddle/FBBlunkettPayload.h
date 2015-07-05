// Copyright 2004-present Facebook. All Rights Reserved.

// TODO: This should be a value object when we move into FBOBJC.

#import <Foundation/Foundation.h>

@interface FBBlunkettPayload : NSObject

@property (nonatomic, readonly, copy) NSString *messageType;
@property (nonatomic, readonly, copy) NSString *messageBody;

- (instancetype)initWithMessageType:(NSString *)messageType messageBody:(NSString *)messageBody;

@end
