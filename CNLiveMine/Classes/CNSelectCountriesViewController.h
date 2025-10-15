//
//  CNSelectCountriesViewController.h
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CNSelectCountriesViewController;
@protocol SelectCountriesDelegate<NSObject>
- (void)selectViewController:(CNSelectCountriesViewController *)viewController countryName:(NSString *)name countryCode:(NSString *)code;

@end
@interface CNSelectCountriesViewController : UIViewController
@property (nonatomic, weak) id<SelectCountriesDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
