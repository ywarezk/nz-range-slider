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
    
    /**
     * invoke the native code
     * @param {String} action the action in native to invoke
     * @param {Object} options the options to pass the native code
     * @param {function} nzCallbackSuccess async callback for success response
     * @param {function} nzCallbackError async callback for error function
     */
    callCordova: function (action, options, nzCallbackSuccess, nzCallbackError) {
        var args = Array.prototype.slice.call(arguments, 1);
        cordova.exec(nzCallbackSuccess,
                     nzCallbackError,
                     'RangeSlider',
                     action,
                     args
                     );
    },
    
    /**
     * show the slider with these configurations
     * @param {Object} options example: {minimumValue: 14, maximumValue: 60, stepValue:4}
     */
    showSlider: function (options) {
        this.callCordova('showSlider', options, null, null);
    },
    
    /**
     * hide the slider from view
     */
    hideSlider: function () {
        this.callCordova('hideSlider', null, null, null);
    },
    
    /**
     * get the left handlebar value 
     * @param {function} callback
     */
    getMin: function (callback) {
        this.callCordova('getMin', null, callback, null);
    },
    
    /**
     * get the right handlebar value 
     * @param {Object} callback
     */
    getMax: function (callback) {
        this.callCordova('getMax', null, callback, null);
    },
};

module.exports = RangeSlider;
