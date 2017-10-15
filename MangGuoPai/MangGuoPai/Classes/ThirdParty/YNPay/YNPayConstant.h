//
//  YNPayConstant.h
//  0_13封装支付
//
//  Created by ZYN on 16/11/3.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

/*
 *  支付宝重要信息定义
 */

/** partner */
#define YNPay_Alipay_AppId @"2088121820533203"

/** privateKey：PKCS8格式的私钥 */
#define YNPay_Alipay_PrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAL4pAzAE8qM6uBUB4LT8jfIgpsS+k9uGVGvVvkaFGpTWi1kyrU3ljwIZsmAAK0Qivlsn9rg9D+IQnVCuUKzmysWsQp9FqlptfL3OLfCcwzlZvi+4+vKI/Ad8aGCR21cd9LfKDXv8fxZMfEjboTkFTLiPYsDDClK7OGYaGFtIoa8FAgMBAAECgYAoi+ooFQX/lAeoQww8yxUhKaElllVEm7HohFzcAImYbt6rmEinsWj606vbGG4hSx83pJ/QzQRT+aLxjxmYpGVbvc/dXj1Pv6a8c59B5gsXC32+yuZIBpvzMmMenCUhRpffJpHczqwiom7MUpRA5HkTVIC9xOIidvMVqCYLc2EDgQJBAP1NrobAtfi7lorKB9m4ACfQZz6q4fWIsPGjJsBKKkawyNDRCTf+WPvucpNlGlzmR/JaF8JX+FoEXNiUjoaBYJECQQDALz+zsEPkt0JCjYpa0rSWDM/B2ZemPz2C2bnG8kfGpYu1i2GS6ZPm0qs0n0aeQGlnNYndtS+swxopJ7IPBiE1AkEA4uqyTHlbC0ZRaGfwfHQ/f2tM8nD3F5Sqnu1/i4dlNAqu+5In5gdvA9HqxmwuH8cT8OIQosNX8pwx6Lu8qnZAYQJASfxmm7iKCqz6V0DCOMDRQMrh2JD6Lsg91/gV6x8uvqzQoi1sfPBrPftwaau/tgC6Ez+rOa0dE3dwxNNBW0NS2QJAfwN/OEdzH8/Wc4pwijMXZALj+qnkkCNM5rjrx7NDeZp9rKHS26Wd+Fp0z1G4KysSLliKrs8+ZXLniqx4dn0lgg=="

/** RedirectURL */
#define YNPay_Alipay_RedirectURL @"http://112.74.125.78/yeah/index.php/Home/YeahPay/pay_callback"

/** appScheme */
#define YNPay_Alipay_AppScheme @"test111"



/*
 *  微信支付重要信息定义
 */

/** 微信开发平台：AppID */
#define YNPay_WeChat_AppID @"wx8f69e8edc2d6cda7"

/** 微信支付商号 */
#define YNPay_WeChat_Mch_id @"1309808001"

/** 回调URL */
#define YNPay_WeChat_RedirectURL YNPay_Alipay_RedirectURL

/** API_PartnerKey */
#define YNPay_WeChat_API_PartnerKey @"c444b3dd92bc485e1c8e0de95449c82d"


