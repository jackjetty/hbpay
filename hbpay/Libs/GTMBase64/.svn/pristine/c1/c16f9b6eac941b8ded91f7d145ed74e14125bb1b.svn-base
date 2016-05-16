//
//  NSData+GTMBase64.m
//  MemberMarket
//
//  Created by andy on 13-12-3.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSData+GTMBase64.h"
#import "GTMBase64.h"
#import "NSString+GTMBase64.h"


@implementation NSData (GTMBase64)

- (NSString *)encodeBase64Data
{
    NSData *data = [GTMBase64 encodeData:self];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)decodeBase64Data
{
    NSData * data = [GTMBase64 decodeData:self];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

//-(NSString *)encodeHexToDspBase64Data
//{
//    NSString *hexString = [self Hexstring];
//    return [hexString encodeBase64String];
//}
@end
