//
//  ADDeailyCheck.h
//  anbang_ios
//
//  Created by 王奥东 on 16/11/29.
//  Copyright © 2016年 ch. All rights reserved.
//  签到与宝箱整体View

#import <UIKit/UIKit.h>

typedef void(^getNetworkerBlock)();

@interface ADDeailyCheck : UIView

///补签卡数量
@property(nonatomic, assign)NSInteger signCard;
///总积分
@property(nonatomic, assign)NSInteger countScore;
///已经签到的日期
@property(nonatomic, strong)NSArray *listDay;

///当月签到累计次数
@property(nonatomic, strong)NSString *signTotal;
///本月已开宝箱号
@property(nonatomic, strong)NSArray *boxNumber;

//通知父View刷新数据
@property(nonatomic, copy)getNetworkerBlock workerblock;

//是否在获取网络数据
@property(nonatomic, assign)BOOL isNetworker;

- (void)createChestAndWater;

-(void)getNetWorker;//获取网络数据
+(instancetype)sharedSignCheck;//创建单列对象并获取网络数据
-(void)closeCalender:(UIButton *)sender;//关闭按钮
+(void)closeCalender;//关闭日历

@end
