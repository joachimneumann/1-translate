#import "CalculatorHingeObserver.h"
#import <TargetConditionals.h>

// Runtime availability alone cannot hide an API missing from the build SDK.
#if __has_include(<UIKit/UIHingeInteraction.h>) && !TARGET_OS_MACCATALYST
#import <UIKit/UIHingeInteraction.h>
#endif

UIView *CalculatorMakeHingeObserverView(void (^changeHandler)(BOOL)) {
    UIView *view = [[UIView alloc] init];

#if __has_include(<UIKit/UIHingeInteraction.h>) && !TARGET_OS_MACCATALYST
    if (@available(iOS 27.1, *)) {
        UIHingeInteraction *interaction = [[UIHingeInteraction alloc]
            initWithUpdateHandler:^(UIHingeInteraction *interaction, UIHingeInteractionUpdate *update) {
                changeHandler(update.hinge != nil);
            }];
        [view addInteraction:interaction];
        return view;
    }
#endif

    changeHandler(NO);
    return view;
}
