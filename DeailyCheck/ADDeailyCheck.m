//
//  ADDeailyCheck.m
//  anbang_ios
//
//  Created by 王奥东 on 16/11/29.
//  Copyright © 2016年 ch. All rights reserved.
//

#import "ADDeailyCheck.h"
#import "ButtonOfWeekDay.h"
#import "UIColor+Color16ToRgb.h"
#import "BoxView.h"
#import "AIBangHttpTool.h"
#import "MBProgressHUD.h"

#define screenW   [UIScreen mainScreen].bounds.size.width
@interface ADDeailyCheck ()<buttonIsRetroactive>
@property(nonatomic,assign)NSInteger cliclCount;
@property(nonatomic,retain)BoxView *boxView;
@end

static ADDeailyCheck *_deailyCheck;//单列对象

@implementation ADDeailyCheck{
    
    UIView * _calenderView;//日历
    
    UIView *_chestView;//宝箱所在的View
    
    NSInteger _offNum;//保存上个月的月数
    
    NSArray *_weekArr;//保存星期几的数组
    
    NSMutableArray <ButtonOfWeekDay *>* _buttonArr;//保存总共有多少个按钮
    
    ButtonOfWeekDay *_todayButton;//保存显示今日的按钮
    
    UIView *_lineView; //保存标志当前选择是哪个Button的View
    
    NSMutableArray * _allDaysArray;//保存按钮代表周几
    
    CGFloat _buttonHeight;//按钮的高度
    
    CGFloat _buttonWidth;//按钮的宽度
    
    UIButton *_retroactiveButton;//补签按钮
    
    UIImageView *_backImgView;//整体背景图，日历与宝箱都要放在其上面
    
    CGFloat _maxY;//最后一行按钮的Y
    
    NSString * _yearMonthString;//年月的日期

    UIView * _errorView;//签到失败View
    
    UIButton *_todaySignButton;//今日签到按钮
    NSDate *_serverDate;//服务器的时间戳

    
}

+(instancetype)sharedSignCheck{
    
    return [[self alloc] initWithFrame:CGRectMake(0, 0, KCurrWidth, KCurrHeight)];
}



-(instancetype)initWithFrame:(CGRect)frame {
    
    if (_deailyCheck == nil) {
        
        _deailyCheck = [super initWithFrame:frame];
    }
    //连接网络数据
    if (!_deailyCheck.isNetworker) {
        [_deailyCheck getNetWorker];
        _deailyCheck.isNetworker = TRUE;
  
    }
    
    return _deailyCheck;
}

#pragma mark - 获取网络数据
-(void)getNetWorker {
    
    //获取接口数据
    NSString *url = [NSString stringWithFormat:@"https://%@/profiles/integral/queryIntegral",PersonalAccount];
    NSString *userName = MY_USER_NAME;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"mytoken"];
    NSDictionary *dict = @{@"username":userName?userName:@"",@"token":token?token:@""};
    [MBProgressHUD showHUDAddedTo:_deailyCheck  animated:YES];
    
    [AIBangHttpTool postWithURL:url params:dict success:^(id json) {
        
        //       NSLog(@"%@",json);
        _deailyCheck.isNetworker = NO;
        //首页会修改frame
        CGRect frame = _deailyCheck.frame;
        frame.size.height = KCurrHeight;
        _deailyCheck.frame = frame;
        [MBProgressHUD hideHUDForView:_deailyCheck animated:YES];
        
        NSDictionary *jsonDict = (NSDictionary *)json;
        
        //rstCode为0代表请求错误
        NSString *rstCode = [NSString stringWithFormat:@"%@",jsonDict[@"retcode"]];
        
        if ([rstCode isEqualToString:@"0"]) {
            [AIControllersTool tipViewShow:@"数据请求失败！"];
            [_deailyCheck closeCalender:nil];
            return;
        }
        //获取服务器的时间戳
        NSString *stime = jsonDict[@"nowTime"];
        NSTimeInterval time = [[stime substringToIndex:10] doubleValue];
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        _serverDate = detaildate;
        
        //添加整体背景图
        [_deailyCheck createBackView];
        
        //创建日历
        [_deailyCheck createCalender];
        
        
        //创建补签与今日签到
        [_deailyCheck createTodayAndRetroactive];
        
        //创建年月日期与关闭按钮
        [_deailyCheck createYearMonthAndClose];
        
        //服务器给的今日
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        NSString * day = [dateFormatter stringFromDate: detaildate];
        
        _todayButton = _buttonArr[[day integerValue]-1];
        
        _todayButton.layer.borderColor = AB_Color_2194ff.CGColor;
        _todayButton.layer.borderWidth = 1.5;
        
        _todayButton.layer.cornerRadius = 5;
        [_todayButton.layer masksToBounds];
        //本月签到的所有日期
        _deailyCheck.listDay = jsonDict[@"listDay"];
        //补签卡数量
        _deailyCheck.signCard = [[NSString stringWithFormat:@"%@",jsonDict[@"signCard"]] integerValue];
        //累计签到次数
        _deailyCheck.signTotal = [NSString stringWithFormat:@"%@",jsonDict[@"signTotal"]];
        //本月已开宝箱数
        _deailyCheck.boxNumber = [NSArray arrayWithArray:jsonDict[@"boxNumber"]];
        //当月积分总额
        _deailyCheck.countScore = [[NSString stringWithFormat:@"%@",jsonDict[@"countScore"]] integerValue];
        _deailyCheck.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_deailyCheck createChestAndWater];
        
    } failure:^(NSError *error) {
        
        //        NSLog(@"menuError");
        _deailyCheck.isNetworker = NO;
        [MBProgressHUD hideHUDForView:_deailyCheck  animated:YES];
        [AIControllersTool tipViewShow:@"数据请求失败！"];
        [_deailyCheck closeCalender:nil];
        
    }];

}


#pragma mark - 添加背景图
-(void)createBackView{
    
    UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dibufagiuang"]];
    
    backImgView.frame = CGRectMake((KCurrWidth-330)/2, (KCurrHeight-538)/2, 330, 538);
    _backImgView = backImgView;
    _backImgView.userInteractionEnabled = YES;
    [_deailyCheck addSubview:backImgView];
    
}

#pragma mark - 创建日历
-(void)createCalender {
    //以下为日历
    
    //设置数据周几
    _weekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    //初始化按钮数组
    _buttonArr = [NSMutableArray array];
    
    //设置显示日期的按钮高度
    _buttonHeight = 37;
    
    //设置显示日期的按钮宽度
    _buttonWidth = 37;
    
    //获取当前月都是周几
    _allDaysArray = [_deailyCheck getAllDaysWithCalender];
    //获取一号的时候是周几
    //    NSInteger day =  [dayArr[0] integerValue];
    
    //获取当前月的所有按钮添加到数组_buttonArr中
    [_deailyCheck getCurrentMonthButton];
    
    //装载按钮的View
    UIView *loadButtonView = [[UIView alloc] initWithFrame:CGRectMake(21, 21, 286, 334)];
    UIImageView *loadButtonImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"di1"]];
    [loadButtonView addSubview:loadButtonImgView];
    
    [_backImgView addSubview:loadButtonView];
    
   
  
    //代表第几周
    CGFloat weekNum = 0;
    
    //按钮的设置
    for (int i = 00; i < _buttonArr.count; i++) {
        
        ButtonOfWeekDay *weekDayBtn = ({
           
            //获取按钮重新设置Frame
            ButtonOfWeekDay *btn = _buttonArr[i];
            
            //左间距
            NSInteger leftMargin = 0;
            //上间距
            NSInteger topMargin = 0;
            
            //第一周的上间距为79
            //此后每周的上间距距离上一周+2
            topMargin = (weekNum == 0) ? 79 : 79+2*weekNum;
          
            //按钮上的星期几就是i的值，0为周日，1为周一，依次排列
            btn.weekDays = [_allDaysArray[i] integerValue];
            
            //每周末的左边距是8
            leftMargin = (btn.weekDays == 0) ? 8 :8+2*btn.weekDays;
            
            if (leftMargin == 10) {
                NSLog(@"weekDays %ld",(long)btn.weekDays);
            }
        
            //设置按钮的frame
            btn.frame = CGRectMake(btn.weekDays%7*_buttonWidth+leftMargin, weekNum*_buttonHeight+topMargin, _buttonWidth, _buttonHeight);
            
            //每过一周，btn的y需要加一次高度
            if (btn.weekDays >= 6) {
                weekNum++;

            }
            

       
            //用tag保存当前是第几个按钮
            btn.tag = i;
            
            //设置按钮的状态为未选中
            btn.currentState = buttonStateNormal;
            
           

            //用于设置按钮所在View的Y
            if (_maxY < CGRectGetMaxY(btn.frame)) {
                _maxY = CGRectGetMaxY(btn.frame);
            }
            
            btn;
        });
        //将按钮添加到View上
        [loadButtonView addSubview:weekDayBtn];
    }
    
  
    
    //保存代表日历的View
    _calenderView = loadButtonView;
    
    //添加柱子图片
    UIImageView *pillarImgView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(_calenderView.frame.origin.x, _maxY+60+_calenderView.frame.origin.y),CGSizeMake(_calenderView.frame.size.width, 57)}];
    pillarImgView.image = [UIImage imageNamed:@"di2"];
    [_backImgView addSubview:pillarImgView];
    
    //添加宝箱背景图
    UIImageView *chestsBackView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(_calenderView.frame.origin.x, CGRectGetMaxY(pillarImgView.frame)),CGSizeMake(_calenderView.frame.size.width, 103.5)}];
    chestsBackView.image = [UIImage imageNamed:@"di3"];
    [_backImgView addSubview:chestsBackView];
    _chestView = chestsBackView;
    chestsBackView.userInteractionEnabled = YES;
//    _todayButton 代表今日的按钮
}

#pragma mark - 获取到已经签到的日期
-(void)setListDay:(NSArray *)listDay {
    
    _listDay = listDay;
    for (NSInteger i = 0; i < listDay.count; i++) {
        
        for (int j = 0; j < _buttonArr.count; j++) {
            
            NSString *listdayStr = [NSString stringWithFormat:@"%@",_listDay[i]];
            NSString *buttonStr = [NSString stringWithFormat:@"%02d",(int)_buttonArr[j].day];
            //改变已签到的格式
            if ([listdayStr isEqualToString:buttonStr]) {
                _buttonArr[j].currentState = buttonStateSelected;
                //如果今天已签到
                if ([_buttonArr[j] isEqual:_todayButton]) {
                    //今日签到改成已签到
                    _todaySignButton.userInteractionEnabled = NO;
                    _todaySignButton.selected = YES;
                    //如果今天之前有未签到的就显示补签，否则不显示
                    for (int i = 0; i < _todayButton.day; i++) {
                        
                        //未签到的可以补签，别的不行
                        if (_buttonArr[i].currentState == buttonStateNormal) {
                            //显示补签
                            _retroactiveButton.hidden = NO;
                            return;
                        }
                    }
                }
            }
            
        }
    }
    
}


#pragma mark - 创建补签与今日签到按钮
-(void)createTodayAndRetroactive {
    
    //补签,今日签到已签到(选中状态)才可以判断可否点击
    
    UIButton *retroactiveButton = [[UIButton alloc] initWithFrame:CGRectMake((_backImgView.frame.size.width/2-55.5)/2, _maxY+23+_calenderView.frame.origin.y, 40, 20)];
    [retroactiveButton setImage:[UIImage imageNamed:@"buqian"] forState:UIControlStateNormal];
    retroactiveButton.hidden = YES;
    [retroactiveButton addTarget:_deailyCheck action:@selector(clickRetroactiveButton:) forControlEvents:UIControlEventTouchUpInside];
    _retroactiveButton = retroactiveButton;
    [_backImgView addSubview:retroactiveButton];
    
    //今日签到按钮,已签到(选中状态)不可以点击
    UIButton *todayButton = ({
    
        UIButton *todayButtons =   [[UIButton alloc] initWithFrame:CGRectMake(_backImgView.frame.size.width/2-55.5,retroactiveButton.frame.origin.y-retroactiveButton.frame.size.height/2, 111, 45)];
        [todayButtons setImage:[UIImage imageNamed:@"jinriqiandao"] forState:UIControlStateNormal];
        [todayButtons setImage:[UIImage imageNamed:@"jinriyiqiandao"] forState:UIControlStateSelected];
        [todayButtons addTarget:_deailyCheck action:@selector(clickTodayButton:) forControlEvents:UIControlEventTouchUpInside];

        todayButtons;
    });
    _todaySignButton = todayButton;
    
    
    [_backImgView addSubview:todayButton];
}


#pragma mark - 点击补签
-(void)clickRetroactiveButton:(UIButton *)sender{
    
    
    
    for (int i = 0; i < _todayButton.day; i++) {
        
        //未签到的可以补签，别的不行
        if (_buttonArr[i].currentState == buttonStateNormal) {
            //切换状态，允许交互
            _buttonArr[i].currentState = buttonStateRetroactive;
            _buttonArr[i].userInteractionEnabled = YES;
            _buttonArr[i].boxView = _deailyCheck.boxView;
            _buttonArr[i].signTotal = _deailyCheck.cliclCount;
            _buttonArr[i].boxNumb = _deailyCheck.boxNumber;
            _buttonArr[i].btnDelegate = _deailyCheck;
        }
        
    }
    
    //补签时今天之后的按钮不可点击，设置按钮状态为不能点击
    //从今天之后，所以不加1，数组从0开始
    for (NSInteger i = _todayButton.day; i < _buttonArr.count; i++) {
      
        _buttonArr[i].currentState = buttonStateUnableSelected;
    }
    
}
-(void)buttonIsRetroactive:(ButtonOfWeekDay *)button BOOL:(BOOL)isRetro {
    
    if (isRetro) {
        
        for (int i = 0; i < _todayButton.day; i++) {
            if (_buttonArr[i]!=button) {
                _buttonArr[i].userInteractionEnabled = NO;
            }
        }
    }else {
        
        for (int i = 0; i < _todayButton.day; i++) {
            if (_buttonArr[i]!=button) {
                //未签到的可以补签，别的不行
                if (_buttonArr[i].currentState != buttonStateSelected) {
                    //切换状态，允许交互
                    _buttonArr[i].currentState = buttonStateRetroactive;
                    _buttonArr[i].userInteractionEnabled = YES;
                    _buttonArr[i].boxView = _deailyCheck.boxView;
                    _buttonArr[i].signTotal = _deailyCheck.cliclCount;
                    _buttonArr[i].boxNumb = _deailyCheck.boxNumber;
                    _buttonArr[i].btnDelegate = _deailyCheck;
                }

            }
        }
    }
    
}
#pragma mark - 点击今日签到
-(void)clickTodayButton:(UIButton *)sender {
    
    //获取接口数据
    NSString *url = [NSString stringWithFormat:@"https://%@/profiles/integral/useIntegral",PersonalAccount];
    NSString *userName = MY_USER_NAME;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"mytoken"];
    NSDictionary *dict = @{@"username":userName?userName:@"",@"token":token?token:@"",@"type":@"1"};
    
    //这里 12月6
    [MBProgressHUD showHUDAddedTo:_deailyCheck animated:YES];
    
    [AIBangHttpTool postWithURL:url params:dict success:^(id json) {
        NSDictionary *jsonDict = (NSDictionary *)json;
        //这里 12月6
        [MBProgressHUD hideHUDForView:_deailyCheck  animated:YES];
        //rstCode为0代表请求错误
        NSString *rstCode = [NSString stringWithFormat:@"%@",jsonDict[@"retcode"]];
        
        if ([rstCode isEqualToString:@"0"]) {
            [AIControllersTool tipViewShow:@"数据请求失败！"];
            [_deailyCheck closeCalender:nil];
            return;
        }
        //签到成功
        _deailyCheck.cliclCount ++;
        if (_deailyCheck.cliclCount <= 31) {
            [_deailyCheck.boxView setProgressValue:_deailyCheck.cliclCount AndBoxNumber:_deailyCheck.boxNumber];
        }
        //图片改成已签到并拒绝交互
        sender.selected = YES;
        sender.userInteractionEnabled = NO;
        
        
        [_deailyCheck signInSucceed];

    }failure:^(NSError *error) {
        //签到失败
        
        //创建错误提示View
        UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(23, 117, 240.5, 200)];
        _errorView = errorView;
        
        //报错图片
        UIImageView *succeedImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenqiandaobugou"]];
        [errorView addSubview:succeedImgView];
        
        //关闭按钮
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(errorView.frame.size.width-16.5-5, 10, 16.5, 16)];
        [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
        [cancelButton addTarget:_deailyCheck action:@selector(qiandaoError:) forControlEvents:UIControlEventTouchUpInside];
        [_errorView addSubview:cancelButton];
        
        [_calenderView addSubview:errorView];
        
        
        //这里 12月6
        [MBProgressHUD hideHUDForView:_deailyCheck animated:YES];
        [AIControllersTool tipViewShow:@"数据请求失败！"];
        return;
        
    }];

   
   
}

#pragma mark - 签到失败
-(void)qiandaoError:(UIButton *)sender {
 
    [_errorView removeFromSuperview];
    
}

#pragma mark - 签到成功
-(void)signInSucceed{
    //如果页面挂了一夜没有点今日签到，则第二日时点签到应该是第二日的日期
    //此时保存的今日按钮不是今天
    if (_todayButton.monthDay) {
        if (_todayButton) {
            _todayButton.currentState = buttonStateSelected;
        }
    }
    
    //签到成功，需弹窗提示
    [_todayButton signInSucceed];
    
 
    //如果今天之前有未签到的就显示补签，否则不显示
    for (int i = 0; i < _todayButton.day; i++) {
        
        
        //未签到的可以补签，别的不行
        if (_buttonArr[i].currentState == buttonStateNormal) {
            //显示补签
            _retroactiveButton.hidden = NO;
            return;
        }
    }
    
}


#pragma mark - 创建宝箱和水柱动画
-(void)createChestAndWater{
    //宝箱&水柱动画
    _deailyCheck.cliclCount = _deailyCheck.signTotal.integerValue;;
    [_chestView addSubview:_deailyCheck.boxView];
    [_deailyCheck.boxView setProgressValue:_deailyCheck.cliclCount AndBoxNumber:_deailyCheck.boxNumber];
}

#pragma mark - 创建年月日期与关闭按钮
-(void)createYearMonthAndClose {
    
    //创建年月日期的Label
    UILabel *yearMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(_calenderView.frame.size.width/2-60, 10, 120, 21)];
    yearMonthLabel.text = [_yearMonthString stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    yearMonthLabel.textAlignment = UITextAlignmentCenter;
    yearMonthLabel.textColor = AB_Color_0084ff;
    yearMonthLabel.font = [UIFont systemFontOfSize:19];
    [_calenderView addSubview:yearMonthLabel];
    
    //创建关闭按钮
    //16.5 16
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(_calenderView.frame.size.width-21-18, 4, 33, 32)];
    [cancelButton setImageEdgeInsets:UIEdgeInsetsMake(8.5, 8, 0, 0)];
    [cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [cancelButton addTarget:_deailyCheck action:@selector(closeCalender:) forControlEvents:UIControlEventTouchUpInside];
    [_calenderView addSubview:cancelButton];
    
}

#pragma mark - 关闭签到
-(void)closeCalender:(UIButton *)sender {
    
    if (_deailyCheck.workerblock) {
        _deailyCheck.workerblock();
    }
    [_deailyCheck removeFromSuperview];
    
    
   
}
+(void)closeCalender {
    [_deailyCheck removeFromSuperview];
}


#pragma mark - - - - - - - - - -  calendar - - - - - - - - - -

#pragma mark - 获取当月的天数
- (NSInteger)getNumberOfDaysInMonth
{
    //获取算法为公历的日历
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //给定当前日期
    NSDate * currentDate = _serverDate;
    //计算当前月有多少天
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:currentDate];
    
    
    return range.length;
}



#pragma mark - 获取当前月中所有天数是周几
- (NSMutableArray *) getAllDaysWithCalender
{
    //通过自定义方法获取当前月中有多少天
    NSUInteger dayCount = [_deailyCheck getNumberOfDaysInMonth];
    
    //指定日期的显示格式
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSDate * currentDate = _serverDate;
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    //获取 年 - 月
    NSString * str = [formatter stringFromDate:currentDate];
//        NSLog(@"%@",str);
    _yearMonthString = str;
    //在设置显示格式为年 - 月 - 日
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //保存周几的数组
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    //当前月有多少天就循环多少次
    for (NSInteger i = 1; i <= dayCount; i++) {
        //获取时间格式如： 年 - 月 - 1 、 年 - 月 - 2
        NSString * sr = [NSString stringWithFormat:@"%@-%d",str,(int)i];
        NSDate *suDate = [formatter dateFromString:sr];
        //通过时间自定义方法获取第几日为星期几
        [allDaysArray addObject:[_deailyCheck getweekDayWithDate:suDate]];
    }
    //    _allDaysArray = allDaysArray;
    //    NSLog(@"allDaysArray %@",allDaysArray);
    return allDaysArray;
}

#pragma mark - 获取指定的日期是星期几
- (id) getweekDayWithDate:(NSDate *) date
{
    //指定日历的算法为公历
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //获取指定日期为周几
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    // 若不减一 则 1 是周日，2是周一 3是周二 以此类推
    // 而减一后 则 0为周日，1为周一，2为周二 以此类推
    return @([comps weekday]-1);
    
}

#pragma mark - 获取当前月的所有按钮添加到数组_buttonArr中
-(void)getCurrentMonthButton{
    //获取当前月有多少天
    NSInteger num = [_deailyCheck getNumberOfDaysInMonth];
    
    //获取当前月的所有按钮添加到数组_buttonArr中
    for (int i = 0; i < num; i++) {
        
        ButtonOfWeekDay *btn = [[ButtonOfWeekDay alloc]initWithFrame:CGRectMake(i%7*50, i/7*30,50, 30)];
        
        //设置日期
        NSDate *date = _serverDate;
        //获取当前的月数
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM"];
        //将获取到的月数转成字符串
        NSString *str = [dateFormatter stringFromDate:date];
        
        //通过月数几号拼接成字符串weekday
        //设置weekday值为701，712这种格式，方便后面判断
        NSString *weekStr = [NSString stringWithFormat:@"%@%02d",str,i+1];
        //注意：转换成integerValue后，0716会变成716
        NSInteger weekday = [weekStr integerValue];
        //设置按钮代表的几月几号值
        btn.monthDay = weekday;
        //设置按钮显示的是几号,从0开始所以加1
        btn.day = i+1;
        btn.userInteractionEnabled = NO;
        
        //        NSLog(@"%ld",tag);
        //将按钮添加到数组
        [_buttonArr addObject:btn];
        
    }
    
}

#pragma mark - 获取今天是几月几号
-(NSInteger)getNumberOfToday{    //已经获取服务器的时间戳，暂时用不到

    
    //MMdd 月日
    NSDate * todayDate = [NSDate date];
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc]init];
    [dateForMatter setDateFormat:@"MMdd"];
    NSString *todayStr = [dateForMatter stringFromDate:todayDate];
    //    NSLog(@"today:%ld",[todayStr integerValue]);
    return [todayStr integerValue];
}
#pragma mark lazy loading
-(BoxView *)boxView
{
    if (!_boxView) {
        _boxView = [[BoxView alloc]initWithFrame:CGRectMake(0, 0,_chestView.frame.size.width , _chestView.frame.size.height)];
        _boxView.backgroundColor = [UIColor clearColor];
    }
    return _boxView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_boxView) {
        [_deailyCheck.boxView hideContentImageView];
    }
}
@end
