//
//  SceneDelegate.m
//  VideoEditorController
//
//  Created by Jinwoo Kim on 6/26/23.
//

#import "SceneDelegate.h"

@interface SceneDelegate () <UINavigationControllerDelegate,UIVideoEditorControllerDelegate>
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    window.backgroundColor = UIColor.systemBackgroundColor;
    
    NSString *videoPath = [NSBundle.mainBundle URLForResource:@"demo" withExtension:@"mov"].path;
    NSAssert([UIVideoEditorController canEditVideoAtPath:videoPath], @"");
    
    UIViewController *rootViewController = [UIViewController new];
    UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
    configuration.title = @"Tap!";
    
    __block SceneDelegate *unretainedDelegate = self;
    __block UIViewController *unretainedRootViewController = rootViewController;
    UIButton *button = [UIButton buttonWithConfiguration:configuration primaryAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        UIVideoEditorController *videoEditorController = [UIVideoEditorController new];
        videoEditorController.delegate = unretainedDelegate;
        videoEditorController.videoPath = videoPath;
        videoEditorController.videoMaximumDuration = 5.f;
        videoEditorController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        /*
         To prevent crash without using popover presentation...
         
         (lldb) image lookup -vn UIImagePickerEnsureViewIsInsidePopover
         1 match found in /Users/pookjw/Library/Developer/Xcode/iOS DeviceSupport/iPad7,3 16.5.1 (20F75)/Symbols/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore:
                 Address: UIKitCore[0x000000018940e02c] (UIKitCore.__TEXT.__text + 7394056)
                 Summary: UIKitCore`UIImagePickerEnsureViewIsInsidePopover
                  Module: file = "/Users/pookjw/Library/Developer/Xcode/iOS DeviceSupport/iPad7,3 16.5.1 (20F75)/Symbols/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore", arch = "arm64"
                  Symbol: id = {0x00037173}, range = [0x00000001952ea02c-0x00000001952ea1ac), name="UIImagePickerEnsureViewIsInsidePopover"
         
         (lldb) p/x 0x00000001952ea02c + 248
         (long) 0x00000001952ea124
         
         (lldb) breakpoint set -a 0x00000001952ea124 -G1 -C "register write x21 0x1"
         Breakpoint 3: where = UIKitCore`UIImagePickerEnsureViewIsInsidePopover + 248, address = 0x00000001952ea124
         */
        
//        videoEditorController.modalPresentationStyle = UIModalPresentationPopover;
//        videoEditorController.popoverPresentationController.sourceView = action.sender;
        
        [unretainedRootViewController presentViewController:videoEditorController animated:YES completion:^{
            
        }];
    }]];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [rootViewController.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:rootViewController.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:rootViewController.view.centerYAnchor]
    ]];
    
    window.rootViewController = rootViewController;
    [rootViewController release];
    
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
}

- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
