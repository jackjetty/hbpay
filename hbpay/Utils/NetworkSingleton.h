//
//  NetworkSingleton.h
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h" 
#import "MJExtension.h"
//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);



@interface NetworkSingleton : NSObject

+(NetworkSingleton *)sharedManager;
-(AFHTTPRequestOperationManager *)baseHtppRequest;

- (BOOL)isConnectionAvailable;
- (NSString *) decodeResponse:(NSData *)responseObject;

#pragma mark 获取加载主页
-(void)getHomeResule:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取视频详情页
-(void)getMessage:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取分类信息
-(void)getFaq:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取订阅信息
-(void)userLogin:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;




#pragma mark 获取推荐信息
-(void)getSMSCode:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取频道信息
-(void)checkSMSCode:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取最新视频信息
-(void)changePassword:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取最热视频信息
-(void)userRegister:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;



#pragma mark 获取栏目信息
-(void)feedBack:(NSDictionary *)paraInfo  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;




#pragma mark 获取历史记录信息
-(void)getTradeList:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;




#pragma mark 获取发现信息
-(void)userRebate:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)takeOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)qcoinPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)takeMonthOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

 

-(void)qmonthPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


 
-(void)qmonthInfo:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)cancelMonthOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


-(void)cancelMonthPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

-(void)takeMemberOrder:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


-(void)qmemberPay:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


-(void)getLeftMoney:(NSDictionary *)paraInfo   successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


@end
