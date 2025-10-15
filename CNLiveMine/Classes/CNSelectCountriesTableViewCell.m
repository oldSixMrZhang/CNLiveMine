//
//  CNSelectCountriesTableViewCell.m
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import "CNSelectCountriesTableViewCell.h"
#import "CNSelectCountries.h"
#import <Masonry/Masonry.h>

@interface CNSelectCountriesTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UIImageView *line;

@end

@implementation CNSelectCountriesTableViewCell
static const NSInteger margin = 10;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.numberOfLines = 1;
        _codeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _codeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_codeLabel];
        
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [self.contentView addSubview:_line];
        
    }
    return self;
}
- (void)setModel:(CNSelectCountries *)model{
    _model = model;
    _titleLabel.text = model.name;
    _codeLabel.text = [NSString stringWithFormat:@"+%@",model.code];
    
}
-(void)setIsPadding:(BOOL)isPadding{
    _isPadding = isPadding;
}
- (void)layoutSubviews{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(margin);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.height.offset(CGRectGetHeight(self.bounds));
        
    }];
    
    [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(_isPadding?-15:0);
        make.height.offset(CGRectGetHeight(self.bounds));
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(margin);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.offset(0.5);
        
    }];
    
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
