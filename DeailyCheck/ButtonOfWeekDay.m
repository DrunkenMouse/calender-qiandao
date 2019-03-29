//
//  ButtonOfWeekDay.m
//  签到原型
//
//  Created by 王奥东 on 16/11/22.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ButtonOfWeekDay.h"
#import "MBProgressHUD.h"
#import "AIBangHttpTool.h"
@interface ButtonOfWeekDay ()
@property(nonatomic,assign)NSInteger clickCount;
@end
@implementation ButtonOfWeekDay {
    
//    UIView * _maskView;//不能签到时的蒙版,目前选择直接修改自身透明度,后期可能需要
    
    UIView *_retroactiveView;//补签时弹出的选择框
    UIView *_retroactiveBackView;//补签时的背景
    BOOL _isRetroactiveCard;//积分卡是否可用
    BOOL _isGoldCoin;//金币是否可用
    
    UIButton *_selectedButton;//补签时选择的卡
    UIView *_succeedView;//签到成功View
    
    UIView *_errorView;//补签失败
    
}

//设置按钮代表几号
-(void)setDay:(NSInteger)day {
    //保存日期号
    _day = day;
    
    //6号3倍积分、11号4倍积分、20号5倍积分、28号6倍积分、其它是1倍积分
    switch (day) {
        case 6:
            self.currentIntegral = 3;
            break;
            
        case 11:
            self.currentIntegral = 4;
            break;
        
        case 20:
            self.currentIntegral = 5;
            break;
        
        case 28:
            self.currentIntegral = 6;
            break;
            
        default:
            self.currentIntegral = 1;
            break;
    }
    
}

//设置按钮状态
-(void)setCurrentState:(ButtonState)currentState {
    
    _currentState = currentState;
    
    //普通状态的图片名称
    NSString *integralImgStr = [NSString stringWithFormat:@"%dbeijinbi",self.currentIntegral];
    
    //已签到的图片
    UIImageView *successImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 27, self.bounds.size.height-20, 27, 20)];
    successImg.image = [UIImage imageNamed:@"yiqiandao"];
    
    //不能选择的蒙版,目前选择直接修改自身透明度,后期可能需要
//    UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
//    maskView.backgroundColor = [UIColor grayColor];
//    maskView.alpha = 0.5;
//    _maskView = maskView;
    
    
    
    switch (currentState) {
            
        //移除蒙版
//        if (_maskView) {
//            [_maskView removeFromSuperview];
//        }
            
        self.layer.borderWidth = 0;
        //普通状态设置普通图片
        case buttonStateNormal:
            
            [self setImage:[UIImage imageNamed:integralImgStr] forState:UIControlStateNormal];
            break;
            
        //选中状态移除旧图片，增加选中图片,设置背后Label
        case buttonStateSelected:
            [self setImage:nil forState:UIControlStateNormal];
            [self addSubview:successImg];
            [self setBackTitle];
            //补签或签到成功后不允许点击
            self.userInteractionEnabled = NO;
            break;
            
           
       //可以补签时添加一个边框
        case buttonStateRetroactive:
            self.layer.borderColor = AB_Color_ffe800.CGColor;
            self.layer.borderWidth = 1.5;
            self.layer.cornerRadius = 5;
            [self.layer masksToBounds];
//            [self retroactiveMessage];
            [self addTarget:self action:@selector(clickRetroactive) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        //补签时不能签到就添加透明蒙版
        case buttonStateUnableSelected:
//           [self addSubview:_maskView];
            self.alpha = 0.5;
            break;
            
    }
    
}



//设置图片背后的日期提示
-(void)setBackTitle{
    
    
    //设置日期号与颜色
    NSString *dayTitle = [NSString stringWithFormat:@"%d",(int)self.day];
    
    [self setTitle:dayTitle forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"kong"] forState:UIControlStateNormal];
    
    [self setTintColor:[UIColor whiteColor]];
    
    [self setFont:[UIFont boldSystemFontOfSize:17]];
    
   
    
}

#pragma mark - 签到成功
-(void)signInSucceed {
    
    if (_retroactiveBackView) {
        [_retroactiveBackView removeFromSuperview];
        _retroactiveBackView = nil;
    }
    if (_retroactiveView) {
        [_retroactiveView removeFromSuperview];
        _retroactiveView = nil;
    }
    
    //图片名称
    NSString *imgName = [NSString stringWithFormat:@"gongxi%djifen",_currentIntegral];
    
    //创建成功提示View
    UIView *succeedView = [[UIView alloc] initWithFrame:CGRectMake(23+21, 117, 240.5, 200)];
    _succeedView = succeedView;
    //按钮的父View是日历，日历的父View是日历所在的View,位于今日签到按钮的上一级。
    [self.superview.superview  addSubview:_succeedView];
    
    //成功图片
    UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    [_succeedView addSubview:succeedImgView];
    
    //确定按钮
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(succeedView.frame.size.width/2-65.6/2, succeedView.frame.size.height-12-23.5, 65.6, 23.5)];
    [sureButton setImage:[UIImage imageNamed:@"buqianqueding"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(succeedSure:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userInteractionEnabled = NO;
    
    [_succeedView addSubview:sureButton];
    
}

#pragma mark - 签到成功，恭喜页面的确认
-(void)succeedSure:(UIButton *)sender {
    
   
    [_succeedView removeFromSuperview];
    _succeedView = nil;

}


#pragma mark - 补签时点击本按钮
-(void)clickRetroactive{
    
    self.userInteractionEnabled = NO;
    [MBProgressHUD showHUDAddedTo:self  animated:YES];
    if ([self.btnDelegate respondsToSelector:@selector(buttonIsRetroactive:BOOL:)]) {
        [self.btnDelegate buttonIsRetroactive:self BOOL:true];
    }
    //获取接口数据
    NSString *url = [NSString stringWithFormat:@"https://%@/profiles/integral/queryIntegral",PersonalAccount];

    NSString *userName = MY_USER_NAME;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"mytoken"];
    NSDictionary *dict = @{@"username":userName?userName:@"",@"token":token?token:@""};
    [AIBangHttpTool postWithURL:url params:dict success:^(id json) {
        
        [MBProgressHUD hideHUDForView:self  animated:YES];
        self.userInteractionEnabled = YES;
        if ([self.btnDelegate respondsToSelector:@selector(buttonIsRetroactive:BOOL:)]) {
            [self.btnDelegate buttonIsRetroactive:self BOOL:false];
        }
        NSDictionary *jsonDict = (NSDictionary *)json;
        
        //rstCode为0代表请求错误
        NSString *rstCode = [NSString stringWithFormat:@"%@",jsonDict[@"retcode"]];
        
        if ([rstCode isEqualToString:@"0"]) {
            [AIControllersTool tipViewShow:@"数据请求失败！"];
            return;
        }
        //补签卡数量
       NSString *signCard = [NSString stringWithFormat:@"%@",jsonDict[@"signCard"]];
        if ([signCard integerValue] > 0) {
            _isRetroactiveCard = true;
        }else {
            _isRetroactiveCard = false;
        }
        //个人总积分
        NSString * countScore = [NSString stringWithFormat:@"%@",jsonDict[@"countScore"]];
        if ([countScore integerValue]>=5) {
            _isGoldCoin = true;
        }else {
            _isGoldCoin = false;
        }
        
        [self canRetroactive];
    }failure:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [MBProgressHUD hideHUDForView:self  animated:YES];
        if ([self.btnDelegate respondsToSelector:@selector(buttonIsRetroactive:BOOL:)]) {
            [self.btnDelegate buttonIsRetroactive:self BOOL:false];
        }
        [AIControllersTool tipViewShow:@"数据请求失败！"];
        
    }];
    
    
 
}

#pragma mark - 可以补签
-(void)canRetroactive {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KCurrWidth, KCurrHeight)];
    backView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    _retroactiveBackView = backView;
    //按钮的父View是日历，日历的父View是日历所在的View,位于今日签到按钮的上一级。
    [self.superview.superview addSubview:backView];
    
    //距离阴影边框距离21
    UIView *baskView = ({
        
        UIView *tempBaskView = [[UIView alloc] initWithFrame:CGRectMake(23+21, 133+21, 240.5, 190.5)];
        tempBaskView.userInteractionEnabled = YES;
        UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dakuang"]];
        backImgView.userInteractionEnabled = YES;
        [tempBaskView addSubview:backImgView];
        
        //选择补签卡
        UIButton *retroactiveCardBtn  = [[UIButton alloc] initWithFrame:CGRectMake(17, 12, 99, 130)];
        if (_isRetroactiveCard) {
            
            [retroactiveCardBtn setImage:[UIImage imageNamed:@"buqianka"] forState:UIControlStateNormal];
            [retroactiveCardBtn setImage:[UIImage imageNamed:@"buqiankaxuanding"] forState:UIControlStateSelected];
            retroactiveCardBtn.selected = YES;
            [retroactiveCardBtn addTarget:self action:@selector(clickRetroactiveBtn:) forControlEvents:UIControlEventTouchUpInside];
            //区分
            retroactiveCardBtn.tag =1;
            //只有可选时，才有保存的意义
            _selectedButton = retroactiveCardBtn;
            //关闭高亮置灰
            [retroactiveCardBtn setAdjustsImageWhenHighlighted:NO];
            
        }else {
            [retroactiveCardBtn setImage:[UIImage imageNamed:@"buqianbuzu"] forState:UIControlStateNormal];
        }
        [tempBaskView addSubview:retroactiveCardBtn];
        
        //积分选择卡
        UIButton *goldCoinBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(retroactiveCardBtn.frame)+17, 12, 99, 130)];;
        if (_isGoldCoin) {
            
            [goldCoinBtn setImage:[UIImage imageNamed:@"jifen"] forState:UIControlStateNormal];
            [goldCoinBtn setImage:[UIImage imageNamed:@"jifenxuanding"] forState:UIControlStateSelected];
            //两张卡只有一个可以是选中状态
            goldCoinBtn.selected = !_isRetroactiveCard;
            [goldCoinBtn addTarget:self action:@selector(clickRetroactiveBtn:) forControlEvents:UIControlEventTouchUpInside];
            //区分
            goldCoinBtn.tag = 2;
            //保存选中的按钮
            if (goldCoinBtn.selected) {
                _selectedButton = goldCoinBtn;
            }
            //关闭高亮置灰
            [goldCoinBtn setAdjustsImageWhenHighlighted:NO];
            
        }else {
            [goldCoinBtn setImage:[UIImage imageNamed:@"jifenbuzu"] forState:UIControlStateNormal];
        }
        [tempBaskView addSubview:goldCoinBtn];
        
        //取消按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(31, CGRectGetMaxY(retroactiveCardBtn.frame)+16, 65.5, 23.5)];
        [cancelButton setImage:[UIImage imageNamed:@"buqianquxiao"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelRetroactive:) forControlEvents:UIControlEventTouchUpInside];
        [tempBaskView addSubview:cancelButton];
        
        //确定按钮
        UIButton *sureButton = [[UIButton alloc] initWithFrame:(CGRect){
            CGPointMake(tempBaskView.frame.size.width - 31 - 65.5, cancelButton.frame.origin.y),CGSizeMake(65.5, 23.5)}];
        [sureButton setImage:[UIImage imageNamed:@"buqianqueding"] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureRetroactive:) forControlEvents:UIControlEventTouchUpInside];
        [tempBaskView addSubview:sureButton];
        
        tempBaskView;
    });
    
    //按钮的父View是日历，日历的父View是日历所在的View,位于今日签到按钮的上一级。
    [self.superview.superview addSubview:baskView];
    //保存弹出框
    _retroactiveView = baskView;

}


#pragma mark - 点击补签时的两张卡中的一张卡
-(void)clickRetroactiveBtn:(UIButton *)sender{
   
    //去掉先前的选中状态，保存现在的卡
    _selectedButton.selected = NO;
    sender.selected = YES;
    _selectedButton = sender;
    
}

#pragma mark - 补签取消
-(void)cancelRetroactive:(UIButton *)sender {
    [_retroactiveBackView removeFromSuperview];
    [_retroactiveView removeFromSuperview];
}

#pragma mark - 补签确定
-(void)sureRetroactive:(UIButton *)sender {
    
    if (!_selectedButton) {
        [self cancelRetroactive:nil];
        return;
    }
    
        NSString * retroactiveType =@"0";
        if (_selectedButton.tag == 1) {
            
            //补签卡
            retroactiveType = @"1";
            
        }else if (_selectedButton.tag == 2){
            
            //积分
            retroactiveType = @"0";
           
        }
    //这里 12月6
    NSString *dateTime = [NSString stringWithFormat:@"%02d",(int)self.day];
    
    [MBProgressHUD showHUDAddedTo:self.superview.superview  animated:YES];
    //获取接口数据
    NSString *url = [NSString stringWithFormat:@"https://%@/profiles/integral/useIntegral",PersonalAccount];

    NSString *userName = MY_USER_NAME;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"mytoken"];
    NSDictionary *dict = @{@"username":userName?userName:@"",@"token":token?token:@"",@"type":@"2",@"supplementtype":retroactiveType,@"dateTime":dateTime?dateTime:@""};
    
    [AIBangHttpTool postWithURL:url params:dict success:^(id json){
        
        [MBProgressHUD hideHUDForView:self.superview.superview  animated:YES];
        
        if (_retroactiveView) {
            [_retroactiveView removeFromSuperview];
            _retroactiveView = nil;
        }
        if (_retroactiveBackView) {
            [_retroactiveBackView removeFromSuperview];
            _retroactiveBackView = nil;
        }
        NSDictionary *jsonDict = (NSDictionary *)json;
        
        //rstCode为0代表请求错误
        NSString *rstCode = [NSString stringWithFormat:@"%@",jsonDict[@"retcode"]];
        
        if ([rstCode isEqualToString:@"0"]) {
            [AIControllersTool tipViewShow:@"数据请求失败！"];
            //创建错误提示View
            UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(23+21, 117, 240.5, 200)];
            _errorView = errorView;
            
            //报错图片
            UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenqiandaobugou"]];
            [errorView addSubview:succeedImgView];
            
            //关闭按钮
            UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(errorView.frame.size.width-16.5-5, 10, 16.5, 16)];
            [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(qiandaoError:) forControlEvents:UIControlEventTouchUpInside];
            [_errorView addSubview:cancelButton];
            
            [self.superview.superview addSubview:errorView];            return;
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"buqian_username"] == nil) {//第一次装app时候
            [[NSUserDefaults standardUserDefaults] setObject:MY_USER_NAME forKey:@"buqian_username"];
        }
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"buqian_username"] isEqualToString:MY_USER_NAME]) {//说命切换账号了，所以以下两个字端需要重新设置object
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)self.signTotal] forKey:@"qiandaotianshu"];//此代码只执行一次
            [[NSUserDefaults standardUserDefaults] setObject:self.boxNumb forKey:@"kaibaoxiangshu"];
            [[NSUserDefaults standardUserDefaults] setObject:MY_USER_NAME forKey:@"buqian_username"];
        }
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)self.signTotal] forKey:@"qiandaotianshu"];//此代码只执行一次
            [[NSUserDefaults standardUserDefaults] setObject:self.boxNumb forKey:@"kaibaoxiangshu"];
            
        });
        
        
        
        self.clickCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"qiandaotianshu"] integerValue];
        self.boxNumb = [[NSUserDefaults standardUserDefaults] objectForKey:@"kaibaoxiangshu"];

        self.clickCount ++;
        if (self.signTotal <= 31) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)self.clickCount] forKey:@"qiandaotianshu"];
            [self.boxView setProgressValue:self.clickCount AndBoxNumber:self.boxNumb];
        }
        //积分
        self.currentState = buttonStateSelected;
        //提示签到成功
        [self signInSucceed];
        
    }failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.superview.superview  animated:YES];
        if (_retroactiveView) {
            [_retroactiveView removeFromSuperview];
            _retroactiveView = nil;
        }
        if (_retroactiveBackView) {
            [_retroactiveBackView removeFromSuperview];
            _retroactiveBackView = nil;
        }
        
        //创建错误提示View
        UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(23+21, 117, 240.5, 200)];
        _errorView = errorView;
        
        //报错图片
        UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenqiandaobugou"]];
        [errorView addSubview:succeedImgView];
        
        //关闭按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(errorView.frame.size.width-16.5-5, 10, 16.5, 16)];
        [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(qiandaoError:) forControlEvents:UIControlEventTouchUpInside];
        [_errorView addSubview:cancelButton];
        
        [self.superview.superview addSubview:errorView];
        
        
    }];
    
    
    
}

-(void)qiandaoError:(UIButton *)sender{
    
    [_errorView removeFromSuperview];
}

@end
