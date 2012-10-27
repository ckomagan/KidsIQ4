//
//  KidsIQ4AppDelegate.h
//  KidsIQ4
//
//  Created by Chan Komagan on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class SLViewController;

@interface KidsIQ4AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SLViewController *viewController;
-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
