# ZMMessageView
a simple message warning(top toast)

一个简单的message提示. 如图:
![message](https://raw.githubusercontent.com/kuanglijun312/ZMMessageView/master/screenshot/message-01.png) 

思路很简单；在最顶层的window添加一个包含uilabelview的uiview而已；在ios中任何view都可以addsubview--window也是view；

部分代码:

寻找最顶层window:

	var applicationKeyWindow:UIWindow! = nil
        let frontToBackWindows = UIApplication.sharedApplication().windows.reverse()
        for window in frontToBackWindows {
            if window.windowLevel == UIWindowLevelNormal {
                applicationKeyWindow = window;
                break
            }
        }
        
清除动画: 

	ZMMessageView.sharedInstance.layer.removeAllAnimations()
	
延迟执行:

	let delay = 2 * Double(NSEC_PER_SEC)
	let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
	dispatch_after(time, dispatch_get_main_queue()) {
		ZMMessageView.dismiss()
	}


[我的主页](https://kuanglijun312.github.io/)

