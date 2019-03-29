//
//  BoxButton.m
//  Demo
//
//  Created by chenqianfeng on 16/11/30.
//  Copyright © 2016年 chenqianfeng. All rights reserved.
//

#import "BoxButton.h"
#import "AIBangHttpTool.h"
@interface BoxButton ()
{
    UIView *_succeedView;//开宝箱成功View
    UIView * _errorView;//开宝箱失败View

}
@end
@implementation BoxButton

-(void)setBtnStatus:(UIButtonBackgroundImageType)btnStatus
{
    self.tag = btnStatus;
    switch (btnStatus) {
        case 0://按钮1普通状态
            [self setImage:[UIImage imageNamed:@"bx1"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageNormalClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 1://按钮1发光状态
            [self setImage:[UIImage imageNamed:@"bx1kyi"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageBulingClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 2://按钮1打开状态
            [self setImage:[UIImage imageNamed:@"bx1kai"] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
            break;
        case 3://按钮2普通状态
            [self setImage:[UIImage imageNamed:@"bx2"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageNormalClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 4://按钮2发光状态
            [self setImage:[UIImage imageNamed:@"bx2keyi"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageBulingClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 5://按钮2打开状态
            [self setImage:[UIImage imageNamed:@"bx2kai"] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
            break;
        case 6://按钮3普通状态
            [self setImage:[UIImage imageNamed:@"bx3"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageNormalClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 7://按钮3发光状态
            [self setImage:[UIImage imageNamed:@"bx3keyi"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageBulingClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 8://按钮3打开状态
            [self setImage:[UIImage imageNamed:@"bx3kai"] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
            break;
        case 9://按钮4普通状态
            [self setImage:[UIImage imageNamed:@"bx4"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageNormalClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 10://按钮4发光状态
            [self setImage:[UIImage imageNamed:@"bx4keyi"] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(UIButtonBackgroundImageBulingClick:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
            break;
        case 11://按钮4打开状态
            [self setImage:[UIImage imageNamed:@"bx4kai"] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}



- (void)UIButtonBackgroundImageNormalClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(boxButtonBackgroundImageNormalDidSelected:)]) {
        [self.delegate boxButtonBackgroundImageNormalDidSelected:sender.tag];
    }
}
- (void)UIButtonBackgroundImageBulingClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(hideContentImageView)]) {
        [self.delegate hideContentImageView];//隐藏宝箱奖励内容的方法
    }
    sender.userInteractionEnabled = NO;
    NSString *treasureNumber = @"";//开宝箱请求参数：区别开的是哪个宝箱
    NSString *string = @"";//开宝箱成功后提示图区别
    switch (sender.tag) {
        case 1:
            NSLog(@"第一个按钮，发光状态点击，调用接口获取奖励");
            treasureNumber = @"101";
            string = @"3";
            
            break;
        case 4:
            NSLog(@"第二个按钮，发光状态点击，调用接口获取奖励");
            treasureNumber = @"102";
            string = @"7";
            break;
        case 7:
            NSLog(@"第三个按钮，发光状态点击，调用接口获取奖励");
            treasureNumber = @"103";
            string = @"10";
            break;
        case 10:
            NSLog(@"第四个按钮，发光状态点击，调用接口获取奖励");
            treasureNumber = @"104";
            string = @"16";
            break;
        default:
            break;
    }
    
    //获取接口数据
    NSString *url = [NSString stringWithFormat:@"https://%@/profiles/integral/useIntegral",PersonalAccount];
    NSString *userName = MY_USER_NAME;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"mytoken"];
    NSDictionary *dict = @{@"username":userName?userName:@"",@"token":token?token:@"",@"type":@"1",@"treasureNumber":treasureNumber};
    
    [AIBangHttpTool postWithURL:url params:dict success:^(id json) {
        //打开宝箱成功
        NSDictionary *jsonDict = (NSDictionary *)json;
        
        //rstCode为0代表请求错误
        NSString *rstCode = [NSString stringWithFormat:@"%@",jsonDict[@"retcode"]];
        
        if ([rstCode isEqualToString:@"0"]) {
            [AIControllersTool tipViewShow:@"数据请求失败！"];
            //打开失败
            //创建错误提示View
            UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake((self.superview.superview.superview.frame.size.width - 240.5)/2, 117, 240.5, 200)];
            _errorView = errorView;
            
            //报错图片
            UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenqiandaobugou"]];
            [errorView addSubview:succeedImgView];
            
            //关闭按钮
            UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(errorView.frame.size.width-16.5-5, 10, 16.5, 16)];
            [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(qiandaoError:) forControlEvents:UIControlEventTouchUpInside];
            [_errorView addSubview:cancelButton];
            
            [self.superview.superview.superview addSubview:errorView];
            return;
        }
        NSArray *getArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kaibaoxiangshu"];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:getArr];
        switch (sender.tag) {
            case 1:
                self.btnStatus = 2;
                [tempArr addObject:@"1"];
                break;
            case 4:
                self.btnStatus = 5;
                [tempArr addObject:@"2"];
                break;
            case 7:
                self.btnStatus = 8;
                [tempArr addObject:@"3"];
                break;
            case 10:
                self.btnStatus = 11;
                [tempArr addObject:@"4"];
                break;
            default:
                break;
        }
        NSArray *boxArr = (NSArray *)tempArr;
        [[NSUserDefaults standardUserDefaults] setObject:boxArr forKey:@"kaibaoxiangshu"];
        [self signInSucceed:string];
        
    }failure:^(NSError *error) {
        //打开失败
        //创建错误提示View
        UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake((self.superview.superview.superview.frame.size.width - 240.5)/2, 117, 240.5, 200)];
        _errorView = errorView;
        
        //报错图片
        UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenqiandaobugou"]];
        [errorView addSubview:succeedImgView];
        
        //关闭按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(errorView.frame.size.width-16.5-5, 10, 16.5, 16)];
        [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(qiandaoError:) forControlEvents:UIControlEventTouchUpInside];
        [_errorView addSubview:cancelButton];
        
        [self.superview.superview.superview addSubview:errorView];
        return;
        
    }];

}

-(void)signInSucceed:(NSString *)string {
    //图片名称
    NSString *imgName = [NSString stringWithFormat:@"gongxi%@jifen",string];
    //创建成功提示View
    UIView *succeedView = [[UIView alloc] initWithFrame:CGRectMake(23+21, 117, 240.5, 200)];
    _succeedView = succeedView;
    //按钮的父View是日历，日历的父View是日历所在的View,位于今日签到按钮的上一级。
    [self.superview.superview.superview  addSubview:_succeedView];
    //成功图片
    UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    [succeedView addSubview:succeedImgView];
    //确定按钮
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(succeedView.frame.size.width/2-65.6/2, succeedView.frame.size.height-12-23.5, 65.6, 23.5)];
    [sureButton setImage:[UIImage imageNamed:@"buqianqueding"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(succeedSure:) forControlEvents:UIControlEventTouchUpInside];
    [succeedView addSubview:sureButton];
    
}
#pragma mark - 成功，恭喜页面的确认
-(void)succeedSure:(UIButton *)sender {
    if (_succeedView) {
        [_succeedView removeFromSuperview];
        _succeedView = nil;
    }
    
}
#pragma mark - 失败
-(void)qiandaoError:(UIButton *)sender {
    
    [_errorView removeFromSuperview];
    
}
#pragma mark lazy loading

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
