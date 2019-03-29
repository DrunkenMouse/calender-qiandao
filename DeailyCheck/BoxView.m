//
//  BoxView.m
//  Demo
//
//  Created by chenqianfeng on 16/11/30.
//  Copyright © 2016年 chenqianfeng. All rights reserved.
//

#import "BoxView.h"
#import "BoxButton.h"
@interface BoxView ()<BoxButtonClickDelegate>
@property (nonatomic,strong)UIImageView *contentImgView;
@end
@implementation BoxView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pView];
        NSMutableArray *mutArr = [[NSMutableArray alloc]init];
        [mutArr addObject:@"0"];
        [mutArr addObject:@"3"];
        [mutArr addObject:@"6"];
        [mutArr addObject:@"9"];
        [self drawProgressAndBoxBtn:mutArr];
    }
    return self;
}
- (void)drawProgressAndBoxBtn:(NSMutableArray *)statusArr
{
    for (id btn in self.subviews) {
        if ([btn isKindOfClass:[BoxButton class]]) {
            [btn removeFromSuperview];
        }
    }
    for (int i = 0; i < 4; i++) {
        //宝箱按钮
        BoxButton *boxBtn = [BoxButton buttonWithType:UIButtonTypeCustom];
        boxBtn.frame = CGRectMake(self.pView.frame.origin.x + 130/2*i, 10, 130/2 ,147/2);
        boxBtn.delegate = self;
        [boxBtn setAdjustsImageWhenHighlighted:NO];//取消按钮点击时候的高亮效果
        int status = [statusArr[i] intValue];
        boxBtn.btnStatus = status;
        [self addSubview:boxBtn];
        //按钮下方的显示
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(boxBtn.frame.origin.x, CGRectGetMaxY(boxBtn.frame)-10, boxBtn.frame.size.width, 20)];
        label.textColor = AB_Color_0084FF;//#0084FF
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                label.text = @"3天";
                break;
            case 1:
                label.text = @"7天";
                break;
            case 2:
                label.text = @"12天";
                break;
            case 3:
                label.text = @"21天";
                break;
            default:
                break;
        }
        [self addSubview:label];
    }

}
//后台给返回参数，我判断某个宝箱是开启状态还是未开启状态
- (void)setProgressValue:(NSInteger)cliclCount AndBoxNumber:(NSArray *)boxNumberArr
{
    float progressValue = 0;
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    NSString *boxOne = @"0";
    NSString *boxTwo = @"3";
    NSString *boxThree = @"6";
    NSString *boxFour = @"9";
    switch (cliclCount) {//签到的天数
        case 0:
            [mutArr addObject:@"0"];
            [mutArr addObject:@"3"];
            [mutArr addObject:@"6"];
            [mutArr addObject:@"9"];
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = 0;
            break;
        case 1:
            [mutArr addObject:@"0"];
            [mutArr addObject:@"3"];
            [mutArr addObject:@"6"];
            [mutArr addObject:@"9"];
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72;
            break;
        case 2:
            [mutArr addObject:@"0"];
            [mutArr addObject:@"3"];
            [mutArr addObject:@"6"];
            [mutArr addObject:@"9"];
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 2;
            break;
        case 3:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"3"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3;
            break;
        case 4:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"3"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16;
            break;
        case 5:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"3"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 2;
            break;
        case 6:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"3"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"3"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 3;
            break;
        case 7:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"6";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"6";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4;
            break;
        case 8:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"6";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"6";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        
                        break;
                    case 2:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20;
            break;
        case 9:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"6";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"6";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        
                        break;
                    case 2:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 2;
            break;
        case 10:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"6";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"6";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        
                        break;
                    case 2:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 3;
            break;
        case 11:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"6";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"6";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        
                        break;
                    case 2:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"6"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"6"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 4;
            break;
        case 12:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5;
            break;
        case 13:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36;
            break;
        case 14:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 2;
            break;
        case 15:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 3;
            break;
        case 16:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 4;
            break;
        case 17:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 5;
            break;
        case 18:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 6;
            break;
        case 19:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 7;
            break;
        case 20:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"9"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"9";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"9";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        boxFour = @"9";
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"9"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"9"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 8;
            break;
        case 21:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9;
            break;
        case 22:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216;
            break;
        case 23:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 2;
            break;
        case 24:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                            
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 3;
            break;
        case 25:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 4;
            break;
        case 26:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 5;
            break;
        case 27:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 6;
            break;
        case 28:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 7;
            break;
        case 29:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 8;
            break;
        case 30:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                            
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            
            progressValue = (float)5/72 * 3 + (float)1/16 * 4 + (float)1/20 * 5 + (float)1/36 * 9 + (float)1/216 * 9;
            break;
        case 31:
            if (boxNumberArr != nil) {
                switch (boxNumberArr.count) {
                    case 0:
                        [mutArr addObject:@"1"];
                        [mutArr addObject:@"4"];
                        [mutArr addObject:@"7"];
                        [mutArr addObject:@"10"];
                        break;
                    case 1:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"2"]){
                                boxOne = @"1";
                                boxTwo = @"5";
                                boxThree = @"7";
                                boxFour = @"10";
                            }else if ([str isEqualToString:@"3"]){
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"8";
                                boxFour = @"10";
                            }else{
                                boxOne = @"1";
                                boxTwo = @"4";
                                boxThree = @"7";
                                boxFour = @"11";
                            }
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 2:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 3:
                        for (NSString *str in boxNumberArr) {
                            if ([str isEqualToString:@"1"]) {
                                boxOne = @"2";
                                continue;
                            }
                            if ([str isEqualToString:@"2"]) {
                                boxTwo = @"5";
                                continue;
                            }
                            if ([str isEqualToString:@"3"]) {
                                boxThree = @"8";
                                continue;
                            }
                            if ([str isEqualToString:@"4"]) {
                                boxFour = @"11";
                                continue;
                            }
                            
                        }
                        if ([boxOne isEqualToString:@"0"]) {
                            boxOne = @"1";
                        }
                        if ([boxTwo isEqualToString:@"3"]) {
                            boxTwo = @"4";
                        }
                        if ([boxThree isEqualToString:@"6"]) {
                            boxThree = @"7";
                        }
                        if ([boxFour isEqualToString:@"9"]) {
                            boxFour = @"10";
                        }
                        [mutArr addObject:boxOne];
                        [mutArr addObject:boxTwo];
                        [mutArr addObject:boxThree];
                        [mutArr addObject:boxFour];
                        break;
                    case 4:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                    default:
                        [mutArr addObject:@"2"];
                        [mutArr addObject:@"5"];
                        [mutArr addObject:@"8"];
                        [mutArr addObject:@"11"];
                        break;
                }
            }else{
                [mutArr addObject:@"1"];
                [mutArr addObject:@"4"];
                [mutArr addObject:@"7"];
                [mutArr addObject:@"10"];
            }
            [self drawProgressAndBoxBtn:mutArr];
            progressValue = 1;
            break;
        default:
            break;
    }
    [self.pView setProgress:progressValue animated:YES];
    
}
#pragma mark BoxButtonClickDelegate
- (void)boxButtonBackgroundImageNormalDidSelected:(NSInteger)tag
{
    switch (tag) {
        case 0:
            self.contentImgView.frame = CGRectMake(self.pView.frame.origin.x+ (130/2-30)/2, 4, 30 ,22);
            self.contentImgView.image = [UIImage imageNamed:@"jiangli101"];
            NSLog(@"第一个按钮，普通状态点击");
            break;
        case 3:
            self.contentImgView.frame = CGRectMake(self.pView.frame.origin.x + 130/2*1+(130/2-30)/2, 4,30 ,22);
            self.contentImgView.image = [UIImage imageNamed:@"jiangli102"];
            NSLog(@"第二个按钮，普通状态点击");
            break;
        case 6:
            self.contentImgView.frame = CGRectMake(self.pView.frame.origin.x + 130/2*2+(130/2-30)/2, -2, 30 ,28);
            self.contentImgView.image = [UIImage imageNamed:@"jiangli103"];
            NSLog(@"第三个按钮，普通状态点击");
            break;
        case 9:
            self.contentImgView.frame = CGRectMake(self.pView.frame.origin.x + 130/2*3+(130/2-30)/2, -2, 30 ,28);
            self.contentImgView.image = [UIImage imageNamed:@"jiangli104"];
            NSLog(@"第四个按钮，普通状态点击");
            break;
        default:
            break;
    }
    [self addSubview:self.contentImgView];

}
//打开宝箱时候，移除ContentImageView
-(void)hideContentImageView
{
    [self.contentImgView removeFromSuperview];
}
#pragma mark lazy loading
- (UIProgressView *)pView
{
    if (!_pView) {
        //进度条
        _pView = [[UIProgressView alloc]initWithFrame:CGRectMake((self.frame.size.width - 130/2 * 4)/2, 10+147/4, 130/2 * 4, 20)];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.0f);
        _pView.transform = transform;
        //进度条颜色
        _pView.trackTintColor = AB_Color_deefff;
        //进度条进度的颜色
        _pView.progressTintColor = AB_Color_2194ff;
        [_pView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    }
    return _pView;
}
-(UIImageView *)contentImgView
{
    if (!_contentImgView) {
        _contentImgView = [[UIImageView alloc] init];
    }
    return _contentImgView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_contentImgView) {
        [self.contentImgView removeFromSuperview];
    }}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}*/

@end
