//
//  NSObject+LinearFormula.h
//  Meituan
//
//  Created by wh on 2017/7/31.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <Foundation/Foundation.h>

struct HMValue {
    CGFloat consult;
    CGFloat result;
};
typedef struct HMValue HMValue;


CG_INLINE HMValue
HMValueMake(CGFloat consult, CGFloat result)
{
    HMValue value; value.consult = consult; value.result = result; return value;
}
@interface NSObject (LinearFormula)
- (CGFloat)resultWithValue1:(HMValue)value1 andValue2:(HMValue)value2;
@end
