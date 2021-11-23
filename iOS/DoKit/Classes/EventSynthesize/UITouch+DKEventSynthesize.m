/**
 * Copyright 2017 Beijing DiDi Infinity Technology and Development Co., Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "UITouch+DKEventSynthesize.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITouch (APLPrivate)

- (void)setTimestamp:(NSTimeInterval)timestamp;

- (void)setPhase:(UITouchPhase)phase;

- (void)setTapCount:(NSUInteger)tapCount;

- (void)setWindow:(nullable UIWindow *)window;

- (void)setView:(nullable UIView *)view;

- (void)_setLocationInWindow:(CGPoint)locationInWindow resetPrevious:(BOOL)resetPrevious;

@end

NS_ASSUME_NONNULL_END

@implementation UITouch (DKEventSynthesize)

- (instancetype)initWithPoint:(CGPoint)point window:(UIWindow *)window {
    self = [self init];
    
    self.timestamp = NSProcessInfo.processInfo.systemUptime;
    self.phase = UITouchPhaseBegan;
    self.tapCount = 1;
    self.window = window;
    // - hitTest:withEvent: can pass event with nil
    // and could return nil as hitTestView.
    // Then we use window as hitTestView
    self.view = [window hitTest:point withEvent:nil] ?: window;
    [self _setLocationInWindow:point resetPrevious:YES];
    
    return self;
}

//- (void)dk_updateTimestampWithPhase:(UITouchPhase)phase {
//    if (__builtin_expect(self.phase != phase, NO)) {
//        self.phase = phase;
//    }
//    self.timestamp = NSProcessInfo.processInfo.systemUptime;
//}

//- (void)dk_updateWithLocationInWindow:(CGPoint)locationInWindow {
//    [self _setLocationInWindow:locationInWindow resetPrevious:NO];
//}

@end