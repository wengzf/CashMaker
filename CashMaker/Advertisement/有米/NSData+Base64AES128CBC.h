//
//  NSData+Base64AES128CBC.h
//  demo
//
//  Created by 翁志方 on 16/5/18.
//  Copyright © 2016年 dianjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (Base64)

+ (NSData *)dataFromBase64String:(NSString *)aString;

- (NSString *)base64EncodedString;

- (NSString *)base64EncodedStringWithSeparateLines:(BOOL)separateLines; - (NSData *)AES128EncryptWithKey:(NSString *)key;

- (NSData *)AES128DecryptWithKey:(NSString *)key;

@end