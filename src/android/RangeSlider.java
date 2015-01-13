package com.nerdeez.LearnIonic;

import org.apache.cordova.CordovaActivity;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;

import android.util.Log;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.graphics.PixelFormat;
import android.view.Gravity;
import android.view.WindowManager;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class RangeSlider extends CordovaPlugin {
    
    /*************************************************************************************************************************************
     * 													begin private memebers
     *************************************************************************************************************************************/
    
    private int _minValue = 0;
    private int _maxValue = 100;
    private int _stepValue = 1;
    private int _lowerValue = 0;
    private int _upperValue = 100;
    private boolean _isMonoSlider = true;
    private LinearLayout barLayout;
    /*************************************************************************************************************************************
     * 													end private members
     *************************************************************************************************************************************/
    /*************************************************************************************************************************************
     * 													begin public memebers
     *************************************************************************************************************************************/
    
    public SeekBar monoBar;
    public RangeSeekBar<Integer> rangeBar;
    
    /*************************************************************************************************************************************
     * 													end public members
     *************************************************************************************************************************************/
    
    /*************************************************************************************************************************************
     * 													begin constants
     *************************************************************************************************************************************/
    
    public static final String TAG = "RangeSliderPlugin";
    private static final String ACTION_SHOW_SLIDER = "showSlider";
    private static final String ACTION_HIDE_SLIDER = "hideSlider";
    private static final String ACTION_GET_MIN = "getMin";
    private static final String ACTION_GET_MAX = "getMax";
    /*************************************************************************************************************************************
     * 													end constants
     *************************************************************************************************************************************/
    
    /**
     * Constructor.
     */
    public RangeSlider() {}
    /**
     * Sets the context of the Command. This can then be used to do things like
     * get file paths associated with the Activity.
     *
     * @param cordova The context of the main Activity.
     * @param webView The CordovaWebView Cordova is running in.
     */
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        Log.v(TAG,"Init RangeSlider");
    }
    
    public boolean execute(final String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        
        // create and show the range slider
        if (action.equals(ACTION_SHOW_SLIDER)) {
            // getting the input args
            JSONObject obj = args.getJSONObject(0);
            _isMonoSlider = obj.optBoolean("isSingleSlider",true);
            _minValue = obj.optInt("minimumValue", 0);
            _maxValue = obj.optInt("maximumValue", 100);
            _stepValue = obj.optInt("stepValue", 1);
            _lowerValue = obj.optInt("lowerValue", 0);
            _upperValue = obj.optInt("upperValue", 100);
            
            //Toast.makeText(cordova.getActivity().getApplicationContext(), obj.toString(), Toast.LENGTH_LONG).show();
            
            //constructing the range slider view
            WindowManager localWindowManager = (WindowManager)cordova.getActivity().getSystemService("window");
            WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams();
            layoutParams.format = PixelFormat.TRANSLUCENT;
            layoutParams.type=WindowManager.LayoutParams.TYPE_TOAST;
            layoutParams.height = LinearLayout.LayoutParams.WRAP_CONTENT;
            layoutParams.width = LinearLayout.LayoutParams.MATCH_PARENT;
            layoutParams.gravity=Gravity.BOTTOM;
            layoutParams.y = 10;
            barLayout = new LinearLayout(this.cordova.getActivity());
            barLayout.setOrientation(1);//set vertical orientation
            
            if(_isMonoSlider){
                monoBar = new SeekBar(this.cordova.getActivity());
                monoBar.setMax(_upperValue);
                monoBar.setProgress(_maxValue);
                
                monoBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                    
                    @Override
                    public void onStopTrackingTouch(SeekBar seekBar) {
                        // TODO Auto-generated method stub
                        
                    }
                    
                    @Override
                    public void onStartTrackingTouch(SeekBar seekBar) {
                        // TODO Auto-generated method stub
                        
                    }
                    
                    @Override
                    public void onProgressChanged(SeekBar seekBar, int progress,
                                                  boolean fromUser) {
                        // TODO Auto-generated method stub
                        _maxValue = progress;
                        
                        //bind javascript observer
                        CordovaActivity act = (CordovaActivity)cordova.getActivity();
                        act.loadUrl("javascript:cordova.fireDocumentEvent('rangeChanged');");
                    }
                });
                
                barLayout.addView(monoBar);
            }else{
                rangeBar = new RangeSeekBar<Integer>(_lowerValue, _upperValue,this.cordova.getActivity());
                rangeBar.setSelectedMinValue(_minValue);
                rangeBar.setSelectedMaxValue(_maxValue);
                
                rangeBar.setOnRangeSeekBarChangeListener(new RangeSeekBar.OnRangeSeekBarChangeListener<Integer>() {
                    @Override
                    public void onRangeSeekBarValuesChanged(RangeSeekBar<?> bar, Integer minValue, Integer maxValue) {
                        // handle changed range values
                        _minValue = minValue.intValue();
                        _maxValue = maxValue.intValue();
                        
                        //bind javascript observer
                        CordovaActivity act = (CordovaActivity)cordova.getActivity();
                        act.loadUrl("javascript:cordova.fireDocumentEvent('rangeChanged');");
                    }
                });
                
                barLayout.addView(rangeBar);
            }
            localWindowManager.addView(barLayout , layoutParams);
            return true;
        }else if(action.equals(ACTION_HIDE_SLIDER)){
            //hides the visible range slider
            WindowManager localWindowManager = (WindowManager)cordova.getActivity().getSystemService("window");
            localWindowManager.removeView(barLayout);
            return true;
        }else if(action.equals(ACTION_GET_MIN)){
            //returns the min value ofrange slider
            if(_isMonoSlider){
                _minValue = 0;
            }else{
                _minValue = rangeBar.getSelectedMinValue();
            }
            callbackContext.success(_minValue);
            return true;
        }else if(action.equals(ACTION_GET_MAX)){
            //returns the max value of range slider 
            if(_isMonoSlider){
                _maxValue = monoBar.getProgress();
            }else{
                _maxValue = rangeBar.getSelectedMaxValue();
            }
            callbackContext.success(_maxValue);;
            return true;
        }
        
        
        return false;
    }
}