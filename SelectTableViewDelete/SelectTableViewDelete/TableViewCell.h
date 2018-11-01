//
//  TableViewCell.h
//  SelectTableViewDelete
//
//  Created by 岚海网络 on 2018/11/1.
//  Copyright © 2018年 岚海网络. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell{
    BOOL            m_checked;
    
    
}

@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIImageView*    m_checkImageView;

- (void)setChecked:(BOOL)checked;


@end

NS_ASSUME_NONNULL_END
