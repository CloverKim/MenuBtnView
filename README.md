# MenuBtnView

This a simple but useful MenuBtnView

![image](https://github.com/CloverKim/MenuBtnView/blob/master/run.gif)

# Requirements

iOS 8.0 or later

# Usage
```
var menuView: MenuBtnView?

```
In your button click method
```
let imageNames = ["lefttime_schedule", "lefttime_memo", "lefttime_riji"]
let titleNames = [NSLocalizedString("提醒", comment: ""), NSLocalizedString("备忘", comment: ""), NSLocalizedString("日记", comment: "")]
menuView = MenuBtnView(frame: view.frame, imageNames: imageNames, titleNames: titleNames, isFromTabBar: false, distance: 8, selectAction: { (index) in
    print(titleNames[index])
})

menuView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
menuView?.showInView(superView: view)

menuView?.dismissBlock = { [weak self] in
    self?.menuView = nil
}
```

# Install
Installation with CocoaPods：``` pod 'MenuBtnView' ```

# License
[MIT license](https://opensource.org/licenses/mit-license.php)
