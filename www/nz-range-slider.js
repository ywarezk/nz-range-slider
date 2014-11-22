/**
 * JS api for the kochova plugin
 * 
 * Created June 22nd, 2014
 * @author: Yariv Katz
 * @version: 1.0
 * @copyright: Nerdz LTD
 * @website: http://www.nerdeez.com
 */

var RangeSlider= {
    callCordova: function (action, options, nzCallbackSuccess, nzCallbackError) {
        var args = Array.prototype.slice.call(arguments, 1);
        cordova.exec(nzCallbackSuccess,
                     nzCallbackError,
                     'RangeSlider',
                     action,
                     args
                     );
    },
    showSlider: function (options) {
        this.callCordova('showSlider', options, null, null);
    },
    hideSlider: function () {
        this.callCordova('hideSlider', null, null, null);
    },
    getMin: function (callback) {
        this.callCordova('getMin', null, callback, null);
    },
    getMax: function (callback) {
        this.callCordova('getMax', null, callback, null);
    },
};

module.exports = RangeSlider;
