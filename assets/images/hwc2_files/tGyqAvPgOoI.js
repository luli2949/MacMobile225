if (self.CavalryLogger) { CavalryLogger.start_js(["Jbc8v"]); }

__d("adsAssetFeedHasCallToActionValue",["AdsAPIAdAssetCallToActionFields","immutable"],(function(a,b,c,d,e,f){"use strict";function a(a,c,d){a=(a=a.creative)==null?void 0:(a=a.asset_feed_spec)==null?void 0:a.call_to_actions;if(a==null)return!1;a instanceof Array&&(a=b("immutable").fromJS(a));return a instanceof b("immutable").List?a.hasIn([c,b("AdsAPIAdAssetCallToActionFields").VALUE,d]):!1}e.exports=a}),null);