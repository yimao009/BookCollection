//
//  BookListTableViewCell.m
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BookListTableViewCell.h"

@implementation BookListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:13.0f];
    self.authorLabel.textColor = UIColorFromRGB(0x999999);
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.authorLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    self.tagView = [[UIView alloc] init];
    self.tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.tagView];
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_coverImageView,_authorLabel,_titleLabel,_tagView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_coverImageView(==50)]-15-[_titleLabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:dict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_coverImageView(==70)]" options:NSLayoutFormatAlignAllTop metrics:nil views:dict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleLabel]-6-[_authorLabel]-10-[_tagView(==18)]" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:dict]];
}

- (void)prepareForReuse
{
    self.coverImageView.image = nil;
    self.authorLabel.text = nil;
    self.titleLabel.text = nil;
    [self.tagView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
@end
