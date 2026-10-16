#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// This is also the target's Swift bridging header. Keep SDK-specific types out
// of this interface so Swift can import it when built with an older SDK.
UIKIT_EXTERN NS_SWIFT_UI_ACTOR UIView *CalculatorMakeHingeObserverView(void (^changeHandler)(BOOL hasHinge));

NS_ASSUME_NONNULL_END
