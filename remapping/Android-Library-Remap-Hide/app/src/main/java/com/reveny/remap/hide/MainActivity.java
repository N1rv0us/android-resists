package com.reveny.remap.hide;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {
    private Button button = null;

    static {
        System.loadLibrary("RevenyInjector");
    }

    public native void Load(String nativeLibDir);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        button = (Button) findViewById(R.id.bt_my);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Load(MainActivity.this.getApplicationInfo().nativeLibraryDir);
            }
        });
    }
}