//
//  CNSelectCountriesTableViewCell.h
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CNSelectCountries;
@interface CNSelectCountriesTableViewCell : UITableViewCell
@property (nonatomic, strong) CNSelectCountries *model;
@property (nonatomic, assign) BOOL isPadding;

@end

NS_ASSUME_NONNULL_END
