//
//  BookFPSLabel.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/28.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookFPSLabel.h"
@interface BookFPSLabel()

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSTimeInterval lastTime;

@end

@implementation BookFPSLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [_link stop];
}

- (void)setup
{
    
    self.text = @"fps 0";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
