@interface SBAppSwitcherScrollView: UIScrollView
@end

SBAppSwitcherScrollView *switcherView = nil;
CGFloat fadeDuration = 0.3f;

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

%hook SBDeckSwitcherViewController
-(void)_handleDismissTapGesture:(id)arg1{
  %orig;
  [UIView animateWithDuration:fadeDuration
  animations:^{
      switcherView.alpha = 0.0f;
      }
  ];
}

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