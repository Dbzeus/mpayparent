package com.example.mpayparent

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity

import com.paysprint.onboardinglib.activities.HostActivity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.app.Activity

class MainActivity : FlutterActivity() {
    val resultObj = null;
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "mpayy.com/onBoarding/retailer"
        ).setMethodCallHandler { call, result ->
            if (call.method == "onBoardingRetailer") {

                val intent = Intent(applicationContext, HostActivity::class.java)
                intent.putExtra("pId", call.argument('pId'))
                intent.putExtra("pApiKey", call.argument('pApiKey'))
                intent.putExtra(
                    "mCode",
                    call.argument('mCode')
                ) //merchant unique code and should not contain special character
                intent.putExtra("mobile", call.argument('mobile')) // merchant mobile no.
                intent.putExtra("lat", call.argument('lat'))
                intent.putExtra("lng", call.argument('lng'))
                intent.putExtra("firm", call.argument('firm'))
                intent.putExtra("email", call.argument('email'))
                intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
                startActivityForResult(intent, 999)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 999) {
            if (resultCode == Activity.RESULT_OK) {
                val status = data?.getBooleanExtra("status", false)
                val response = data?.getIntExtra("response", 0)
                val message = data?.getStringExtra("message")
                val detailedResponse = "Status: $status,  " +
                        "Response: $response, " +
                        "Message: $message "
                Toast.makeText(applicationContext, message, Toast.LENGTH_LONG).show()
                Log.i(logTag, detailedResponse)
                resultObj.success(detailedResponse)
            }
        }
    }
}
