@interface SBAppSwitcherScrollView: UIScrollView
@end

// define our view
SBAppSwitcherScrollView *switcherView = nil;
// define our fade duration using a double
CGFloat fadeDuration = 0.3f;

//hooking our class from BSUIScrollView which is a subclass of UIScrollView
%hook SBAppSwitcherScrollView
-(void)layoutSubviews{
    %orig;
    if (switcherView == nil){
      switcherView = self;
      switcherView.backgroundColor = [UIColor blackColor];
    }
    switcherView.alpha = 0.0f;
    [UIView animateWithDuration:fadeDuration
    animations:^{
        switcherView.alpha = 0.72f;
        }
    ];
}
%end

//hooking the app switcher view controller for methods of closing
%hook SBDeckSwitcherViewController
//created fade for tapping outside a card
-(void)_handleDismissTapGesture:(id)arg1{
  %orig;
  [UIView animateWithDuration:fadeDuration
  animations:^{
      switcherView.alpha = 0.0f;
      }
  ];
}

//creates fade when leaving app switcher
- (void)willMoveToParentViewController:(id)arg1{
  %orig;
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
}

//creates fade for when you press home button
-(bool)handleHomeButtonSinglePressUp{
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
  return %orig;
}
%end