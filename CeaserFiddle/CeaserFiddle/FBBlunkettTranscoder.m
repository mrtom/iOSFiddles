// Copyright 2004-present Facebook. All Rights Reserved.

#import "FBBlunkettTranscoder.h"

#import "FBBlunkettPayload.h"

static unichar const kDevisor = 26;
static unichar const kLowerCaseOffset = 97;
static unichar const kUpperCaseOffset = 65;

static NSString *const kPrefix = @"?OTR:";
static NSString *const kSuffix = @".";

static NSString *const kTypeKey = @"type";
static NSString *const kBodyKey = @"body";

@implementation FBBlunkettTranscoder

- (instancetype)initWithCipherKey:(NSUInteger)key
{
  if (self = [super init]) {
    _cipherKey = key;
  }
  return self;
}

#pragma mark - Public API

- (NSString *)encryptPayload:(FBBlunkettPayload *)payload
{
  NSString *encryptedMessageBody = [self _encryptMessageBody:[payload messageBody]];
  
  // TODO: Error handling
  NSError *error;
  NSDictionary *payloadDict = @{
                                kBodyKey: encryptedMessageBody,
                                kTypeKey: [payload messageType],
                                };
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDict
                                                     options:0
                                                       error:&error];
  NSString *jsonPayload = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  return [self _encodePayload:jsonPayload];
}

- (FBBlunkettPayload *)decryptPayload:(NSString *)encryptedPayload
{
  NSString *decodedPayload = [self _decodePayload:encryptedPayload];
  
  // TODO: Error handling
  NSError *error;
  NSData *encryptedData = [decodedPayload dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *jsonPayload = [NSJSONSerialization JSONObjectWithData:encryptedData options:0 error:&error];
  
  NSString *messageType = jsonPayload[kTypeKey];
  NSString *messageBody = jsonPayload[kBodyKey];
  
  NSAssert([messageType length] > 0, @"Message type required");
  NSAssert([messageBody length] > 0, @"Message body required");
  
  NSString *decryptedMessageBody = [self _decryptMessageBody:messageBody];
  
  return [[FBBlunkettPayload alloc] initWithMessageType:messageType messageBody:decryptedMessageBody];
}

#pragma mark - Private

- (NSString *)_encodePayload:(NSString *)payload
{
  NSData *plainData = [payload dataUsingEncoding:NSUTF8StringEncoding];
  NSString *base64Message = [plainData base64EncodedStringWithOptions:0];
  
  return [NSString stringWithFormat:@"%@%@%@", kPrefix, base64Message, kSuffix];;
}

- (unichar)_encryptChar:(unichar)character
{
  unichar shiftedChar = character + _cipherKey;
  
  // Lowercase a..z
  if (character > 96 && character < 123) {
    return ((shiftedChar - kLowerCaseOffset) % kDevisor) + kLowerCaseOffset;
  }
  
  // Uppercase A..Z
  else if (character > 64 && character < 91) {
    return ((shiftedChar - kUpperCaseOffset) % kDevisor) + kUpperCaseOffset;
  }
  // Otherwise, don't encrypt
  else {
    return character;
  }
}

- (NSString *)_encryptMessageBody:(NSString *)messageBody
{
  NSUInteger size = [messageBody length];
  unichar char_message[size];
  for (NSUInteger i = 0; i < [messageBody length]; i++){
    char character = [messageBody characterAtIndex:i];
    char_message[i] = [self _encryptChar:character];
  }
  
  return [[NSString alloc] initWithCharacters:char_message length:size];
}

- (NSString *)_decodePayload:(NSString *)payload
{
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\?OTR:(.*)\\.$" options:0 error:&error];
  NSArray *matches = [regex matchesInString:payload options:0 range:NSMakeRange(0, [payload length])];
  NSUInteger matchCount = [matches count];
  
  NSAssert(error == NULL, @"There was an error matching the required format");
  NSAssert(matchCount == 1, @"There was an error matching the required format");
  
  for (NSTextCheckingResult *match in matches) {
    NSRange matchRange = [match rangeAtIndex:1];
    NSString *matchString = [payload substringWithRange:matchRange];
    NSLog(@"%@", matchString);
  }
  
  NSRange matchRange = [[matches objectAtIndex:0] rangeAtIndex:1];
  NSString *base64EncodedString = [payload substringWithRange:matchRange];
  
  NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:0];
  NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
  
  return decodedString;
}

- (NSString *)_decryptMessageBody:(NSString *)messageBody
{
  NSUInteger size = [messageBody length];
  unichar char_message[size];
  for (NSUInteger i = 0; i < [messageBody length]; i++){
    char character = [messageBody characterAtIndex:i];
    char_message[i] = [self _decryptChar : character];
  }
  
  return [[NSString alloc] initWithCharacters:char_message length:size];
}

- (unichar)_decryptChar:(unichar)character
{
  unichar shiftedChar = character - _cipherKey;

  // Lowercase a - z with positive shifted char:
  if (character > 96 && character < 123 && shiftedChar - kLowerCaseOffset >= 0) {
    return (shiftedChar - kLowerCaseOffset) % kDevisor + kLowerCaseOffset;
  }
  
  // Lowercase a - z with negative shifted char:
  else if (character > 96 && character<123) {
    return ((shiftedChar - kLowerCaseOffset + kDevisor) % kDevisor) + kLowerCaseOffset;
  }
  
  // Uppercase A..Z and with positive shifted char:
  else if (character > 64 && character < 91 && ((shiftedChar - kLowerCaseOffset) >= 0)) {
    return ((shiftedChar - kUpperCaseOffset) % kDevisor) + kUpperCaseOffset;
  }
  
  // Uppercase A..Z with negative shifted char:
  else if (character > 64 && character < 91) {
    return ((shiftedChar - kUpperCaseOffset + kDevisor) % kDevisor) + kUpperCaseOffset;
  }
  
  // Otherwise, don't decrypt
  else {
    return character;
  }
}

@end
