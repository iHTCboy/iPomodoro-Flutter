package com.iHTCboy.iPomodoro

import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import android.webkit.WebView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat

class AppWebviewAvtivity : AppCompatActivity() {
    //定义变量
    private var myWebView: WebView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview_layout)
        myWebView = findViewById(R.id.webView) as WebView
        // 设置与Js交互的权限
//        myWebView!!.settings.javaScriptEnabled = true
//        //文本编码
//        myWebView!!.settings.defaultTextEncodingName = "utf-8"
//        //设置DOM存储已启用（注释后文本显示变成js代码）
//        myWebView!!.settings.domStorageEnabled = true
        // 设置允许JS弹窗
        //myWebView.settings.javaScriptCanOpenWindowsAutomatically = true
        // 先载入JS代码
        // 格式规定为:file:///android_asset/文件名.html
        myWebView!!.loadUrl("file:///android_asset/privacy_policy.html")
//        mWebView!!.loadData(resources.getString(R.string.privacy_policy), "text/html", "base64")
    }

//    private fun setupStatusBar() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            //需要设置这个 flag 才能调用 setStatusBarColor 来设置状态栏颜色
//            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
//            window.statusBarColor = ContextCompat.getColor(this, R.color.colorPrimaryDark)
//        }
//    }
}