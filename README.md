# DMHud
simply hud for iOS 
like ![Image text](https://github.com/DMDavid/DMHud/blob/master/Example_Image/WechatIMG1.png)
  
  
  

  HOW TO USE
  =
	pod 'DMHud'

  
    



	/**
	 *  dissmiss
	 */
	+ (void)dismiss;
	
	/**
	 *  显示提示信息, 使用默认显示时常1.5秒
	 *
	 *  @param text      要显示的文字
	 */
	+ (void)showText:(NSString *)text;
	
	/**
	 *  显示提示信息
	 *
	 *  @param text      要显示的文字
	 *  @param interval 显示的时间
	 */
	+ (void)showText:(NSString *)text withTimeInterval:(CGFloat)interval;
	
	/**
	 *  显示服务器返回的错误提示
	 *
	 *  @param errorDict 服务器返回的错误信息
	 *  @param interval 显示的时间
	 */
	+ (void)showErrorWithData:(NSDictionary *)errorDict withTimeInterval:(CGFloat)interval;
	
	
	#pragma mark - config style mothod
	
	/**
	 *  set text font
	 *  default is 18.f
	 */
	+ (void)setHudTextFont:(CGFloat)textFont;
	
	/**
	 *  set show hud style
	 *  default is Pop
	 */
	+ (void)setHudShowStyle:(HudShowStyle)hudShowStyle;

