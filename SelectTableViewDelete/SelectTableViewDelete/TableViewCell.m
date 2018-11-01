//
//  TableViewCell.m
//  SelectTableViewDelete
//
//  Created by 岚海网络 on 2018/11/1.
//  Copyright © 2018年 岚海网络. All rights reserved.
//

#import "TableViewCell.h"
#import <Masonry/Masonry.h>

#define kselfSize [UIScreen mainScreen].bounds.size

@implementation TableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
    }
    return self;
}
// 创建cell
- (void)creat{
//    if (m_checkImageView == nil)
//    {
//        m_checkImageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"weixuanzhong"]];
//        m_checkImageView.image = [UIImage imageNamed:@"weixuanzhong"];
////        m_checkImageView.frame = CGRectMake(kselfSize.width - 20, 10, 29, 29);
//        [self.contentView addSubview:m_checkImageView];
//
//        [m_checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView);
//            make.right.equalTo(self.contentView.mas_right).offset(-20);
//            make.width.height.mas_equalTo(30);
//        }];
//    }
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    [self.contentView addSubview:self.m_checkImageView];
    [self.m_checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
}

- (UIImageView *)m_checkImageView
{
    if (!_m_checkImageView) {
        _m_checkImageView = [[UIImageView alloc] init];
        _m_checkImageView.image = [UIImage imageNamed:@"weixuanzhong"];
    }
    return _m_checkImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.backgroundColor = [UIColor yellowColor];
        _titleLab.textColor = [UIColor redColor];
        _titleLab.font = [UIFont systemFontOfSize:18];
    }
    return _titleLab;
}



// 设置选中或未选中图片
- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        self.m_checkImageView.image = [UIImage imageNamed:@"gouxuan"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        self.m_checkImageView.image = [UIImage imageNamed:@"weixuanzhong"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
