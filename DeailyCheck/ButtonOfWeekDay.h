//
//  ButtonOfWeekDay.h
//  签到原型
//
//  Created by 王奥东 on 16/11/22.
//  Copyright © 2016年 王奥东. All rights reserved.
//  签到日历中的每个日期按钮

#import <UIKit/UIKit.h>
#import "BoxView.h"
@class ButtonOfWeekDay;

@protocol buttonIsRetroactive <NSObject>

-(void)buttonIsRetroactive:(ButtonOfWeekDay *)button BOOL:(BOOL)isRetro;


@end
//按钮的状态
typedef NS_ENUM(NSUInteger, ButtonState) {
    ///普通，未签到
    buttonStateNormal = 1,
    ///选中，已签到
    buttonStateSelected,
    ///可以补签
    buttonStateRetroactive,
    ///不能点击
    buttonStateUnableSelected
};

@interface ButtonOfWeekDay : UIButton

///代表按钮是几月几号
@property(nonatomic, assign)NSUInteger monthDay;
///代表按钮是几号
@property(nonatomic, assign)NSInteger day;
///代表按钮是周几
@property(nonatomic, assign)NSInteger weekDays;
///代表按钮的状态
@property(nonatomic, assign)ButtonState currentState;
///代表按钮是几倍积分
@property(nonatomic, assign)int currentIntegral;
//当按钮是赎回状态被点击时
@property(nonatomic, weak)id <buttonIsRetroactive>btnDelegate;
//进度条
@property (nonatomic,strong)BoxView *boxView;
//累计签到次数
@property(nonatomic, assign)NSInteger signTotal;
//开宝箱个数
@property (nonatomic,strong)NSArray *boxNumb;

//提示签到成功
-(void)signInSucceed;

@end
