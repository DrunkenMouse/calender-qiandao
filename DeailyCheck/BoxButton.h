//
//  BoxButton.h
//  Demo
//
//  Created by chenqianfeng on 16/11/30.
//  Copyright © 2016年 chenqianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    //以下是枚举成员
    UIButtonBackgroundImageNormalWithIndexZero = 0,//按钮1普通状态
    UIButtonBackgroundImageBulingWithIndexZero = 1,//按钮1发光状态
    UIButtonBackgroundImageOpenedWithIndexZero = 2,//按钮1打开状态
    UIButtonBackgroundImageNormalWithIndexOne = 3,//按钮2普通状态
    UIButtonBackgroundImageBulingWithIndexOne = 4,//按钮2发光状态
    UIButtonBackgroundImageOpenedWithIndexOne = 5,//按钮2打开状态
    UIButtonBackgroundImageNormalWithIndexTwo = 6,//按钮3普通状态
    UIButtonBackgroundImageBulingWithIndexTwo = 7,//按钮3发光状态
    UIButtonBackgroundImageOpenedWithIndexTwo = 8,//按钮3打开状态
    UIButtonBackgroundImageNormalWithIndexThree = 9,//按钮4普通状态
    UIButtonBackgroundImageBulingWithIndexThree = 10,//按钮4发光状态
    UIButtonBackgroundImageOpenedWithIndexThree = 11//按钮4打开状态
} UIButtonBackgroundImageType;//枚举名称

@protocol BoxButtonClickDelegate <NSObject>

- (void)boxButtonBackgroundImageNormalDidSelected:(NSInteger )tag;
- (void)hideContentImageView;
@end

@interface BoxButton : UIButton <BoxButtonClickDelegate>
@property (nonatomic,retain) id <BoxButtonClickDelegate>delegate;
@property (nonatomic,assign)UIButtonBackgroundImageType btnStatus;
@end
