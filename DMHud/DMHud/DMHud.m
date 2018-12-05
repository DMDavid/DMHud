//
//  DMHud.m
//  DMHud
//
//  Created by Santiago on 2018/12/5.
//  Copyright © 2018 David. All rights reserved.
//

#import "DMHud.h"

#define IOS_VERSION_8_BELOW (([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)? (YES):(NO))

@interface DMHud ()

@property (nonatomic, assign) NSInteger fontFloat;
@property (nonatomic, assign) HudShowStyle hudShowStyle;

@end

@implementation DMHud

+ (instancetype)shareHUD {
    static DMHud *_shareHUD;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == _shareHUD) {
            _shareHUD = [[DMHud alloc] init];
        }
    });
    
    return _shareHUD;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return self;
}

/**
 *  显示提示信息, 使用默认显示时常1.5秒
 *
 *  @param text      要显示的文字
 */
+ (void)showText:(NSString *)text {
    [DMHud showText:text withTimeInterval:1.5];
}

/**
 *  显示提示信息
 *
 *  @param text      要显示的文字
 *  @param interval 显示的时间
 */
+ (void)showText:(NSString *)text withTimeInterval:(CGFloat)interval {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        DMHud *hud = [DMHud shareHUD];
        [hud prepareToShow];
        
        if (IOS_VERSION_8_BELOW) {
            hud.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:hud.fontFloat];
        textLabel.text = text;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - 10.0;
        CGSize labelSize = [textLabel sizeThatFits:CGSizeMake(labelWidth / 2, MAXFLOAT)];
        
        hud.bounds = CGRectMake(0.0, 0.0, labelSize.width + 30.f, labelSize.height + 30.f);
        hud.center = [UIApplication sharedApplication].keyWindow.center;
        
        CGFloat textLabelW = labelSize.width;
        CGFloat textLabelH = labelSize.height;
        CGFloat textLabelX = (CGRectGetWidth(hud.bounds) - textLabelW) / 2;
        CGFloat textLabelY = (CGRectGetHeight(hud.bounds) - textLabelH) / 2;
        textLabel.frame = CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
        [hud addSubview:textLabel];
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        
        [hud performSelector:@selector(hiddenHUD) withObject:nil afterDelay:interval];
        
        //set animation
        if (hud.hudShowStyle == HudShowStylePop) {
            [hud appearPopAnimation];
        }
    });
}

/**
 *  显示服务器返回的错误提示
 *
 *  @param errorDict 服务器返回的错误信息
 *  @param interval 显示的时间
 */
+ (void)showErrorWithData:(NSDictionary *)errorDict withTimeInterval:(CGFloat)interval;
{
    if ([errorDict isKindOfClass:[NSDictionary class]]) {
        id errorInfo = [errorDict valueForKey:@"error"];
        if ([errorInfo isKindOfClass:[NSString class]]) {
            [DMHud showText:errorInfo withTimeInterval:interval];
        }
        
        if ([errorInfo isKindOfClass:[NSDictionary class]]) {
            NSArray *values = [errorInfo allValues];
            id firstObj = [values firstObject];
            if ([firstObj isKindOfClass:[NSArray class]]) {
                NSString *errorString = [NSString stringWithFormat:@"%@", [firstObj firstObject]];
                [DMHud showText:errorString withTimeInterval:interval];
            }
        }
    }
}

- (void)prepareToShow {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenHUD) object:nil];
    
    DMHud *hud = [DMHud shareHUD];
    for (UIView *subView in hud.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)appearPopAnimation {
    DMHud *hud = [DMHud shareHUD];
    
    hud.transform = CGAffineTransformMakeScale(1.20, 1.20);
    //缩小动画
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:15.f initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

    }];
}

- (void)hiddenHUD {
    DMHud *hud = [DMHud shareHUD];
    
    if (self.hudShowStyle == HudShowStyleEaseOut) {
        
        [UIView animateWithDuration:0.25 animations:^{
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            
            [self removeHudFromCurrentView];
            hud.alpha = 1;
        }];
    } else {
        
        [self removeHudFromCurrentView];
    }
}

- (void)removeHudFromCurrentView {
    DMHud *hud = [DMHud shareHUD];
    for (UIView *subView in hud.subviews) {
        [subView removeFromSuperview];
    }
    hud.transform = CGAffineTransformIdentity;
    [hud removeFromSuperview];
}

+ (void)dismiss {
    [[self shareHUD] hiddenHUD];
}


#pragma mark - config mothod

/**
 *  text font
 */
+ (void)setHudTextFont:(CGFloat)textFont {
    [DMHud shareHUD].fontFloat = textFont;
}

/**
 *  set show hud style
 */
+ (void)setHudShowStyle:(HudShowStyle)hudShowStyle {
    [DMHud shareHUD].hudShowStyle = hudShowStyle;
}

#pragma mark - private mothod

- (NSInteger)fontFloat {
    if (_fontFloat == 0) {
        _fontFloat = 18.0;
    }
    return _fontFloat;
}

@end
