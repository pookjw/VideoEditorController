# VideoEditorController

UIVideoEditorController with custom presentation style

![](0.png)

How to:

```
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
```
