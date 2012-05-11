package edu.smu.guildhall.nativegl2;

import android.app.Activity;
import android.os.Bundle;

public class NativeGL2Activity extends Activity {

    GL2SurfaceView mView;

    @Override protected void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        mView = new GL2SurfaceView(getApplication());
	setContentView(mView);
    }

    @Override protected void onPause() {
        super.onPause();
        mView.onPause();
    }

    @Override protected void onResume() {
        super.onResume();
        mView.onResume();
    }
}
