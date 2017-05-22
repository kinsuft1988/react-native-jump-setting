//
//  JumpSetting.m
//  JumpSetting
//
//  Created by kinsuft173 on 2017/5/22.
//  Copyright © 2017年 Oudmon-iOS. All rights reserved.
//

#import "JumpSetting.h"

@implementation JumpSetting

RCT_EXPORT_MODULE(JumpSetting);

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_REMAP_METHOD(start,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    // 弹窗
    NSString *message = @"测试";
    //部署target >= 8.0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"CAMERA_AlertTitle" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        resolve(@NO);
    }];
    [alertController addAction:cancelAction];
    // 快速跳转到设置界面
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
            resolve(@YES);
        });
    }];
    [alertController addAction:settingsAction];
    UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController presentViewController:alertController animated:YES completion:nil];
}

@end
