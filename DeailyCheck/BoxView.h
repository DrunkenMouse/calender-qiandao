//
//  BoxView.h
//  Demo
//
//  Created by chenqianfeng on 16/11/30.
//  Copyright © 2016年 chenqianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxView : UIView
@property (nonatomic,strong)UIProgressView *pView;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setProgressValue:(NSInteger )cliclCount AndBoxNumber:(NSArray *)boxNumberArr;
- (void)hideContentImageView;
@end
