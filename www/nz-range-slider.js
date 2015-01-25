/**
 * JS api for the kochova plugin
 * 
 * Created June 22nd, 2014
 * @author: Yariv Katz
 * @version: 1.0
 * @copyright: Nerdz LTD
 * @website: http://www.nerdeez.com
 * 
 * Updated January 25th, 2015
 * @author: Eli Kushelev
 * @version: 1.0
 * @copyright: Nerdz LTD
 */

var RangeSlider= {
    
    /***************************
     * begin private functions
     ***************************/
    
    /**
     * private function to invoke the native code
     * @param {String} action the action in native to invoke
     * @param {Object} options the options to pass the native code
     * @param {function} nzCallbackSuccess async callback for success response
     * @param {function} nzCallbackError async callback for error function
     */
    _callCordova: function (action, options, nzCallbackSuccess, nzCallbackError) {
        var args = Array.prototype.slice.call(arguments, 1);
        cordova.exec(nzCallbackSuccess,
                     nzCallbackError,
                     'RangeSlider',
                     action,
                     args
                     );
    },
    
    /***************************
     * end private functions
     ***************************/
    
    /***************************
     * begin public functions
     ***************************/
    
    /**
     * show the range slider with these configurations
     * @param {Object} options example: {minimumValue: 14, maximumValue: 60, stepValue:4}
     */
    showRangeSlider: function (options) {
        this._callCordova('showRangeSlider', options, null, null);
    },
    
    /**
     * show the single slider with these configurations
     * @param {Object} options example: {minimumValue: 14, maximumValue: 60}
     */
    showSingleSlider: function (options) {
        this._callCordova('showSingleSlider', options, null, null);
    },
    
    /**
     * hide the range slider from view
     */
    hideRangeSlider: function () {
        this._callCordova('hideRangeSlider', null, null, null);
    },
    
     /**
     * hide the single slider from view
     */
    hideSingleSlider: function () {
        this._callCordova('hideSingleSlider', null, null, null);
    },
    
    /**
     * get the left handlebar value 
     * @param {function} callback
     */
    getMin: function (callback) {
        this._callCordova('getMin', null, callback, null);
    },
    
    /**
     * get the right handlebar value 
     * @param {Object} callback
     */
    getMax: function (callback) {
        this._callCordova('getMax', null, callback, null);
    },
    
    /**
     * get the single slider value 
     * @param {Object} callback
     */
    getValue: function (callback) {
        this._callCordova('getValue', null, callback, null);
    },
    /***************************
     * end public functions
     ***************************/
    
};

module.exports = RangeSlider;
