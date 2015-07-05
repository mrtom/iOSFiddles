//
//  FBCeaserCypherTranscoderTestCase.m
//  CeaserFiddle
//
//  Created by Tom Elliott on 14/05/2015.
//  Copyright (c) 2015 telliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "FBBlunkettTranscoder.h"
#import "FBBlunkettPayload.h"

static NSString *const kAckKey = @"ack";

@interface FBCeaserCypherTranscoderTestCase : XCTestCase

@end

@implementation FBCeaserCypherTranscoderTestCase

- (void)setUp
{
  [super setUp];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testEncryptionWithCipyherKeyOfFive
{
  NSString *message = @"Hello World, how's it Hanging?!?";
  NSString *expectedResponse = @"?OTR:eyJ0eXBlIjoiYWNrIiwiYm9keSI6Ik1qcXF0IEJ0d3FpLCBtdGIneCBueSBNZnNsbnNsPyE/In0=.";

  [self _testMessage:message encryptsToString:expectedResponse withCipherKeyOfValue:5];
}

- (void)testDecryptionWithCipherKeyOfFive
{
  NSString *encryptedMessage = @"?OTR:eyJ0eXBlIjoiYWNrIiwiYm9keSI6Ik1qcXF0IEJ0d3FpLCBtdGIneCBueSBNZnNsbnNsPyE/In0=.";
  NSString *expectedPlaintext = @"Hello World, how's it Hanging?!?";
  
  [self _testEncryptedPayload:encryptedMessage decryptsToPlaintext:expectedPlaintext withCipyerKeyOfValue:5];
}

- (void)testEncryptionWithCipyherKeyOfThirteen
{
  NSString *message = @"foo";
  NSString *expectedResponse = @"?OTR:eyJ0eXBlIjoiYWNrIiwiYm9keSI6InNiYiJ9.";
  
  [self _testMessage:message encryptsToString:expectedResponse withCipherKeyOfValue:13];
}

- (void)testDecryptionWithCipherKeyOfThirteen
{
  NSString *encryptedMessage = @"?OTR:eyJ0eXBlIjoiYWNrIiwiYm9keSI6InNiYiJ9.";
  NSString *expectedPlaintext = @"foo";
  
  [self _testEncryptedPayload:encryptedMessage decryptsToPlaintext:expectedPlaintext withCipyerKeyOfValue:13];
}

#pragma mark - Private

- (void)_testMessage:(NSString *)message encryptsToString:(NSString *)expectedPayload withCipherKeyOfValue:(NSUInteger)cipherKeyValue
{
  FBBlunkettTranscoder *transcoder = [[FBBlunkettTranscoder alloc] initWithCipherKey:cipherKeyValue];
  FBBlunkettPayload *payload = [[FBBlunkettPayload alloc] initWithMessageType:kAckKey messageBody:message];
  
  NSString *encodedPayload = [transcoder encryptPayload:payload];
  XCTAssert([encodedPayload isEqualToString:expectedPayload], @"Encoded payload (%@) should match expected response (%@)", encodedPayload, expectedPayload);
}

- (void)_testEncryptedPayload:(NSString *)payload decryptsToPlaintext:(NSString *)plaintext withCipyerKeyOfValue:(NSUInteger)cipherKeyValue
{
  FBBlunkettTranscoder *transcoder = [[FBBlunkettTranscoder alloc] initWithCipherKey:cipherKeyValue];
  FBBlunkettPayload *decryptedPayload = [transcoder decryptPayload:payload];

  NSString *messageBody = [decryptedPayload messageBody];
  XCTAssert([messageBody isEqualToString:plaintext], @"Decoded message (%@) should match expected response (%@)", messageBody, plaintext);
}

@end
