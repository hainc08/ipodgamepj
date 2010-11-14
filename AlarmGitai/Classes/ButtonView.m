
#import "ButtonView.h"
#import "FontLabel.h"
#import "FontLabelStringDrawing.h"
#import "FontManager.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		TYPE = 0; // box 
		self.backgroundColor =[UIColor redColor];
		label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 0, 0)];
		[self addSubview:label];
		//fontName:@"굴림" pointSize:12.0f
		x	= frame.size.width;
		y	= frame.size.height;
		label.font =  [UIFont boldSystemFontOfSize:12];
		
		checkimage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 17, 62, 58)];
		[checkimage setImage:[UIImage imageNamed:@"check.png"]];
		[checkimage setTransform:CGAffineTransformMake(0.8, 0.0, 0.0, 0.8, 0.0, 0.0)];
		
		[self addSubview:checkimage];
    }
    return self;
}

- (void)setView:(int)_inTYPE  fontsize:(float)_insize fontColor:(UIColor *)_inColor  setText:(NSString *)_inText bgColor:(UIColor *)_inBgColor chekImage:(bool)_inCheck
{
	TYPE = _inTYPE;
	
	if(_insize > 0.0f)
		label.font =  [UIFont boldSystemFontOfSize:_insize];
	if(_inColor != nil)
		label.textColor = _inColor;
	if(_inBgColor != nil)
		self.backgroundColor = _inBgColor;
	
	if(_inText != nil)
	{
		label.textColor = [UIColor whiteColor];
		label.text = _inText;
		[label sizeToFit];
		label.backgroundColor = nil;
		label.opaque = NO;
	}
	
	if(_inCheck)
		[checkimage setAlpha:1];
	else 
		[checkimage setAlpha:0];
	
	[self setNeedsDisplay];
}

- (void)setText:(NSString *)_inText
{
	label.textColor = [UIColor whiteColor];
	label.text = _inText;
	[label sizeToFit];
	label.backgroundColor = nil;
	label.opaque = NO;

}

- (void)setCheck:(bool)_inCheck
{
	if(_inCheck)
		[checkimage setAlpha:1];
	else 
		[checkimage setAlpha:0];
	
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	if(TYPE == 0 )
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetRGBStrokeColor(context, 1,1,1,1);
		CGContextSetLineWidth(context, 1);
	
		int i = 0;
	
		while(i < y){
			if( i > ARRAY && i < y - ARRAY )
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, ARRAY, i);
				CGContextStrokePath(context);
				CGContextMoveToPoint(context, x - ARRAY, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
			
			}
			else 
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
			}
			i++;
		}
	}
}


- (void)dealloc {
    [super dealloc];
	[label release];
	[checkimage release];
}

@end

