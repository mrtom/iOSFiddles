// Copyright 2004-present Facebook. All Rights Reserved.

#import <Foundation/Foundation.h>

@class FBBlunkettPayload;

@interface FBBlunkettTranscoder : NSObject

@property (nonatomic, assign, readonly) NSUInteger cipherKey;

- (instancetype)initWithCipherKey:(NSUInteger)key NS_DESIGNATED_INITIALIZER;

- (NSString *)encryptPayload:(FBBlunkettPayload *)payload;
- (FBBlunkettPayload *)decryptPayload:(NSString *)encryptedPayload;

@end
