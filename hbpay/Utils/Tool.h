//
//  AttachedCell.h
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Tool : NSObject


+ (Tool *) sharedInstance;


-(BOOL)isLogIn;

-(void)setLongIn:(BOOL)logIn;

-(void)setLeftMoney:(NSString *)leftmoney;

-(NSString *)getLeftMoney;
-(int)getMessageNumber;
-(void)setMessageNumber:(int)messageNumber;

@end

 
