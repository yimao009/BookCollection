//
//  BookScanView.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/12.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookScanView : UIView
- (id)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY;

- (void) startAnimation;
- (void) stopAnimation;

@end
