//
//  BookListTableViewCell+BookEntity.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/23.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListTableViewCell+BookEntity.h"
#import <UIImageView+WebCache.h>
#import "BookEntity.h"
#import "BookAuthor.h"
@implementation BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity
{
    self.titleLabel.text = bookEntity.title;
    NSString *authorList = @"";
    for (BookAuthor *author in bookEntity.authors)
    {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    self.authorLabel.text = [NSString stringWithFormat:@"作者:%@",authorList];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];

    UIView *lastDockView = self.tagView;
    if (bookEntity.tags.count != 0)
    {
        for (int i = 0; i < MIN(bookEntity.tags.count, 4); i++)
        {
            BookTag *tag = bookEntity.tags[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:9.0f];
            button.layer.cornerRadius = 2.0f;
            button.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
            button.layer.borderWidth = 0.5f;
            button.translatesAutoresizingMaskIntoConstraints = NO;
            [button setContentEdgeInsets:UIEdgeInsetsMake(3.0f, 5.0f, 3.0f, 5.0f)];
            [button setTitle:tag.name forState:UIControlStateNormal];
            [button sizeToFit];
            
            [self.tagView addSubview:button];
            
            if ([lastDockView isEqual:self.tagView])
            {
                [self.tagView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(button)]];
                
                [self.tagView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.tagView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            }else
            {
                [self.tagView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDockView]-8-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(button,lastDockView)]];
            }
            lastDockView = button;
        }
        [self.tagView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDockView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastDockView)]];
    }
}
@end
