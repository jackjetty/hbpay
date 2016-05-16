//
//  MainCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "TradeCellView.h"
#import "Public.h"
@implementation TradeCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(6, 12, 50, 50)];
        [self.contentView addSubview:_imageIcon];
        
        //名字
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, W(self)-120, 25)];
        _titleLabel.backgroundColor  = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        //简介
        _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 28, W(self)-60, 25)];
        _accountLabel.backgroundColor  = [UIColor clearColor];
        _accountLabel.textColor = [UIColor lightGrayColor];
        _accountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_accountLabel];
        
        
        _balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 48, W(self)-60, 25)];
        _balanceLabel.backgroundColor  = [UIColor clearColor];
        _balanceLabel.textColor = [UIColor lightGrayColor];
        _balanceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_balanceLabel];
        
        
        //网络
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(self)-60, 5, 50, 25)];
        _stateLabel.backgroundColor  = [UIColor clearColor];
        _stateLabel.textColor = [UIColor lightGrayColor];
        _stateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_stateLabel];
        
        //分割线
        _imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(60, 59, 320-60, 1)];
        [self.contentView addSubview:_imageLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)setTradeCellView
{
    
}

@end
