// Copyright 2004-present Facebook. All Rights Reserved.

#import "FBBlunkettPayload.h"

@implementation FBBlunkettPayload

- (instancetype)initWithMessageType:(NSString *)messageType messageBody:(NSString *)messageBody
{
  if ((self = [super init])) {
    _messageType = [messageType copy];
    _messageBody = [messageBody copy];
  }
  
  return self;
}

@end
