//
//  BookScanView.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/12.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookScanView.h"

@interface BookScanView ()
/**
 * 扫描区域大小
 */
@property (nonatomic,assign) CGSize rectSize;

/**
 * 扫描区域相对于view中心点的偏移量，向上为负值，向下为正值
 */
@property (nonatomic,assign) CGFloat offsetY;

/**
 * 扫描线
 */
@property (nonatomic,strong) UIImageView *animationLine;

/**
 * 表示是否反向扫描
 */
@property (nonatomic,assign,getter=isAnimationReverse) BOOL animationReverse;

/**
 * 表示是否正在动画
 */
@property (nonatomic,assign,getter=isAnimating) BOOL animating;

@end

@implementation BookScanView

- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.rectSize = size;
        self.offsetY  = offsetY;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
//    计算基准坐标
    
    CGFloat minX = (self.frame.size.width - self.rectSize.width)/2;
    CGFloat maxX = minX + self.rectSize.width;
    CGFloat minY = (self.frame.size.height - self.rectSize.height)/2 + self.offsetY;
    CGFloat maxY = minY + self.rectSize.height;
    
//    绘制黑色半透明区域
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), minY));
    CGContextFillRect(context, CGRectMake(0, minY, minX, self.rectSize.height));
    CGContextFillRect(context, CGRectMake(0, maxY, CGRectGetWidth(self.frame),self.frame.size.height - maxY));
    CGContextFillRect(context, CGRectMake(maxX, minY, minX, self.rectSize.height));
    
//    绘制中间区域白色边框
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextAddRect(context, CGRectMake(minX, minY, self.rectSize.width, self.rectSize.height));
    CGContextStrokePath(context);
    
//    绘制中间区域四个角效果
    CGFloat cornerLineLength = 9.0f;
    CGFloat cornerLineThick  = 1.0f;
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, cornerLineThick);
    
//    左上角
    CGContextMoveToPoint(context, minX+cornerLineLength, minY-cornerLineThick);
    CGContextAddLineToPoint(context, minX-cornerLineThick, minY-cornerLineThick);
    CGContextAddLineToPoint(context, minX-cornerLineThick, minY+cornerLineLength);
    
    CGContextMoveToPoint(context, minX-cornerLineThick, maxY-cornerLineLength);
    CGContextAddLineToPoint(context, minX-cornerLineThick, maxY+cornerLineThick);
    CGContextAddLineToPoint(context, minX+cornerLineLength, maxY+cornerLineThick);
    
    CGContextMoveToPoint(context, maxX-cornerLineLength, maxY+cornerLineThick);
    CGContextAddLineToPoint(context, maxX+cornerLineThick, maxY+cornerLineThick);
    CGContextAddLineToPoint(context, maxX+cornerLineThick, maxY-cornerLineLength);
    
    CGContextMoveToPoint(context, maxX+cornerLineThick, minY+cornerLineLength);
    CGContextAddLineToPoint(context, maxX+cornerLineThick, minY-cornerLineThick);
    CGContextAddLineToPoint(context, maxX-cornerLineLength, minY-cornerLineThick);
    
    CGContextStrokePath(context);
}

- (UIImageView *)animationLine
{
    if (nil == _animationLine)
    {
        CGFloat minX = (self.frame.size.width - self.rectSize.width)/2;
        CGFloat minY = (self.frame.size.height - self.rectSize.height)/2 + self.offsetY;
        _animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(minX, minY, self.rectSize.width, 1.0)];
        _animationLine.image = [UIImage imageNamed:@"scanner-line"];
        [self addSubview:_animationLine];
    }
    return _animationLine;
}

- (void) startAnimation
{
    if (self.animating)
    {
        return;
    }
    self.animating = YES;
    
    CGFloat minX = (self.frame.size.width - self.rectSize.width)/2;
    CGFloat minY = (self.frame.size.height - self.rectSize.height)/2 + self.offsetY;
    CGFloat maxY = minY + self.rectSize.height;
    
    [UIView animateWithDuration:3.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.animationReverse)
        {
            self.animationLine.frame = CGRectMake(minX, minY, self.rectSize.width, 1);
        }else
        {
            self.animationLine.frame = CGRectMake(minX, maxY, self.rectSize.width, 1);
        }
    } completion:^(BOOL finished) {
        if (finished)
        {
            self.animationReverse = !self.animationReverse;
            self.animating = NO;
            [self startAnimation];
        }else
        {
            [self stopAnimation];
        }
    }];
}

- (void) stopAnimation
{
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    self.animating = NO;
    self.animationReverse = NO;
}
@end
