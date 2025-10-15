//
//  CNSelectCountriesHeadView.h
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CNSelectCountriesHeadView;
@protocol SelectCountriesHeadViewDelegate<NSObject>
- (void)selectHeadView:(CNSelectCountriesHeadView *)view countryName:(NSString *)name countryCode:(NSString *)code;

@end
@interface CNSelectCountriesHeadView : UIView
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) id<SelectCountriesHeadViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
