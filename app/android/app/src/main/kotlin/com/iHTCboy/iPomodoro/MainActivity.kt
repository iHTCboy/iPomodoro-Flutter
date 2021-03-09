package com.iHTCboy.iPomodoro

import android.Manifest
import android.app.Activity
import android.content.ContentResolver
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.content.pm.PackageManager
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.view.WindowManager
import androidx.appcompat.app.AlertDialog
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import me.leolin.shortcutbadger.ShortcutBadger
import java.util.*

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "iPomodoro").setMethodCallHandler { call, result ->
            if ("drawableToUri" == call.method) {
                val resourceId = this@MainActivity.resources.getIdentifier(call.arguments as String, "drawable", this@MainActivity.packageName)
                result.success(resourceToUriString(this@MainActivity.applicationContext, resourceId))
            }
            if ("getAlarmUri" == call.method) {
                result.success(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM).toString())
            }
            if ("timeZone" == call.method) {
                result.success(TimeZone.getDefault().id)
            }

            if ("brightness" == call.method) {
                val getBrightness = call.argument<String>("getBrightness")
                if (getBrightness == null) {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                var screenBrightness: Float = window.attributes.screenBrightness
                screenBrightness = if (screenBrightness != -1.0F) screenBrightness else 0.5F
                if (getBrightness == "1") {
                    result.success(screenBrightness)
                    return@setMethodCallHandler
                }
                //小于0或大于1.0默认为系统亮度
                val bright = (call.argument<String>("brightness") as? String) ?: "0.5";
                val brightness = bright.toFloat()
                //改变系统屏幕亮度
                changeSystemBrightness(brightness)
                result.success(brightness)
            }

            if ("idleTimer" == call.method) {
                val idleTimer = call.argument<Boolean>("idleTimer")
                if (idleTimer == null) {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                if (idleTimer) {
                    window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                } else {
                    window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                }
                result.success(idleTimer)
            }

            if ("badgeNumber" == call.method) {
                val badgeNumber = call.argument<Int>("badgeNumber")
                if (badgeNumber == null) {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                if (badgeNumber > 0) {
                    ShortcutBadger.applyCount(this@MainActivity.applicationContext, badgeNumber)
                } else {
                    ShortcutBadger.removeCount(this@MainActivity.applicationContext)
                }

                result.success(badgeNumber)
            }

            if ("version" == call.method) {
                val appVersion = "${getAppVersionName()}(${getAppVersionCode()})"
                result.success(appVersion)
            }

            if ("email" == call.method) {
                val appName = call.argument<String>("appname")
                val title = "${appName} Feedback"
                val appVersion = "${getAppVersionName()}(${getAppVersionCode()})"
                val systemVersion = "${android.os.Build.VERSION.RELEASE}(${android.os.Build.VERSION.SDK_INT})"
                val deviceInfo = "${android.os.Build.BRAND}(${android.os.Build.MANUFACTURER}) - ${android.os.Build.MODEL}"
                val message = """欢迎来信，写下你的问题吧~
                    当前 ${appName} 版本 ${appVersion}，系统版本：v${systemVersion}，设备信息：${deviceInfo} """
                val emialIntent: Intent = Intent().apply {
                    action = Intent.ACTION_SENDTO
                    setData(Uri.parse("mailto:${call.argument<String>("email")}"))
                    putExtra(Intent.EXTRA_SUBJECT, title)
                    putExtra(Intent.EXTRA_TEXT, message)
                }
                startActivity(emialIntent)
            }

            if ("shareApp" == call.method) {
                //[将简单的数据发送给其他应用](https://developer.android.com/training/sharing/send?hl=zh-cn)
                println(call.arguments)
                val sendIntent: Intent = Intent().apply {
                    action = Intent.ACTION_SEND
                    putExtra(Intent.EXTRA_TEXT, call.argument<String>("content"))
                    type = "text/plain"
                }
                val shareIntent = Intent.createChooser(sendIntent, null)
                startActivity(shareIntent)
                result.success("share success")
            }

            if ("gotoStoreReview" == call.method) {
                gotoStoreReview()
                result.success("success")
            }

            if ("requestReview" == call.method) {
                gotoStoreReview()
                result.success("success")

                ///[集成应用内评价（Kotlin 或 Java）](https://developer.android.com/guide/playcore/in-app-review/kotlin-java?hl=zh-cn#kotlin)
//                val isPlayStoreInstalled =  context.packageManager.getPackageInfo("com.android.vending", 0)
//                val lollipopOrLater = Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP
//                if (isPlayStoreInstalled != null && lollipopOrLater) {
//                    val manager = ReviewManagerFactory.create(context)
//                    val request = manager.requestReviewFlow()
//                    request.addOnCompleteListener { task ->
//                        if (task.isSuccessful) {
//                            // We got the ReviewInfo object
//                            val reviewInfo = task.result
//                            val flow = manager.launchReviewFlow(activity, reviewInfo)
//                            flow.addOnCompleteListener { _ ->
//                                // The flow has finished. The API does not indicate whether the user
//                                // reviewed or not, or even whether the review dialog was shown. Thus, no
//                                // matter the result, we continue our app flow.
//                            }
//                        } else {
//                            // There was some problem, continue regardless of the result.
//                        }
//                    }
//                }
            }

            if ("privacy_policy" == call.method) {
                val intent = Intent(this, AppWebviewAvtivity::class.java)
                startActivity(intent)
            }

            if ("device_type" == call.method) {
                if (DeviceUtils.isEMUI) {
                    result.success("hw")
                    return@setMethodCallHandler
                }

                if (DeviceUtils.isMIUI) {
                    result.success("xm")
                    return@setMethodCallHandler
                }

                result.success("success")
            }
        }

    }

    private fun gotoStoreReview() {
        val uri = Uri.parse("market://details?id=$packageName")
        val intent = Intent(Intent.ACTION_VIEW, uri)
        //intent.setPackage("com.xiaomi.market")
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }

    private fun getAppVersionCode(): Long {
        val versionCodde: Long =
                // avoid huge version numbers and you will be ok
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    packageManager.getPackageInfo(packageName, 0).longVersionCode
                } else {
                    packageManager.getPackageInfo(packageName, 0).versionCode.toLong()
                }
        return versionCodde
    }

    private fun getAppVersionName(): String {
        val versionName: String = packageManager.getPackageInfo(packageName, 0).versionName
        return versionName
    }

    private fun changeSystemBrightness(brightness: Float) {
        if (hasPermissionsToWriteSettings(this)) {
            //println("已获取权限")
            val lp = window.attributes
            lp.screenBrightness = brightness
            window.attributes = lp
        } else {
            //shortToast("你拒绝了权限")
            //println("你拒绝了权限")
            val msg = "更改屏幕亮度，需要先允许修改系统亮度权限，是否允许？"
            AlertDialog.Builder(this, R.style.DialogTheme)
                    .setMessage(msg)
                    .setTitle("提示")
                    .setPositiveButton("是", DialogInterface.OnClickListener { dialogInterface, i ->
                        val intent = with(Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)) {
                            data = Uri.parse("package:$packageName")
                            this
                        }
                        startActivityForResult(intent, 100)
                        //Toast.makeText(this@MainActivity, "成功", Toast.LENGTH_SHORT).show()
                    })
                    .setNegativeButton("否", null)
                    .create()
                    .show()
        }
    }

    private fun hasPermissionsToWriteSettings(context: Activity): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.System.canWrite(context)
        } else {
            ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_SETTINGS) == PackageManager.PERMISSION_GRANTED
        }
    }

    private fun resourceToUriString(context: Context, resourceId: Int): String? {
        return (ContentResolver.SCHEME_ANDROID_RESOURCE + "://"
                + context.resources.getResourcePackageName(resourceId)
                + "/"
                + context.resources.getResourceTypeName(resourceId)
                + "/"
                + context.resources.getResourceEntryName(resourceId))
    }
}