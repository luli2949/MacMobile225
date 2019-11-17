if (self.CavalryLogger) { CavalryLogger.start_js(["vJ4my"]); }

__d("AdsFBIconDownsized.react",["cx","Image.react","React","joinClasses"],(function(a,b,c,d,e,f,g){"use strict";__p&&__p();a=function(a){babelHelpers.inheritsLoose(c,a);function c(){return a.apply(this,arguments)||this}var d=c.prototype;d.render=function(){var a=this.props,c=a.className;a=babelHelpers.objectWithoutPropertiesLoose(a,["className"]);return b("React").jsx("span",{className:b("joinClasses")(c,"_kcu"),children:b("React").jsx(b("Image.react"),babelHelpers["extends"]({className:"_kcw"},a))})};return c}(b("React").Component);a.defaultProps={alt:""};e.exports=a}),null);
__d("BUISwitch.react",["cx","fbt","BUIComponent","Event","Keys","React"],(function(a,b,c,d,e,f,g,h){"use strict";__p&&__p();a=b("React").PropTypes;c=function(a){__p&&__p();babelHelpers.inheritsLoose(c,a);function c(){__p&&__p();var c,d;for(var e=arguments.length,f=new Array(e),g=0;g<e;g++)f[g]=arguments[g];return(c=d=a.call.apply(a,[this].concat(f))||this,d.$BUISwitch1=function(a){if(d.props.disabled)return;d.props.onToggle&&d.props.onToggle(!d.props.value);d.props.preventEventBubbling&&a.stopPropagation()},d.$BUISwitch2=function(a){if(d.props.disabled)return;var c=b("Event").getKeyCode(a);(c===b("Keys").RETURN||c===b("Keys").SPACE)&&(a.preventDefault(),d.props.onToggle&&d.props.onToggle(!d.props.value),d.props.preventEventBubbling&&a.stopPropagation())},c)||babelHelpers.assertThisInitialized(d)}var d=c.prototype;d.render=function(){return b("React").jsxs("div",babelHelpers["extends"]({},this.props,{className:"_128j"+(this.props.value?" _128k":"")+(this.props.value?"":" _128l")+(this.props.disabled?" _128m":"")+(this.props.animate?" _128n":"")+(this.props.inline?" _3n6a":""),children:[b("React").jsx("div",{"aria-checked":this.props.value?"true":"false",className:"_128o",onClick:this.$BUISwitch1,onKeyDown:this.$BUISwitch2,onMouseDown:this.$BUISwitch3,role:"checkbox",tabIndex:this.props.disabled?"-1":"0",children:b("React").jsx("div",{className:"_128p"})}),this.$BUISwitch4()]}))};d.$BUISwitch4=function(){return!this.props.showLabel?null:b("React").jsx("span",{className:"_128q",children:this.props.value?h._("ON"):h._("OFF")})};d.$BUISwitch3=function(a){a.preventDefault()};return c}(b("BUIComponent"));c.propTypes={animate:a.bool.isRequired,disabled:a.bool,onToggle:a.func,showLabel:a.bool,value:a.bool.isRequired,preventEventBubbling:a.bool,inline:a.bool};c.defaultProps={animate:!0};e.exports=c}),null);
__d("TextInputControl",["DOMControl","Event","Input","debounce"],(function(a,b,c,d,e,f){__p&&__p();a=function(a){"use strict";__p&&__p();babelHelpers.inheritsLoose(c,a);function c(c){c=a.call(this,c)||this;var d=c.getRoot(),e=b("debounce")(c.update.bind(babelHelpers.assertThisInitialized(c)),0);b("Event").listen(d,{input:e,keydown:e,paste:e});return c}var d=c.prototype;d.setMaxLength=function(a){b("Input").setMaxLength(this.getRoot(),a);return this};d.getValue=function(){return b("Input").getValue(this.getRoot())};d.isEmpty=function(){return b("Input").isEmpty(this.getRoot())};d.setValue=function(a){b("Input").setValue(this.getRoot(),a);this.update();return this};d.clear=function(){return this.setValue("")};d.setPlaceholderText=function(a){b("Input").setPlaceholder(this.getRoot(),a);return this};return c}(b("DOMControl"));e.exports=a}),null);
__d("transferTextStyles",["Style"],(function(a,b,c,d,e,f){var g={fontFamily:null,fontSize:null,fontStyle:null,fontWeight:null,lineHeight:null,wordWrap:null};function a(a,c){for(var d in g)Object.prototype.hasOwnProperty.call(g,d)&&(g[d]=b("Style").get(a,d));b("Style").apply(c,g)}e.exports=a}),null);
__d("TextMetrics",["DOM","Style","UserAgent","transferTextStyles"],(function(a,b,c,d,e,f){__p&&__p();function g(a){var c=a.clientWidth,d=b("Style").get(a,"-moz-box-sizing")=="border-box";if(d&&b("UserAgent").isBrowser("Firefox < 29"))return c;d=b("Style").getFloat(a,"paddingLeft")+b("Style").getFloat(a,"paddingRight");return c-d}a=function(){"use strict";__p&&__p();function a(a,c){this.$1=a;this.$2=!!c;c="textarea";var d="textMetrics";this.$2&&(c="div",d+=" textMetricsInline");this.$3=b("DOM").create(c,{className:d});b("transferTextStyles")(a,this.$3);document.body.appendChild(this.$3)}var c=a.prototype;c.measure=function(a){var c=this.$1,d=this.$3;a=(a||c.value)+"...";if(!this.$2){var e=g(c);b("Style").set(d,"width",Math.max(e,0)+"px")}c.nodeName==="TEXTAREA"?d.value=a:b("DOM").setContent(d,a);return{width:d.scrollWidth,height:d.scrollHeight}};c.destroy=function(){b("DOM").remove(this.$3)};return a}();e.exports=a}),null);
__d("TextAreaControl",["Arbiter","ArbiterMixin","CSS","DOMControl","Event","Style","TextInputControl","TextMetrics","classWithMixins","mixin"],(function(a,b,c,d,e,f){__p&&__p();function g(a,c){return b("Style").getFloat(a,c)||0}a=function(a){"use strict";__p&&__p();babelHelpers.inheritsLoose(c,a);function c(c){var d;d=a.call(this,c)||this;d.autogrow=b("CSS").hasClass(c,"uiTextareaAutogrow");d.autogrowWithPlaceholder=b("CSS").hasClass(c,"uiTextareaAutogrowWithPlaceholder");d.width=null;b("Event").listen(c,"focus",d._handleFocus.bind(babelHelpers.assertThisInitialized(d)));return d}var d=c.prototype;d.setAutogrow=function(a){this.autogrow=a;return this};d.onupdate=function(){a.prototype.onupdate.call(this),this.updateHeight()};d.updateHeight=function(){__p&&__p();if(this.autogrow){var a=this.getRoot();this.metrics||(this.metrics=new(b("TextMetrics"))(a));typeof this.initialHeight==="undefined"&&(this.isBorderBox=b("Style").get(a,"box-sizing")==="border-box"||b("Style").get(a,"-moz-box-sizing")==="border-box"||b("Style").get(a,"-webkit-box-sizing")==="border-box",this.borderBoxOffset=g(a,"padding-top")+g(a,"padding-bottom")+g(a,"border-top-width")+g(a,"border-bottom-width"),this.initialHeight=a.offsetHeight-this.borderBoxOffset);var c;(!a.value||a.value.length===0)&&this.autogrowWithPlaceholder?c=this.metrics.measure(a.placeholder):c=this.metrics.measure();c=Math.max(this.initialHeight,c.height);this.isBorderBox&&(c+=this.borderBoxOffset);this.maxHeight&&c>this.maxHeight&&(c=this.maxHeight,b("Arbiter").inform("maxHeightExceeded",{textArea:a}));c!==this.height&&(this.height=c,b("Style").set(a,"height",c+"px"),b("Arbiter").inform("reflow"),this.inform("resize"))}else this.metrics&&(this.metrics.destroy(),this.metrics=null)};d.resetHeight=function(){this.height=-1,this.update()};d.setMaxHeight=function(a){this.maxHeight=a};d.setAutogrowWithPlaceholder=function(a){this.autogrowWithPlacedholder=a};d._handleFocus=function(){this.width=null};c.getInstance=function(a){return b("DOMControl").getInstance(a)||new c(a)};return c}(b("classWithMixins")(b("TextInputControl"),b("mixin")(b("ArbiterMixin"))));e.exports=a}),null);
__d("AbstractTextArea.react",["cx","AbstractTextField.react","React","TextAreaControl"],(function(a,b,c,d,e,f,g){__p&&__p();a=b("React").Component;c=b("React").PropTypes;d=function(a){"use strict";__p&&__p();babelHelpers.inheritsLoose(c,a);function c(){return a.apply(this,arguments)||this}var d=c.prototype;d.componentDidUpdate=function(){this.$2&&this.$2.onupdate()};d.componentWillUnmount=function(){this.$2=null};d.render=function(){var a=this;return b("React").jsx(b("AbstractTextField.react"),babelHelpers["extends"]({},this.props,{children:b("React").jsx("textarea",{className:"_58an",onClick:this.props.onClick,onMouseDown:this.props.onMouseDown,onKeyUp:this.props.onKeyUp,rows:this.props.rows,tabIndex:this.props.tabIndex,ref:function(b){a.$1=b,a.$3()}})}))};d.$3=function(){if(this.$1&&this.props.autoGrow&&!this.$2){var a=new(b("TextAreaControl"))(this.$1);a.setAutogrow(!0);a.onupdate();this.$2=a}};d.focusInput=function(){this.$1&&this.$1.focus()};d.blurInput=function(){this.$1&&this.$1.blur()};d.getTextFieldDOM=function(){return this.$1};d.getValue=function(){return this.$1?this.$1.value:""};return c}(a);d.propTypes=babelHelpers["extends"]({},b("AbstractTextField.react").propTypes,{autoGrow:c.bool});e.exports=d}),null);
__d("Alignment",["invariant","DOMVector","Style","containsNode"],(function(a,b,c,d,e,f,g){__p&&__p();var h=function(){"use strict";__p&&__p();function a(a,b,c){this.$1=b,this.$2=c,this.$3=a}var c=a.prototype;c.getElement=function(){return this.$3};c.getX=function(){return this.$1};c.getY=function(){return this.$2};c.isCorner=function(){return(this.$1===a.LEFT||this.$1===a.RIGHT)&&(this.$2===a.TOP||this.$2===a.BOTTOM)};c.getPosition=function(a){return b("DOMVector").getElementPosition(this.$3,a).add(this.getX()*this.$3.offsetWidth,this.getY()*this.$3.offsetHeight)};return a}();Object.assign(h,{LEFT:0,CENTER:.5,RIGHT:1,TOP:0,MIDDLE:.5,BOTTOM:1});a=function(){"use strict";__p&&__p();function a(a,c,d){this.$1=a,this.$2=c,this.$3=d,b("containsNode")(a.getElement(),c.getElement())||g(0,5861),a.isCorner()||g(0,5862)}var c=a.prototype;c.align=function(){var b=this;a.$4(this.$1,function(){return a.measure(b.$2,b.$3)})};a.$4=function(a,c){var d=a.getElement();b("Style").apply(d,{left:a.getX()===h.LEFT?"0":"",right:a.getX()===h.RIGHT?"0":"",top:a.getY()===h.TOP?"0":"",bottom:a.getY()===h.BOTTOM?"0":""});c=c();a.getX()===h.LEFT?b("Style").set(d,"left",c.x+"px"):a.getX()===h.RIGHT&&b("Style").set(d,"right",-c.x+"px");a.getY()===h.TOP?b("Style").set(d,"top",c.y+"px"):a.getY()===h.BOTTOM&&b("Style").set(d,"bottom",-c.y+"px")};a.position=function(c,d){a.$4(c,function(){var a=b("DOMVector").getElementPosition(c.getElement());return d.convertTo("document").sub(a)})};a.measure=function(a,b){a=a.getPosition("document");b=b.getPosition("document");return b.sub(a)};return a}();a.Anchor=h;e.exports=a}),null);
__d("sumOfArray",[],(function(a,b,c,d,e,f){function a(a){var b=0,c=a.length;for(var d=0;d<c;++d)b+=a[d];return b}e.exports=a}),null);