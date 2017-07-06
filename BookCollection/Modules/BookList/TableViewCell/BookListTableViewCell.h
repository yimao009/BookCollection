//
//  BookListTableViewCell.h
//  BookCollection
//
//  Created by Kwok_Rui on 2017/6/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BookListTableViewCell : BaseTableViewCell

@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *tagView;

@end
