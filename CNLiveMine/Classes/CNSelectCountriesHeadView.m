//
//  CNSelectCountriesHeadView.m
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import "CNSelectCountriesHeadView.h"
#import "CNSelectCountriesTableViewCell.h"
#import "CNSelectCountries.h"
#define xMainScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define xMainScreenHeight                    [[UIScreen mainScreen] bounds].size.height

#define kMainScale                           xMainScreenWidth/375.f
#define kMainHScale                          xMainScreenHeight/667.f

@interface CNSelectCountriesHeadView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CNSelectCountriesHeadView
#pragma mark - 入口
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.tableView];

}
- (void)setData:(NSArray *)data{
    _data = data;
    [self.tableView reloadData];
    
}
- (void)dealloc {
    NSLog(@"CNLiveAddressBookViewController - dealloc");
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30*kMainHScale;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001f;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*kMainScale;
    
}

#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xMainScreenWidth, 30*kMainHScale)];
    headerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, xMainScreenWidth-10, 30*kMainHScale)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14*kMainHScale];
    titleLabel.text = @"常用国家或地区";
    [headerView addSubview:titleLabel];
    return headerView;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, xMainScreenWidth, 0.00000001f)];
    footerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    return footerView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNSelectCountriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CNSelectCountriesTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CNSelectCountries *contact = self.data[indexPath.row];
    cell.model = contact;
    cell.isPadding = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CNSelectCountries *contact = self.data[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectHeadView:countryName:countryCode:)]) {
        [self.delegate selectHeadView:self countryName:contact.name countryCode:contact.code];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - Lazy Laoding
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, xMainScreenWidth, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[CNSelectCountriesTableViewCell class] forCellReuseIdentifier:@"CNSelectCountriesTableViewCell"];
    }
    return _tableView;
}

@end
