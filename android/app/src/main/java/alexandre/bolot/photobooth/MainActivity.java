/*.........................................................................
 . Copyright (c)
 .
 . The MainActivity class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 11/9/19 9:50 PM
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

package alexandre.bolot.photobooth;


import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.content.FileProvider;

import java.io.File;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String SHARE_CHANNEL = "channel:alexandre.bolot/share_image";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(this.getFlutterView(), SHARE_CHANNEL).setMethodCallHandler((methodCall, result) -> {
            if (methodCall.method.equals("shareFilePath")) {
                shareFilePath((String) methodCall.arguments);
            }
            if (methodCall.method.equals("shareFile")) {
                shareFile((File) methodCall.arguments);
            }
        });
    }

    private void shareFile(File file) {
        Uri contentUri = FileProvider.getUriForFile(this, "alexandre.bolot", file);
        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType("image/jpg");
        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
        this.startActivity(Intent.createChooser(shareIntent, "Share image using"));
    }


    private void shareFilePath(String path) {
        File imageFile = new File(getApplicationContext().getCacheDir(), path);
        Uri contentUri = FileProvider.getUriForFile(this, "alexandre.bolot", imageFile);
        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType("image/jpg");
        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
        this.startActivity(Intent.createChooser(shareIntent, "Share image using"));
    }
}
