import 'package:flutter/material.dart';

// App colors
const Color kPrimaryColor = Color(0xFF1E1F36);
const Color kAccentColor = Color(0xFF7101E3);
const Color kInactiveColor = Color(0xFF9098B1);
const Color kNavigationDrawerBackgroundColor = Color(0xFF001D24);
const Color kAppBarBackgroundColor = Color(0xFF001D24);
const Color kWidgetAccentColor = Color(0xFF7101E3);
const Color kActiveBackgroundColor = Color(0xFF0D8F11);
const Color kPendingBackgroundColor = Color(0xFFF1BB26);
const Color kClosedBackgroundColor = Color(0xFF001D24);
const Color kRegularTextColor = Color(0xFF6A6A6A);
const Color kSecondaryTextColor = Color(0xFF8D8D8D);
const Color kLightTextColor = Color(0xFFBBBEC3);
const Color kRedTextColor = Color(0xFFFF2C5D);
const Color kGreenTextColor = Color(0xFF0D8F11);
const Color kDividerColor = Color(0xFFE6E6E6);
const Color kDivider2Color = Color(0x80B2B2B2);
const Color kPremiumUserBackgroundColor = Color(0xFF908D6B);
const Color kCancelledBackgroundColor = Color(0xFF95989A);
const Color kApprovedStatusColor = Color(0xFF19BF3F);
const Color kDeclinedStatusColor = Color(0xFFFF0600);
const Color kPendingStatusColor = Color(0xFFF1BB26);
const Color kCommonBackgroundColor = Color(0xFFF9FAFB);
const Color kWhiteColor = Color(0xFFFFFFFF);

// Default values
const bool kDefaultBoolean = false;
const int kDefaultInt = 0;
const double kDefaultDouble = 0.0;
const String kDefaultString = '';

// Text styles
const TextStyle kAppBarTitleTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.w600,
);

// App Common
const String kNotificationDateTimeFormat = 'dd MMMM, yyyy, hh:mm a';
const String kTrackingOrderDateTimeFormat = 'MMMM dd, yyyy';
const String kBirthdayDateFormat = 'yyyy/MM/dd';
const String kReceivedDateFormat = 'yyyy-MM-dd HH:mm:ss'; // 2020-01-22 14:01:32
const String kSignalDateFormat = 'dd-MM-yyyy HH:mm'; // 22-01-2020 14:01
const String kResponseOfJsonType = 'application/json';
const String kSpaceString = ' ';
const String kNewLineString = '\n';
const String kPrefixAuthToken = 'Bearer ';
const String kStripePaymentGateway = 'stripe';
const String kMobile = 'mobile';
const String kFacebook = 'facebook';
const String kGoogle = 'google';
const String kKeyHeaderLanguage = 'Language';
const String kKeyHeaderCurrency = 'Currency';

// Regular Expression
const String kRegExpEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String kRegExpPhone = "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
    "([0-9][0-9\\- \\.]+[0-9])";

// API urls
//const String kDevBaseUrl = 'http://149.28.209.208/azzoa/';
const String kDevBaseUrl = 'http://149.28.209.208/azzoa-dev/';
const String kLiveBaseUrl = 'https://xyz.com/';
const String kBaseUrl = kDevBaseUrl;
const String kApiBaseUrl = kBaseUrl + 'api/';
const String kApiGetLanguageListUrl = kApiBaseUrl + 'languages';
const String kApiGetCurrencyListUrl = kApiBaseUrl + 'currencies';
const String kApiRegisterUrl = kApiBaseUrl + 'register';
const String kApiSendForgetPasswordOtpUrl = kApiBaseUrl + 'password/reset';
const String kApiResetPasswordUrl = kApiBaseUrl + 'password/reset';
const String kApiLoginUrl = kApiBaseUrl + 'login';
const String kApiSocialLoginUrl = kApiBaseUrl + 'login/social';
const String kApiSendVerificationEmailUrl =
    kApiBaseUrl + 'send-verification-email';
const String kApiVerifyEmailOtpUrl = kApiBaseUrl + 'verify-email-otp';
const String kApiSendVerificationSmsUrl = kApiBaseUrl + 'send-verification-sms';
const String kApiVerifyPhoneOtpUrl = kApiBaseUrl + 'verify-sms-otp';
const String kApiGetCategoriesUrl = kApiBaseUrl + 'categories';
const String kApiGetShopCategoriesUrl = kApiBaseUrl + 'shop-categories';
const String kApiGetProductsUrl = kApiBaseUrl + 'products';
const String kApiGetShopsUrl = kApiBaseUrl + 'shops';
const String kApiGetSingleShopUrl = kApiBaseUrl + 'shop';
const String kApiGetSingleProductUrl = kApiBaseUrl + 'product';
const String kApiCartUrl = kApiBaseUrl + 'cart';
const String kApiWishListUrl = kApiBaseUrl + 'wishlist';
const String kApiAddCouponToCartUrl = kApiBaseUrl + 'add-coupon';
const String kApiRemoveCouponFromCartUrl = kApiBaseUrl + 'remove-coupon';
const String kApiProfileUrl = kApiBaseUrl + 'profile';
const String kApiLogOutUrl = kApiBaseUrl + 'logout';
const String kApiGetHelpUrl = kApiBaseUrl + 'help';
const String kApiBannerUrl = kApiBaseUrl + 'banner';
const String kApiReviewUrl = kApiBaseUrl + 'review';
const String kApiNotificationUrl = kApiBaseUrl + 'notification';
const String kApiAddressUrl = kApiBaseUrl + 'address';
const String kApiPasswordUrl = kApiBaseUrl + 'password';
const String kApiShippingMethodsUrl = kApiBaseUrl + 'shipping-methods';
const String kApiPaymentMethodsUrl = kApiBaseUrl + 'payment-methods';
const String kApiOrderUrl = kApiBaseUrl + 'order';
const String kApiNearbyShopsUrl = kApiBaseUrl + 'nearby-shops';
const String kApiGetVariantUrl = kApiBaseUrl + 'get-variant';
const String kApiGetConfigUrl = kApiBaseUrl + 'config';
const String kApiGetNotificationUrl =
    kApiBaseUrl + 'notification/notification-type-unread-or-null';
const String kApiFollowShopUrl = kApiBaseUrl + 'follow-shop';
const String kApiUnfollowShopUrl = kApiBaseUrl + 'unfollow-shop';
const String kApiGetFollowedShopUrl = kApiBaseUrl + 'followed-shop';
const String kApiGetAttributeUrl = kApiBaseUrl + 'attributes';
const String kApiGetTransactionList = kApiBaseUrl + 'transaction?type&order_by=id&order=desc&paginate=1&perpage=15&limit';
const String kApiTokenUrl = kApiBaseUrl + 'token';

// API fields
const String kName = 'name';
const String kProvider = 'provider';
const String kAccessToken = 'accessToken';
const String kProviderUserId = 'provider_user_id';
const String kUserName = 'username';
const String kEmail = 'email';
const String kPhone = 'phone';
const String kCountry = 'country';
const String kOldPassword = 'old_password';
const String kPassword = 'password';
const String kPasswordConfirmation = 'password_confirmation';
const String kOtp = 'otp';
const String kKeyword = 'keyword';
const String kLimit = 'limit';
const String kTag = 'tag';
const String kShopId = 'shop_id';
const String kCategoryId = 'category_id';
const String kAttributes = 'attributes';
const String kOrderBy = 'order_by';
const String kOrder = 'order';
const String kPaginate = 'paginate';
const String kDiscount = 'discount';
const String kFreeShipping = 'free_shipping';
const String kShopOpen = 'shop_open';
const String kPage = 'page';
const String kProductId = 'product_id';
const String kQuantity = 'quantity';
const String kAttrsColor = 'attrs[color]';
const String kAttrsSize = 'attrs[size]';
const String kCode = 'code';
const String kReviewableType = 'reviewable_type';
const String kReviewableId = 'reviewable_id';
const String kRating = 'rating';
const String kContent = 'content';
const String kPushNotification = 'push_notification';
const String kType = 'type';
const String kState = 'state';
const String kCity = 'city';
const String kStreetAddress1 = 'street_address_1';
const String kStreetAddress2 = 'street_address_2';
const String kLatitude = 'latitude';
const String kLongitude = 'longitude';
const String kAvatar = 'avatar';
const String kPaymentMethod = 'payment_method';
const String kShippingMethod = 'shipping_method';
const String kShippingAddress = 'shipping_address';
const String kBillingAddress = 'billing_address';
const String kAppSignature = 'app_signature';
const String kOrderId = 'order_id';
const String kStar = 'star';
const String kToken = 'token';

// Keys
const String kKeyStatus = 'status';
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyName = 'name';
const String kKeyToken = 'token';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';
const String kKeyFaqText = 'faq_text';
const String kKeyTermsAndConditionsText = 'toc_text';
const String kKeyAverageRating = 'average_rating';
const String kKeyViews = 'views';
const String kKeyProvider = 'provider';

// Registration page
const String kHintBirthDate = 'Birth date';

// Important Keys
const String kApiKeyGoogleMap = 'AIzaSyAQYRbnd3NJqaJFSinQeCwBK_0jB1-IJE4';
