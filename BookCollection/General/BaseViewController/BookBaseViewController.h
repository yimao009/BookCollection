//
//  BookBaseViewController.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookBaseViewController : UIViewController

- (UIImage *)navigationBarBackgroundImage;
- (BOOL)shouldShowShadowImage;
- (BOOL)shouldHideBottomBarWhenPushed;

@end
